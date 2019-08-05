package com.bookstoremanage.controller;

import com.bookstoremanage.comparator.*;
import com.bookstoremanage.pojo.*;
import com.bookstoremanage.service.*;
import com.github.pagehelper.PageHelper;

import org.apache.commons.lang.math.RandomUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("")
public class ForeController {
    @Autowired
    CategoryService categoryService;
    @Autowired
    BookService bookService;
    @Autowired
    UserService userService;
    @Autowired
    MinceService minceService;
    @Autowired
    OrderService orderService;
    @Autowired
    OrderItemService orderItemService;
    @Autowired
    ReviewService reviewService;
    @Autowired
    InformationService informationService;
    @RequestMapping("forehome")
    public String home(Model model) {
        List<Category> cs= categoryService.list();
        model.addAttribute("cs", cs);
        return "fore/home";
    }

    @RequestMapping("foreregister")
    public String register(HttpSession session,Model model,User user) {
        String name =  user.getName();
        name = HtmlUtils.htmlEscape(name);
        user.setName(name);
        boolean exist = userService.isExist(name);

        if(exist){
            String m ="用户名已经被使用,不能使用";
            model.addAttribute("msg", m);
            return "fore/register";
        }
        user.setVip("普通会员");
        user.setIntegral(0);
        userService.add(user);
        session.setAttribute("user", user);
        return "fore/registerSuccess";
    }

    @RequestMapping("forelogin")
    public String login(@RequestParam("name") String name, @RequestParam("password") String password, Model model, HttpSession session) {
        name = HtmlUtils.htmlEscape(name);
        User user = userService.get(name,password);

        if(null==user){
            model.addAttribute("msg", "账号密码错误");
            return "fore/login";
        }
        session.setAttribute("user", user);
        return "redirect:forehome";
    }

    @RequestMapping("JumpLogin")
    public String JumpLogin() {
        return "fore/login";
    }
    @RequestMapping("JumpRegister")
    public String JumpRegister() {
        return "fore/register";
    }

    @RequestMapping("forelogout")
    public String logout( HttpSession session) {
        session.removeAttribute("user");
        return "redirect:forehome";
    }

    @RequestMapping("forebook")
    public String book( int bid, Model model) {
        Book book = bookService.get(bid);

        double price = book.getPrice()*0.97;
        List<Review> reviews = reviewService.list(book.getId());

        model.addAttribute("b", book);
        model.addAttribute("price", price );
        model.addAttribute("reviews", reviews);
        return "fore/book";
    }

    @RequestMapping("forecheckLogin")
    @ResponseBody
    public String checkLogin( HttpSession session) {
        User user =(User)  session.getAttribute("user");
        if(null!=user)
            return "success";
        return "fail";
    }
    @RequestMapping("foreloginAjax")
    @ResponseBody
    public String loginAjax(@RequestParam("name") String name, @RequestParam("password") String password,HttpSession session) {
        name = HtmlUtils.htmlEscape(name);
        User user = userService.get(name,password);

        if(null==user){
            return "fail";
        }
        session.setAttribute("user", user);
        return "success";
    }
    @RequestMapping("forecategory")
    public String category(int cid,String sort, Model model) {
        Category c = categoryService.get(cid);
        List<Mince> ms = minceService.list(cid);
        for (Mince m :
                ms) {
            List<Book> bs = bookService.list(m.getId());
            m.setBs(bs);
        }
        c.setMs(ms);
        model.addAttribute("c", c);
        return "fore/category";
    }

    @RequestMapping("foremince")
    public String mince(int mid,String sort, Model model) {
        Mince m = minceService.get(mid);
        List<Book> bs = bookService.list(m.getId());
        m.setBs(bs);
        bookService.setSaleAndReviewNumber(m.getBs());
        if (null != sort) {
            switch (sort) {
                case "review":
                    Collections.sort(m.getBs(), new BookReviewComparator());
                    break;
                case "date":
                    Collections.sort(m.getBs(), new BookDateComparator());
                    break;
                case "salecount":
                    Collections.sort(m.getBs(), new BookSalecountComparator());
                    break;
                case "priceDown":
                    Collections.sort(m.getBs(), new BookPriceComparator());
                    Collections.reverse(m.getBs());
                    break;
                case "priceUp":
                    Collections.sort(m.getBs(), new BookPriceComparator());
                    break;
                case "all":
                    Collections.sort(m.getBs(), new BookAllComparator());
                    break;

            }
        }

        model.addAttribute("m", m);
        return "fore/mince";
    }

    @RequestMapping("foresearch")
    public String search( String keyword,Model model){
        PageHelper.offsetPage(0,20);
        List<Book> bs = bookService.search(keyword);

        bookService.setSaleAndReviewNumber(bs);
        model.addAttribute("bs", bs);
        return "fore/searchResult";
    }

    @RequestMapping("forebuyone")
    public String buyone(int bid, Integer num, HttpSession session) {
        Book b = bookService.get(bid);
        int oiid = 0;

        User user =(User)  session.getAttribute("user");
        boolean found = false;
        List<OrderItem> ois = orderItemService.listByUser(user.getId());

        if(null != ois && 0 != ois.size()){
            for (OrderItem oi : ois) {
                if (oi.getBid() == b.getId()) {
                    oi.setNumber(num + oi.getNumber());
                    orderItemService.update(oi);
                    found = true;
                    oiid = oi.getId();
                    break;
                }
            }
        }

        if (!found) {
            OrderItem oi = new OrderItem();
            oi.setUid(user.getId());
            oi.setNumber(num);
            oi.setBid(bid);
            orderItemService.add(oi);
            oiid = oi.getId();
        }

        return "redirect:forebuy?oiid="+oiid;
    }

    @RequestMapping("forebuy")
    public String buy( Model model,String[] oiid,HttpSession session){
        List<OrderItem> ois = new ArrayList<>();
        double total = 0;

        for (String strid : oiid) {
            int id = Integer.parseInt(strid);
            OrderItem oi= orderItemService.get(id);
            Book book = bookService.get(oi.getBid());
            total +=book.getPrice()*oi.getNumber();
            oi.setBook(book);
            ois.add(oi);
        }

        session.setAttribute("ois", ois);
        model.addAttribute("total", total);
        return "fore/buy";
    }

    @RequestMapping("foreaddCart")
    @ResponseBody
    public String addCart(int bid, int num, Model model,HttpSession session) {
        Book b = bookService.get(bid);
        User user =(User)  session.getAttribute("user");
        boolean found = false;

        List<OrderItem> ois = orderItemService.listByUser(user.getId());
        for (OrderItem oi : ois) {
            if(oi.getBid().intValue()==b.getId().intValue()){
                oi.setNumber(oi.getNumber()+num);
                orderItemService.update(oi);
                found = true;
                break;
            }
        }

        if(!found){
            OrderItem oi = new OrderItem();
            oi.setUid(user.getId());
            oi.setNumber(num);
            oi.setBid(bid);
            orderItemService.add(oi);
        }
        return "success";
    }

    @RequestMapping("forecart")
    public String cart( Model model,HttpSession session) {
        User user =(User)  session.getAttribute("user");
         List<OrderItem> ois = orderItemService.listByUser(user.getId());
        for (OrderItem oi :
                ois) {
            Book book = bookService.get(oi.getBid());
            oi.setBook(book);
        }
        model.addAttribute("ois", ois);
        return "fore/cart";
    }

    @RequestMapping("foredeleteOrderItem")
    @ResponseBody
    public String deleteOrderItem( Model model,HttpSession session,int oiid){
        User user =(User)  session.getAttribute("user");
        if(null==user)
            return "fail";
        orderItemService.delete(oiid);
        return "success";
    }

    @RequestMapping("forechangeOrderItem")
    @ResponseBody
    public String changeOrderItem( Model model,HttpSession session, int oiid, int number) {
        User user =(User)  session.getAttribute("user");
        if(null==user)
            return "fail";

        OrderItem oi = orderItemService.get(oiid);
        oi.setNumber(number);
        orderItemService.update(oi);

        return "success";
    }

    @RequestMapping("forecreateOrder")
    public String createOrder( Model model,Order order,Information information , HttpSession session){
        List<OrderItem> ois= (List<OrderItem>)  session.getAttribute("ois");
        if (ois.isEmpty()){
            return "fore/login";
        }
        User user = (User)  session.getAttribute("user");

        information.setUid(user.getId());
        informationService.add(information);
        String orderCode = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()) + RandomUtils.nextInt(10000);
        order.setIid(information.getId());
        order.setUid(user.getId());
        order.setOrderCode(orderCode);
        order.setCreateDate(new Date());
        order.setStatus(orderService.waitPay);

        orderService.add(order);

        double total = 0;
        for (OrderItem oi :
                ois) {
            oi.setOid(order.getId());
            Book b = bookService.get(oi.getBid());
            total += b.getPrice() * oi.getNumber();
            int stock = b.getStock()-oi.getNumber();
            if (stock<0)
                return "fore/cart";
            b.setStock(stock);
            bookService.update(b);
            orderItemService.update(oi);

        }

        if("VIP".contains(user.getVip()))
            total *= 0.97;

        return "redirect:forealipay?oid="+order.getId() +"&total="+total;
    }

    @RequestMapping("forealipay")
    public String alipay(Model model) {
        return "fore/alipay";
    }

    @RequestMapping("forepayed")
    public String payed(int oid, float total, Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        Order order = orderService.get(oid);
        order.setStatus(OrderService.waitDelivery);
        order.setPayDate(new Date());
        orderService.update(order);
        Information information = informationService.get( order.getIid());
        order.setInformation(information);

        List<OrderItem> ois = orderItemService.listByOrder(oid);
        int integral = user.getIntegral();
        for (OrderItem oi :
                ois) {
            Book book = bookService.get(oi.getBid());
            integral += (int)book.getPrice() * oi.getNumber();
        }
        user.setIntegral(integral);
        userService.update(user);
        model.addAttribute("o", order);
        return "fore/payed";
    }
    @RequestMapping("forebought")
    public String bought( Model model,HttpSession session) {
        User user =(User)  session.getAttribute("user");
        List<Order> os= orderService.list(user.getId(),OrderService.delete);

        orderItemService.fill(os);

        model.addAttribute("os", os);
        return "fore/bought";
    }

    @RequestMapping("foreconfirmPay")
    public String confirmPay( Model model,int oid) {
        Order o = orderService.get(oid);
        orderItemService.fill(o);
        model.addAttribute("o", o);
        return "fore/confirmPay";
    }
    @RequestMapping("foreorderConfirmed")
    public String orderConfirmed( Model model,int oid) {
        Order o = orderService.get(oid);
        o.setStatus(OrderService.waitReview);
        o.setConfirmDate(new Date());
        orderService.update(o);
        return "fore/orderConfirmed";
    }
    @RequestMapping("foredeleteOrder")
    @ResponseBody
    public String deleteOrder( Model model,int oid){
        Order o = orderService.get(oid);
        o.setStatus(OrderService.delete);
        orderService.update(o);
        return "success";
    }
    @RequestMapping("forereview")
    public String review( Model model,int oid,int bid) {
        Order o = orderService.get(oid);
        orderItemService.fill(o);
        Book b = bookService.get(bid);

        List<Review> reviews = reviewService.list(bid);
        bookService.setSaleAndReviewNumber(b);
        model.addAttribute("b", b);
        model.addAttribute("o", o);
        model.addAttribute("reviews", reviews);
        return "fore/review";
    }
    @RequestMapping("foredoreview")
    public String doreview( Model model,HttpSession session,@RequestParam("oid") int oid,Review review) {
        Order o = orderService.get(oid);
        o.setStatus(OrderService.finish);
        orderService.update(o);

        Book book = bookService.get(review.getBid());
        String content = HtmlUtils.htmlEscape(review.getContent());
        User user =(User)  session.getAttribute("user");

        review.setContent(content);
        review.setCreateDate(new Date());
        review.setUid(user.getId());
        reviewService.add(review);

        return "redirect:forereview?oid="+oid+"&bid="+book.getId()+"&showonly=true";
    }

}
