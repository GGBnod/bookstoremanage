package com.bookstoremanage.comparator;

import com.bookstoremanage.pojo.Book;

import java.util.Comparator;


public class BookPriceComparator implements Comparator<Book>{

	@Override
	public int compare(Book p1, Book p2) {
		// TODO Auto-generated method stub
		return (int)(p1.getPrice()-p2.getPrice());
	}

}
