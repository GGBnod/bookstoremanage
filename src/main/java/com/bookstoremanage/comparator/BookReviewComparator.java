package com.bookstoremanage.comparator;

import com.bookstoremanage.pojo.Book;

import java.util.Comparator;

public class BookReviewComparator implements Comparator<Book>{

	@Override
	public int compare(Book b1, Book b2) {
		// TODO Auto-generated method stub
		return b2.getReviewCount()-b1.getReviewCount();
	}

}
