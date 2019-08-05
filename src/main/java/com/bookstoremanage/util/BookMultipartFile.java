package com.bookstoremanage.util;

import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public class BookMultipartFile  {

List<MultipartFile> bms;

public List<MultipartFile> getBms(){
	return this.bms;
}

	public void setBms(List<MultipartFile> bms){
		this.bms=bms;
	}
}
