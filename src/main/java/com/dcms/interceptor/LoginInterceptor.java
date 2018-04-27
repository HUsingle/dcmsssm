package com.dcms.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by single on 2018/4/7.
 */
public class LoginInterceptor implements HandlerInterceptor {
    public boolean preHandle(HttpServletRequest request, HttpServletResponse httpServletResponse, Object o) throws Exception {
        if(request.getSession().getAttribute("account")==null){
           String basePath = request.getServerName() + ":" + request.getServerPort();
            //System.out.println("hafds");
           // httpServletResponse.sendRedirect( basePath+"/views/login.jsp");
            //request.getRequestDispatcher("login.jsp").forward(request,httpServletResponse);
            //System.out.println("3515213");
           // request.getRequestDispatcher("new.jsp").forward(request, httpServletResponse);   //转发到new.jsp

            return false;
        }
        return true;
    }

    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
