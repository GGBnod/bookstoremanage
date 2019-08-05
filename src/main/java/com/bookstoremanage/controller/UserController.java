package com.bookstoremanage.controller;//package com.bookstoremanage.controller;

import com.bookstoremanage.pojo.*;
import com.bookstoremanage.service.*;
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
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
@Controller
@RequestMapping("")
public class UserController {
    @Autowired
    UserService userService;

    @RequestMapping("admin_user_list")
    public String list( Model model, com.bookstoremanage.util.Page page){
        PageHelper.offsetPage(page.getStart(),page.getCount());

        List<User> us = userService.list();
        int total = (int) new PageInfo<>(us).getTotal();
        page.setTotal(total);
        model.addAttribute("us", us);
        model.addAttribute("page", page);
        return "admin/listUser";
    }

    @RequestMapping("admin_user_add")
    public String add(Staff s, HttpSession session, MultipartFile image) throws IOException {
        return "redirect:/admin_user_list";
    }

    @RequestMapping("admin_user_delete")
    public String delete(int id, HttpSession session)throws IOException {
        return "redirect:/admin_user_list";
    }

    @RequestMapping("admin_user_edit")
    public String edit(Model model,int id){
        return "redirect:/admin_user_list";
    }

    @RequestMapping("admin_user_update")
    public String update(User u, HttpSession session) throws IOException {
//        if (!"vip".equals(u.getVip()))
//            u.setVip("普通会员");
        userService.update(u);
        return "redirect:/admin_user_list";
    }
}