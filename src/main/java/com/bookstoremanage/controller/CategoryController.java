package com.bookstoremanage.controller;//package com.bookstoremanage.controller;

import com.bookstoremanage.pojo.Category;
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
public class CategoryController {
    @Autowired
    CategoryService categoryService;

    @Autowired
    MinceService minceService;

    @Autowired
    BookService bookService;

    @RequestMapping("admin_category_list")
    public String list(Model model, com.bookstoremanage.util.Page page){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<Category> cs = categoryService.list();

        int total = (int) new PageInfo<>(cs).getTotal();
        page.setTotal(total);
        model.addAttribute("cs", cs);
        model.addAttribute("page", page);
        return "admin/listCategory";
    }

    @RequestMapping("admin_category_add")
    public String add(Category c, HttpSession session) throws IOException {
        categoryService.add(c);
        return "redirect:/admin_category_list";
    }

    @RequestMapping("admin_category_delete")
    public String delete(int id, HttpSession session)throws IOException {
        if (0 == minceService.list(id).size())
            categoryService.delete(id);
        return "redirect:/admin_category_list";
    }

    @RequestMapping("admin_category_edit")
    public String edit(Model model,int id){
        Category c =categoryService.get(id);
        model.addAttribute("c", c);
        return "admin/editCategory";
    }

    @RequestMapping("admin_category_update")
    public String update(Category c, HttpSession session) throws IOException {
        categoryService.update(c);
        return "redirect:/admin_category_list";
    }

}