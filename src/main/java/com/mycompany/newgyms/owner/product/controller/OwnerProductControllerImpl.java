package com.mycompany.newgyms.owner.product.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.newgyms.member.vo.MemberVO;
import com.mycompany.newgyms.owner.product.service.OwnerProductService;
import com.mycompany.newgyms.product.vo.ProductImageVO;
import com.mycompany.newgyms.product.vo.ProductOptVO;
import com.mycompany.newgyms.product.vo.ProductVO;

@Controller("ownerProductController")
@RequestMapping(value = "/owner/product")
public class OwnerProductControllerImpl implements OwnerProductController {
	private static final String CURR_IMAGE_REPO_PATH = "C:\\newgyms\\file_repo";
	
	@Autowired
	private OwnerProductService ownerProductService;

	// ����� ��ǰ ���
	@RequestMapping(value = "/ownerProductList.do", method = RequestMethod.GET)
	public ModelAndView ownerProductList(@RequestParam("member_id") String member_id, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);

		List<ProductVO> ownerProductList = ownerProductService.ownerProductList(member_id);

		mav.addObject("ownerProductList", ownerProductList);
		return mav;
	}

	@Override
	@RequestMapping(value= { "/addProductForm.do"}, method = RequestMethod.GET)
	public ModelAndView addProductForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String)request.getAttribute("viewName"); 
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		return mav;
	}
	
	@Override
	@RequestMapping(value="/addNewProduct.do" ,method={RequestMethod.POST})
	public ResponseEntity addNewProduct(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)  throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		String fileName=null;
		
		Map newProductMap = new HashMap();
		Enumeration enu=multipartRequest.getParameterNames();
		while(enu.hasMoreElements()){
			String name=(String)enu.nextElement();
			String value=multipartRequest.getParameter(name);
			newProductMap.put(name,value);
		}
		
		//�Ǹ��� member_id ���ǿ��� �������� 
		HttpSession session = multipartRequest.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		String member_id = memberVO.getMember_id();
		newProductMap.put("member_id",member_id);
		
		//��ǰ ��� �� sale_yn�� 0(���δ��)
		int sale_yn = 0;
		newProductMap.put("sale_yn",sale_yn);
		
		
		/* �ɼ� */
		List<ProductOptVO> optionList=(List<ProductOptVO>)session.getAttribute("optionList");
		System.out.println(optionList);
		/* �̹���
		List<ProductImageVO> imageList =upload(multipartRequest);
		if(imageList!= null && imageList.size()!=0) {
			newProductMap.put("imageList", imageList);
		}
		 * */
		
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			int product_id = ownerProductService.addNewProduct(newProductMap);
			/*�̹���
			if(imageList!=null && imageList.size()!=0) {
				for(ProductImageVO  productImageVO:imageList) {
					fileName = productImageVO.getFileName();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+ "product"+"\\"+"temp"+"\\"+fileName);
					File destDir = new File(CURR_IMAGE_REPO_PATH+"\\"+ "product"+"\\"+product_id);
					FileUtils.moveFileToDirectory(srcFile, destDir,true);
				}
			}
			 * */
			message= "<script>";
			message += " alert('����ǰ�� �߰��߽��ϴ�.');";
			message +=" location.href='"+multipartRequest.getContextPath()+"/owner/product/ownerProductList.do';";
			message +=("</script>");
		}catch(Exception e) {
			/*�̹���
			if(imageList!=null && imageList.size()!=0) {
				for(ProductImageVO  imageFileVO:imageList) {
					fileName = imageFileVO.getFileName();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+ "product"+"\\"+"temp"+"\\"+fileName);
					srcFile.delete();
				}
			}
			 * */
			
			message= "<script>";
			message += " alert('������ �߻��߽��ϴ�. �ٽ� �õ��� �ּ���');";
			message +=" location.href='"+multipartRequest.getContextPath()+"/owner/product/ownerProductList.do';";
			message +=("</script>");
			e.printStackTrace();
		}
		resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
	
	//�̹��� ���ε� �ϱ�
	protected List<ProductImageVO> upload(MultipartHttpServletRequest multipartRequest) throws Exception{
		List<ProductImageVO> fileList= new ArrayList<ProductImageVO>();
		Iterator<String> fileNames = multipartRequest.getFileNames();
		while(fileNames.hasNext()){
			ProductImageVO imageFileVO =new ProductImageVO();
			String fileName = fileNames.next();
			imageFileVO.setFileType(fileName);
			MultipartFile mFile = multipartRequest.getFile(fileName);
			String originalFileName=mFile.getOriginalFilename();
			imageFileVO.setFileName(originalFileName);
			fileList.add(imageFileVO);
			
			File file = new File(CURR_IMAGE_REPO_PATH +"\\"+ "product"+"\\"+ fileName);
			if(mFile.getSize()!=0){ //File Null Check
				if(! file.exists()){ //��λ� ������ �������� ���� ���
					if(file.getParentFile().mkdirs()){ //��ο� �ش��ϴ� ���丮���� ����
							file.createNewFile(); //���� ���� ����
					}
				}
				mFile.transferTo(new File(CURR_IMAGE_REPO_PATH +"\\"+ "product"+"\\"+"temp"+ "\\"+originalFileName)); //�ӽ÷� ����� multipartFile�� ���� ���Ϸ� ����
			}
		}
		return fileList;
	}
	
	

}