package com.bookstoremanage.controller;//package com.bookstoremanage.controller;

import com.bookstoremanage.pojo.Book;
import com.bookstoremanage.pojo.Category;
import com.bookstoremanage.pojo.Mince;
import com.bookstoremanage.service.BookService;
import com.bookstoremanage.service.CategoryService;
import com.bookstoremanage.service.MinceService;
import com.bookstoremanage.util.ImageUtil;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;
@Controller
@RequestMapping("")
public class BookController {

    @Autowired
    CategoryService categoryService;
    @Autowired
    MinceService minceService;
    @Autowired
    BookService bookService;

    @RequestMapping("admin_book_list")
    public String list(Model model,int mid, com.bookstoremanage.util.Page page){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<Book> bs = bookService.list(mid);
        Mince m = minceService.get(mid);
        Category c = m.getCategory();
        int total = (int) new PageInfo<>(bs).getTotal();
        page.setTotal(total);
        model.addAttribute("c", c);
        model.addAttribute("m", m);
        model.addAttribute("bs", bs);
        model.addAttribute("page", page);
        return "admin/listBook";
    }

    @RequestMapping("admin_book_add")
    public String add(Book book, HttpSession session, MultipartFile image) throws IOException {
        book.setBooknumber(bookService.generate());
        bookService.add(book);

        File imageFolder = new File(session.getServletContext().getRealPath("img/book"));
        File file = new File(imageFolder, book.getId() + ".jpg");

        if(!file.getParentFile().exists())
            file.getParentFile().mkdirs();
        image.transferTo(file);
        BufferedImage img = ImageUtil.change2jpg(file);
        ImageIO.write(img, "jpg", file);

        return "redirect:/admin_book_list?mid="+book.getMid();
    }

    @RequestMapping("admin_book_delete")
    public String delete(int id, HttpSession session)throws IOException {
        Book book = bookService.get(id);
        bookService.delete(id);
        File imageFolder = new File(session.getServletContext().getRealPath("img/book"));
        File file = new File(imageFolder, id + ".jpg");
        file.delete();
        return "redirect:/admin_book_list?mid="+book.getMid();
    }

    @RequestMapping("admin_book_edit")
    public String edit(Model model,int id){
        Book b =bookService.get(id);
        model.addAttribute("b", b);
        return "admin/editBook";
    }

    @RequestMapping("admin_book_update")
    public String update(Book book, HttpSession session, MultipartFile image) throws IOException {
        bookService.update(book);

        if(null!=image &&!image.isEmpty()){
            File  imageFolder= new File(session.getServletContext().getRealPath("img/book"));
            File file = new File(imageFolder,book.getId()+".jpg");
            image.transferTo(file);
            BufferedImage img = ImageUtil.change2jpg(file);
            ImageIO.write(img, "jpg", file);
        }

        return "redirect:/admin_book_list?mid="+book.getMid();
    }



}