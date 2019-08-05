package com.bookstoremanage.controller;//package com.bookstoremanage.controller;

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
public class MinceController {
    @Autowired
    CategoryService categoryService;

    @Autowired
    MinceService minceService;

    @Autowired
    BookService bookService;

    @RequestMapping("admin_mince_list")
    public String list(Model model,int cid , com.bookstoremanage.util.Page page){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<Mince> ms = minceService.list(cid);
        Category c = categoryService.get(cid);
        int total = (int) new PageInfo<>(ms).getTotal();
        page.setTotal(total);
        minceService.fillNunmer(ms);
        model.addAttribute("ms", ms);
        model.addAttribute("c", c);
        model.addAttribute("page", page);
        return "admin/listMince";
    }

    @RequestMapping("admin_mince_add")
    public String add(Model model,Mince m) throws IOException {
        minceService.add(m);
        return "redirect:/admin_mince_list?cid="+m.getCid();
    }

    @RequestMapping("admin_mince_delete")
    public String delete(int id, HttpSession session)throws IOException {
        Mince m = minceService.get(id);
        if (0 == bookService.list(id).size())
            minceService.delete(id);
        return "redirect:/admin_mince_list?cid="+m.getCid();
    }

    @RequestMapping("admin_mince_edit")
    public String edit(Model model,int id){
        Mince m =minceService.get(id);
        List<Category> cs = categoryService.listName();
        model.addAttribute("m", m);
        model.addAttribute("cs", cs);
        return "admin/editMince";
    }

    @RequestMapping("admin_mince_update")
    public String update(Mince m, HttpSession session) throws IOException {
        minceService.update(m);
        return "redirect:/admin_mince_list?cid="+m.getCid();
    }

}