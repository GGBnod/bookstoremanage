package com.bookstoremanage.controller;//package com.bookstoremanage.controller;

import com.bookstoremanage.pojo.*;
import com.bookstoremanage.service.*;
import com.bookstoremanage.util.BookMultipartFile;
import com.bookstoremanage.util.ImageUtil;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;
@Controller
@RequestMapping("")
public class PurchaseController {
    @Autowired
    PurchaseService purchaseService;

    @Autowired
    MinceService minceService;

    @Autowired
    BookService bookService;

    @Autowired
    StaffService staffService;

    @RequestMapping("admin_purchase_list")
    public String list(Model model,com.bookstoremanage.util.Page page){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<Purchase> ps = purchaseService.list();
        int total = (int) new PageInfo<>(ps).getTotal();
        page.setTotal(total);
        purchaseService.fill(ps);
        model.addAttribute("ps", ps);
        model.addAttribute("page", page);

        return "admin/listPurchase";
    }

    @RequestMapping("admin_purchase_add")
    public String add(Purchase purchase ,HttpSession session, @RequestParam(required = false) String name, Model model,BookMultipartFile bookMultipartFile) throws IOException {
        Staff s = staffService.get(name);
        purchase.setSid(s.getId());
        String opinion = "待定";

        Integer total = 0;
        List<Book> bs = purchase.getBs();
        List<MultipartFile> bms = bookMultipartFile.getBms();
        for (int i = 0 ; i<bs.size();i++) {
            Book book = bs.get(i);
            if (null == book.getName() || book.getName().trim().length() == 0 || book.getName().trim().equals("0"))
                continue;

            book.setBooknumber(purchase.getNumber());
            bookService.add(book);

            File imageFolder = new File(session.getServletContext().getRealPath("img/book"));
            File file = new File(imageFolder, book.getId() + ".jpg");

            if(!file.getParentFile().exists())
                file.getParentFile().mkdirs();
            bms.get(i).transferTo(file);
            BufferedImage img = ImageUtil.change2jpg(file);
            ImageIO.write(img, "jpg", file);

            total += book.getStock();

        }

        purchase.setTotal(total);
        purchase.setOpinion(opinion);
        purchaseService.add(purchase);
        return "redirect:/admin_category_list";
    }

    @RequestMapping("admin_purchase_edit")
    public String edit(Model model,int id){
        Purchase p =purchaseService.get(id);
        List<Book> bs = bookService.listBy(p.getNumber());
        p.setBs(bs);
        model.addAttribute("p", p);
        return "admin/editPurchase";
    }

    @RequestMapping("admin_purchase_update")
    public String update(Purchase purchase, HttpSession session) throws IOException {
        purchaseService.update(purchase);

        return "redirect:/admin_purchase_list";
    }



}