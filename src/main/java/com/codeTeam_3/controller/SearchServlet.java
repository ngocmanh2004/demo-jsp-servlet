package com.codeTeam_3.controller;

import com.codeTeam_3.dao.ProductDao;
import com.codeTeam_3.model.ProductView;
import com.codeTeam_3.web.LangUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/products/search"})
public class SearchServlet extends HttpServlet {
    private final ProductDao dao = new ProductDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String lang = LangUtil.resolveLang(req);
        req.setAttribute("lang", lang);

        String keyword = req.getParameter("q");

        if (keyword == null || keyword.trim().isEmpty()) {
            // Nếu không có từ khóa, redirect về trang products
            resp.sendRedirect(req.getContextPath() + "/products?lang=" + lang);
            return;
        }

        keyword = keyword.trim();
        List<ProductView> results = dao.searchProducts(keyword, lang);

        req.setAttribute("products", results);
        req.setAttribute("keyword", keyword);
        req.setAttribute("resultCount", results.size());

        req.getRequestDispatcher("/WEB-INF/views/product-search.jsp").forward(req, resp);
    }
}