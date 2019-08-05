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
import java.util.Date;
import java.util.List;
@Controller
@RequestMapping("")
public class OrderController {
    @Autowired
    OrderService orderService;

    @Autowired
    OrderItemService orderItemService;

    @RequestMapping("admin_order_list")
    public String list( Model model, com.bookstoremanage.util.Page page){
        PageHelper.offsetPage(page.getStart(),page.getCount());

        List<Order> os = orderService.list();
        int total = (int) new PageInfo<>(os).getTotal();
        orderItemService.fill(os);
        page.setTotal(total);
        model.addAttribute("os", os);
        model.addAttribute("page", page);
        return "admin/listOrder";
    }

    @RequestMapping("admin_order_delivery")
    public String delivery(Integer id, HttpSession session) throws IOException {
        Order o = orderService.get(id);
        o.setDeliveryDate(new Date());
        o.setStatus(OrderService.waitConfirm);
        orderService.update(o);
        return "redirect:/admin_order_list";
    }

    @RequestMapping("admin_order_add")
    public String add(Staff s, HttpSession session, MultipartFile image) throws IOException {
        return "redirect:/admin_order_list";
    }

    @RequestMapping("admin_order_delete")
    public String delete(int id, HttpSession session)throws IOException {
        return "redirect:/admin_order_list";
    }

    @RequestMapping("admin_order_edit")
    public String edit(Model model,int id){
        return "redirect:/admin_order_list";
    }

    @RequestMapping("admin_order_update")
    public String update(HttpSession session) throws IOException {
        return "redirect:/admin_order_list";
    }
}