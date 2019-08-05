package com.bookstoremanage.comparator;

import java.util.Comparator;

import com.bookstoremanage.pojo.Book;

public class BookAllComparator implements Comparator<Book>{

	@Override
	public int compare(Book b1, Book b2) {
		// TODO Auto-generated method stub
		return b2.getReviewCount()*b2.getSaleCount()-b1.getReviewCount()*b1.getSaleCount();
	}

}
