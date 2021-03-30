package myPackage;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.util.*;
import java.lang.*;
 
import javax.imageio.ImageIO;
 
public class ImageResize {
	
	String imgOriginalPath= "/somunhouse/tomcat/webapps/ROOT/testimg/220.jpg";           // 원본 이미지 파일명
    String imgTargetPath= "/somunhouse/tomcat/webapps/ROOT/testimg/220.jpg";    // 새 이미지 파일명
    String imgFormat = "jpg";                             // 새 이미지 포맷. jpg, gif 등
    int newWidth = 600;                                  // 변경 할 넓이
    int newHeight = 700;                                 // 변경 할 높이
    //String mainPosition = "W";                             // W:넓이중심, H:높이중심, X:설정한 수치로(비율무시)

    Image image;
    int imageWidth;
    int imageHeight;
    double ratio;
    int w;
    int h;
    
    public ImageResize(String Path, int newWidth, int newHeight) {
    	try{
    		this.newWidth = newWidth;
    		this.newHeight = newHeight;
    		//this.mainPosition = mainPosition;
    		this.imgOriginalPath = Path;
    		this.imgTargetPath = Path;
    		
            // 원본 이미지 가져오기
            image = ImageIO.read(new File(imgOriginalPath));
 
            // 원본 이미지 사이즈 가져오기
            imageWidth = image.getWidth(null);
            imageHeight = image.getHeight(null);
 
            if(imageHeight >= imageWidth){ // 높이가 더 크면 넓이를 맞추기
 
                ratio = (double)newWidth/(double)imageWidth;
                w = (int)(imageWidth * ratio);
                h = (int)(imageHeight * ratio);
 
            }else { // 넓이가 더 크면 높이를 맞추기
 
                ratio = (double)newHeight/(double)imageHeight;
                w = (int)(imageWidth * ratio);
                h = (int)(imageHeight * ratio);
 
            }
            
            //이미지포맷 찾기
            imgFormat = imgOriginalPath.substring(imgOriginalPath.indexOf(".")+1); //. 뒤 부터끝까지
 
            // 이미지 리사이즈
            // Image.SCALE_DEFAULT : 기본 이미지 스케일링 알고리즘 사용
            // Image.SCALE_FAST    : 이미지 부드러움보다 속도 우선
            // Image.SCALE_REPLICATE : ReplicateScaleFilter 클래스로 구체화 된 이미지 크기 조절 알고리즘
            // Image.SCALE_SMOOTH  : 속도보다 이미지 부드러움을 우선
            // Image.SCALE_AREA_AVERAGING  : 평균 알고리즘 사용
            Image resizeImage = image.getScaledInstance(w, h, Image.SCALE_SMOOTH);
 
            // 새 이미지  저장하기
            BufferedImage newImage = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
            Graphics g = newImage.getGraphics();
            g.drawImage(resizeImage, 0, 0, null);
            g.dispose();
            ImageIO.write(newImage, imgFormat, new File(imgTargetPath));
            
            System.out.println("done!");
 
        }catch (Exception e){
 
            e.printStackTrace();
 
        }

    }
 
}