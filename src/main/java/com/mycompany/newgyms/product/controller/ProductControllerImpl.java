package com.mycompany.newgyms.product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.newgyms.member.vo.MemberVO;
import com.mycompany.newgyms.product.service.ProductService;
import com.mycompany.newgyms.product.vo.ProductVO;
import com.mycompany.newgyms.review.service.ReviewService;
import com.mycompany.newgyms.review.vo.ReviewVO;

@Controller("productController")
@RequestMapping(value = "/product")
public class ProductControllerImpl implements ProductController {
	@Autowired
	private ProductService productService;

	@Autowired
	private ReviewService reviewService;

	/* 상품검색 추가 */
	@RequestMapping(value = "/productList.do", method = RequestMethod.GET)
	public ModelAndView productList(@RequestParam("productSort") String product_sort, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		List<ProductVO> productList = productService.productList(product_sort);
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("productList", productList);
		mav.addObject("productSort", product_sort);
		return mav;
	}

	@RequestMapping(value = "/productDetail.do", method = RequestMethod.GET)
	public ModelAndView productDetail(@RequestParam("product_id") String product_id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		HttpSession session = request.getSession();

		/* 제품 정보 가져오기 */
		Map productMap = productService.productDetail(product_id);
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("productMap", productMap);

		
		 /* 제품 리뷰 가져오기 */
		List<ReviewVO> reviewList=reviewService.productReview(product_id); 
		mav.addObject("reviewList",reviewList);


		/* 판매자 정보 가져오기 */
		ProductVO productVO = (ProductVO) productMap.get("productVO");
		String center_name = productVO.getCenter_name();
		MemberVO memberVO = productService.ownerDetail(center_name);
		mav.addObject("memberVO", memberVO);

		String road_address = memberVO.getRoad_address();
		mav.addObject("road_address", road_address);

		/*
		*/
		/* addProductInQuick(product_id,productVO,session); */
		return mav;
	}

	@RequestMapping(value = "/productSorting.do", method = RequestMethod.GET)
	public ModelAndView productSorting(@RequestParam("productSort") String product_sort,
			@RequestParam("sortBy") String sortBy, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		List<ProductVO> productList = productService.productSorting(product_sort, sortBy);
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("productList", productList);
		mav.addObject("productSort", product_sort);
		return mav;
	}

	@RequestMapping(value = "/searchProduct.do", method = RequestMethod.GET)
	public ModelAndView searchProduct(@RequestParam("searchWord") String searchWord, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		List<ProductVO> productList = productService.searchProduct(searchWord);
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("productList", productList);
		mav.addObject("searchWord", searchWord);
		return mav;

	}
	
		
	@RequestMapping(value = "/searchProductByCondition.do", method = RequestMethod.GET)
	public ModelAndView searchProductByCondition(@RequestParam("searchOption") String searchOption, @RequestParam("searchWord") String searchWord, 
			@RequestParam("minPrice") String minPrice, @RequestParam("maxPrice") String maxPrice,HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");	
		
		List<ProductVO> productList = productService.searchProductByCondition(searchOption, searchWord, minPrice, maxPrice);
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("productList", productList);
		mav.addObject("searchWord", searchWord);
		return mav;
		
	}

	/*
	 * @RequestMapping(value="/keywordSearch.do",method = RequestMethod.GET,produces
	 * = "application/text; charset=utf8") public @ResponseBody String
	 * keywordSearch(@RequestParam("keyword") String keyword, HttpServletRequest
	 * request, HttpServletResponse response) throws Exception{
	 * response.setContentType("text/html;charset=utf-8");
	 * response.setCharacterEncoding("utf-8"); //System.out.println(keyword);
	 * if(keyword == null || keyword.equals("")) return null ;
	 * 
	 * keyword = keyword.toUpperCase(); List<String> keywordList
	 * =productService.keywordSearch(keyword);
	 * 
	 * // 최종 완성될 JSONObject 선언(전체) JSONObject jsonObject = new JSONObject();
	 * jsonObject.put("keyword", keywordList);
	 * 
	 * String jsonInfo = jsonObject.toString(); // System.out.println(jsonInfo);
	 * return jsonInfo ; }
	 * 
	 * 
	 * private void addProductInQuick(String product_id,ProductVO
	 * productVO,HttpSession session){ boolean already_existed=false;
	 * List<ProductVO> quickProductList; //최근 본 상품 저장 ArrayList
	 * quickProductList=(ArrayList<ProductVO>)session.getAttribute(
	 * "quickProductList");
	 * 
	 * if(quickProductList!=null){ if(quickProductList.size() < 4){ //미리본 상품 리스트에
	 * 상품개수가 세개 이하인 경우 for(int i=0; i<quickProductList.size();i++){ ProductVO
	 * _productBean=(ProductVO)quickProductList.get(i);
	 * if(product_id.equals(_productBean.getProduct_id())){ already_existed=true;
	 * break; } } if(already_existed==false){ quickProductList.add(productVO); } }
	 * 
	 * }else{ quickProductList =new ArrayList<ProductVO>();
	 * quickProductList.add(productVO);
	 * 
	 * } session.setAttribute("quickProductList",quickProductList);
	 * session.setAttribute("quickProductListNum", quickProductList.size()); }
	 */
}
