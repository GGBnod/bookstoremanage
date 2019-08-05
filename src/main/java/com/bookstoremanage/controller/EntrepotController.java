package com.bookstoremanage.controller;//package com.bookstoremanage.controller;

import com.bookstoremanage.pojo.Category;
import com.bookstoremanage.pojo.Details;
import com.bookstoremanage.pojo.Entrepot;
import com.bookstoremanage.pojo.Staff;
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
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
@Controller
@RequestMapping("")
public class EntrepotController {
    @Autowired
    EntrepotService entrepotService;

    @Autowired
    DetailsService detailsService;

    @Autowired
    StaffService staffService;

    @Autowired
    BookService bookService;

    @RequestMapping("admin_entrepot_list")
    public String list(Model model, com.bookstoremanage.util.Page page){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<Entrepot> es = entrepotService.list();

        int total = (int) new PageInfo<>(es).getTotal();
        page.setTotal(total);
        entrepotService.fill(es);
        model.addAttribute("es", es);
        model.addAttribute("page", page);
        return "admin/listEntrepot";
    }

    @RequestMapping("admin_entrepot_add")
    public String add(@RequestParam(required = false) Integer id , Model model, HttpSession session) throws IOException {
        Entrepot e;
        if (null != id) {
            e = entrepotService.get(id);
        } else {
            e = new Entrepot();
            entrepotService.add(e);
            id = e.getId();
        }
        e.setDs(detailsService.list(id));
        model.addAttribute("e", e);
        return "admin/addEntrepot";
    }

    @RequestMapping("admin_entrepot_detailsInAndOut")
    public String detailsInAndOut(Integer eid ,String num ,String staffName , Details details, Model model, HttpSession session) throws IOException {
        Entrepot e = entrepotService.get(eid);

        if (null == entrepotService.get(num))
            e.setNum(num);
        else
            e.setNum(null);
        if (null != staffName && 0 != staffName.length()){
            Staff staff = staffService.get(staffName);
            e.setStaff(staff);
        }

        details.setEntrepot(e);
        details.setOutdate(new Date());
        detailsService.add(details);

        if(details.getInAndOut().equals("入库")){
            Integer enterNumber = e.getEnterNumber();
            if (null == enterNumber)
                enterNumber = 0;
            enterNumber += details.getNumber();
            e.setEnterNumber(enterNumber);
        }
        if (details.getInAndOut().equals("出库")){
            Integer outNumber = e.getOutNumber();
            if (null == outNumber)
                outNumber = 0;
            outNumber += details.getNumber();
            e.setOutNumber(outNumber);
        }
        entrepotService.update(e);
        return "redirect:/admin_entrepot_edit?eid="+eid;
    }

    @RequestMapping("admin_entrepot_edit")
    public String edit(Integer eid , Model model, HttpSession session) throws IOException {
        Entrepot e = entrepotService.get(eid);
        List<Details> ds = detailsService.list(eid);
        e.setDs(ds);
        model.addAttribute("e", e);
        return "admin/addEntrepot";
    }

    @RequestMapping("admin_entrepot_update")
    public String update(String staffName, Entrepot entrepot , Model model, HttpSession session) throws IOException {
        Staff staff = staffService.get(staffName);
        entrepot.setSid(staff.getId());
        entrepot.setComplete(new Date());
        entrepotService.update(entrepot);

        List<Details> ds = detailsService.list(entrepot.getId());
        bookService.addStock(ds);
        return "redirect:/admin_entrepot_list";
    }

    @RequestMapping("admin_entrepot_see")
    public String see(Integer eid , Model model, HttpSession session) throws IOException {
        Entrepot e = entrepotService.get(eid);
        List<Details> ds = detailsService.list(eid);
        e.setDs(ds);
        Staff s = staffService.get(e.getSid());
        e.setStaff(s);
        model.addAttribute("e", e);
        return "admin/seeEntrepot";
    }

    @RequestMapping("admin_entrepot_detailsDelete")
    public String detailsDelete(Integer id , Model model, HttpSession session) throws IOException {
        Details details = detailsService.get(id);
        detailsService.delete(id);
        return "redirect:/admin_entrepot_edit?eid="+details.getEid();
    }

    @RequestMapping("admin_entrepot_detailsEdit")
    public String detailsEdit(Integer id , Model model, HttpSession session) throws IOException {
        Details details = detailsService.get(id);
        model.addAttribute("d",details);
        return "admin/editDetails";
    }

    @RequestMapping("admin_entrepot_detailsUpdate")
    public String detailsUpdate(Details details , Model model, HttpSession session) throws IOException {
        detailsService.update(details);
        return "redirect:/admin_entrepot_edit?eid="+details.getEid();
    }

}