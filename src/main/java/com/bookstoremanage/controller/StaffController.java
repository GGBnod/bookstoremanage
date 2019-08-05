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
public class StaffController {
    @Autowired
    StaffService staffService;

    @Autowired
    MinceService minceService;

    @Autowired
    CategoryService categoryService;

    @Autowired
    PurchaseService purchaseService;

    @Autowired
    EntrepotService entrepotService;

    @RequestMapping("admin_staff_list")
    public String list(@RequestParam(required = false) String department, Model model, com.bookstoremanage.util.Page page){
        PageHelper.offsetPage(page.getStart(),page.getCount());

        if ((null != department) && (!"all".equals(department))) {
            department = staffService.y2z(department);
            List<Staff> ss = staffService.list(department);
            int total = (int) new PageInfo<>(ss).getTotal();
            page.setTotal(total);
            String identifier = staffService.increase(ss.get(0).getIdentifier());
            model.addAttribute("ss", ss);
            model.addAttribute("page", page);
            model.addAttribute("department", department);
            model.addAttribute("identifier", identifier);
            return "admin/listStaff";
        }

        List<Staff> ss = staffService.list();
        int total = (int) new PageInfo<>(ss).getTotal();
        page.setTotal(total);
        model.addAttribute("ss", ss);
        model.addAttribute("page", page);
        return "admin/listStaff";
    }

    @RequestMapping("admin_staff_add")
    public String add(Staff s, HttpSession session, MultipartFile image) throws IOException {
        staffService.add(s);

        File imageFolder = new File(session.getServletContext().getRealPath("img/staff"));
        File file = new File(imageFolder, s.getId() + ".jpg");

        if(!file.getParentFile().exists())
            file.getParentFile().mkdirs();
        image.transferTo(file);
        BufferedImage img = ImageUtil.change2jpg(file);
        ImageIO.write(img, "jpg", file);
        System.out.println(s.getDepartment());
        return "redirect:/admin_staff_list?department="+staffService.y2z(s.getDepartment());
    }

    @RequestMapping("admin_staff_delete")
    public String delete(int id, HttpSession session)throws IOException {
        staffService.delete(id);
        File imageFolder = new File(session.getServletContext().getRealPath("img/staff"));
        File file = new File(imageFolder, id + ".jpg");
        file.delete();
        return "redirect:/admin_staff_list?d";
    }

    @RequestMapping("admin_staff_edit")
    public String edit(Model model,int id){
        Staff s = staffService.get(id);
        List<String> departments = staffService.sort(s.getDepartment());
        model.addAttribute("s", s);
        model.addAttribute("departments", departments);
        return "admin/editStaff";
    }

    @RequestMapping("admin_staff_update")
    public String update(Staff s, HttpSession session, MultipartFile image) throws IOException {
        staffService.update(s);

        if(null!=image &&!image.isEmpty()){
            File  imageFolder= new File(session.getServletContext().getRealPath("img/staff"));
            File file = new File(imageFolder,s.getId()+".jpg");
            image.transferTo(file);
            BufferedImage img = ImageUtil.change2jpg(file);
            ImageIO.write(img, "jpg", file);
        }

        return "redirect:/admin_staff_list";
    }
    @RequestMapping("admin_staff_purchase")
    public String purchase(Model model) {
        List<Book> bs = new ArrayList<>();
        List<Mince> ms = minceService.list();
        for (Mince m :
                ms) {
            m.setCategory(categoryService.get(m.getCid()));
        }
        List<Category> cs = categoryService.listName();
        for (int i = 0; i < 100; i++) {
            bs.add(new Book());
        }
        model.addAttribute("bs", bs);
        model.addAttribute("cs", cs);
        model.addAttribute("ms", ms);

        return "admin/applyStaff";
    }

    @RequestMapping("admin_staff_check")
    public void check( HttpServletResponse response, Model model, @RequestParam(required = false) String number, @RequestParam(required = false) String name,@RequestParam(required = false)String g_num, HttpSession session){
        StringBuilder sb = new StringBuilder();
        PrintWriter out = null;
        try {
            //设置相应的编码
            response.setContentType("text/html; charset=UTF-8");
            //获取打印流对象
            out = (PrintWriter) response.getWriter();
        }
        catch (Exception e) {
            System.out.println("check错误");
        }
        out.flush();


        if (null != name && 0 != name.length()) {
            Staff staff =staffService.get(name);
             if (null == staff) {
                 out.print("<font id='checkName' color='red'>非员工姓名</font>");
             } else {
                 out.print("<font id='checkName' color='green'>是员工姓名</font>");
             }
        }

         if (null != number && 0 != number.length()) {
             Purchase purchase = purchaseService.get(number);
             if (null == purchase) {
                 out.print("<font id='checkNumber' color='green'>可以使用</font>");
             } else
                 out.print("<font id='checkNumber' color='red'>已经存在</font>");
         }

        if (null != g_num && 0 != g_num.length()) {
            System.out.println(3);
            Entrepot entrepot = entrepotService.get(g_num);
            System.out.println("entrepot:"+entrepot);
            if (null == entrepot) {
                out.print("<font id='checkNum' color='green'>可以使用</font>");
            } else
                out.print("<font id='checkNum' color='red'>已经存在</font>");
        }

        out.close();//关闭流资源
    }

    @RequestMapping("admin_staff_backgroundLogin")
    public String backgroundLogin(String identifier, String password, HttpSession session, Model model) {
        if (null == identifier && null == password){
            return "admin/backgroundLogin";
        }

       Staff staff = staffService.get(identifier, password);
        if (null != staff) {
            session.setAttribute("staff", staff);
            String site = staffService.site(staff.getDepartment());
            return site;
        }
        model.addAttribute("msg", "账号密码错误");
        return "admin/backgroundLogin";
    }

    @RequestMapping("admin_staff_logout")
    public String loguot(String identifier, String password, HttpSession session, Model model) {
        session.removeAttribute("staff");
        return "admin/backgroundLogin";
    }
}