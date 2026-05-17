<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chapter-11's IDIOTS</title>
    <link href="${pageContext.request.contextPath}/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Our_Journery.css">
    <style>
    .FirstBody {
	    background: linear-gradient(rgba(192, 94, 18, 0.7), rgba(192, 94, 18, 0.7)), 
	                url('${pageContext.request.contextPath}/IMG/Family.png'); 
	    background-size: cover;
	    background-position: center;
	    background-attachment: fixed; /* Scroll လုပ်ရင် ပုံက ငြိမ်နေစေဖို့ */
	    min-height: 450px; /* ပုံရဲ့ အမြင့်ကို ဒီမှာချိန်ညှိနိုင်ပါတယ် */
	    width: 100%;
	    color: white;
                }
    </style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark custom-nav sticky-top">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#">
                <i class="bi bi-cup-hot me-2"></i>Chapter-11's IDIOTS
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    
                    <c:choose>
                        <c:when test="${sessionScope.userRole eq 'ADMIN'}">
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin-home">Home</a></li>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin-menu">Menu</a></li>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin-events">Events</a></li>
                            <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/our-journey">Our Journey</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home">Home</a></li>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/menu">Menu</a></li>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/event">Events</a></li>
                            <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/our-journey">Our Journey</a></li>
                        </c:otherwise>
                    </c:choose>                    
                    
                    <li class="nav-item dropdown ms-lg-3 admin-section">
                        <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="adminDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <div class="admin-profile-circle">
                                <i class="bi bi-person-fill"></i>
                            </div>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0" aria-labelledby="adminDropdown">
                            <c:choose>
                                <c:when test="${empty sessionScope.userRole}">
                                    <li><h6 class="dropdown-header text-uppercase small fw-bold text-muted">Guest Access</h6></li>
                                    <li><a class="dropdown-item py-2 text-primary fw-bold" href="${pageContext.request.contextPath}/login"><i class="bi bi-box-arrow-in-right me-2"></i>Login Required</a></li>
                                </c:when>

                                <c:when test="${sessionScope.userRole eq 'ADMIN'}">
                                    <li><h6 class="dropdown-header text-uppercase small fw-bold">Admin Control</h6></li>
                                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/admin-settings"><i class="bi bi-gear-fill me-2"></i>Settings</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item py-2 text-danger" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i>Sign Out</a></li>
                                </c:when>

                                <c:otherwise>
                                    <li><h6 class="dropdown-header text-uppercase small fw-bold">User Control</h6></li>
                                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/user-settings"><i class="bi bi-gear-fill me-2"></i>Settings</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item py-2 text-danger" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i>Sign Out</a></li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!-- First-Body-start -->
    <div class="FirstBody d-flex align-items-center justify-content-center text-center">
        <div class="container">
            <div class="journey-content p-4">
                <h1 class="journey-title mb-3">Our Journey</h1>
                <p class="journey-text mx-auto">
                    The Idiots: 11 Diverse Dreamers, One United Vision, and the Woman Who Joined Their Journey. A Tale of Youthful Minds Forging a Haven of Coffee, Literature, and Shared Passions.
                </p>
            </div>
        </div>
    </div>
    <!-- First-Body-end -->

    <!-- Second-Body-Start -->
    <div class="SecondBody py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-10 col-xl-8">
                    <h2 class="why-title text-center mb-5">Why "Chapter-11's IDIOTS"?</h2>
                    
                    <div class="why-content">
                        <p>
                            ကော်ဖီဆိုင်အမည်က Chapter-11's Idiots ဆိုပေမယ့်တကယ့်တမ်းမှာတော့ 11 ယောက်မဟုတ်ဘဲ 12 ယောက်ရှိခဲ့ပါတယ်။ဒါကလည်းဘယ်လိုစဖြစ်ခဲ့ကြတာလည်းဆိုတော့
                            သူငယ်ချင်း 11 ယောက်စလုံးမှာနောက်ပိုင်းမှာအသက်အရွယ်တစ်ခုအရောက်မှာကိုယ်စီကိုယ်စီမှာလုပ်ငန်းတွေရှိကြမှာဆိုတာမှန်ကြပေမယ့်ကျွန်တော်တို့ရဲ့သူငယ်ချင်းဖြစ်ခဲ့ကြတဲ့အကြောင်းနဲ့
                            ဘာကြောင့်မိသားစုလိုမျိုးအထိဖြစ်သွားခဲ့ကြတာလည်းဆိုတာနဲ့ရည်ရွယ်ပြီးပက်သက်ပြီးအားလုံးရဲ့စိတ်ကူးနဲ့ 11 Idiots ဆိုပြီးတော့သူငယ်ချင်းတွေ 11 ယောက်နဲ့စခဲ့ကြပါတယ်။ဒါမယ့်
                            ဒီနေရာမှာအပေါ်ကပြောသလို 11 ယောက်မဟုတ်ဘဲ 12 ယောက်ဆိုတာကတော့ဒီကော်ဖီဆိုင်မှာဘဲနောက်ထပ်ပါဝင်ခဲ့တဲ့သူရှိပါတယ်။အဲ့သူကတော့ကျွန်တော်ဒီ web ကိုရေးခဲ့တဲ့
                            ကျွန်တော့်ဘေးကအမျိုးသမီးတစ်ယောက်ဘဲဖြစ်ပါတယ်။သူကိုယ်တိုင်ကလည်းဒီကော်ဖီဆိုင်လေးကိုဖွင့်ဖို့သူကျွန်တော့်ကိုအမြဲအားပေးခဲ့တယ်နောက်ဆုံးအထိဒီကတိကိုယုံကြည်ဖို့သူသင်ပြပေးခဲ့တယ်။
                            မမေ့ဖို့လည်းအမြဲသတိပေးခဲ့တယ်။ဟုတ်ပါတယ်ကျွန်တော်သူတို့နဲ့ဝေးသွားပြီးအချိန်တစ်ခုမှာဒီအိမ်မက်ကိုကျွန်တော်တစ်ခါမေ့မိသွားခဲ့တယ်အဲ့အတွက်လည်းကျွန်တော်ဒီကနေမှကျွန်တော်သူငယ်ချင်းတွေ
                            ကိုတောင်းပန်ပါရစေဒီစာလေးနဲ့အတူပေါ့ဒီသူငယ်ချင်းတွေရဲ့အမည်တွေနဲ့လည်းမိတ်ဆက်ပေးရအုန်းမယ်သူတို့အမည်တွေက Shin Thant Min Htet , Htet Naing Htun , 
                            Ye Myat Htut , Sai Laung Khun Naunt , ‌Wai Chi Phyo , Sai Onn Won , Wathon Phoo Thet Mon , Htet Eaindra Kyaw,
                            Yu Mon Kyaw သူတို့တွေဖြစ်ခဲ့ကြပါတယ်။ငါ့ကောင်တို့ငါတို့တွေဝေးနေခဲ့ကြပေမယ့်ငါမင်းတို့တစ်ရက်မှမေ့လို့မရပါဘူးအဲ့တော့ဒီဆိုင်လေးကိုငါဖွင့်ခဲ့ပြီဆိုမင်းတို့ဒီဆိုင်ကိုလာခဲ့ကြပါဒီဆိုင်ကလည်းမင်းတို့ဆိုင်ပါဘဲ
                            မင်းတို့တွေရောက်လာရင်ငါတို့ဒီ Chapter-11's IDIOTS ဆိုတဲ့ဆိုင်လေးကိုမင်းတို့နေကြမယ့်နေရာမှာကိုယ်စီဆိုင်ခွဲတွေဖွင့်နိုင်အောင်လည်းငါဆက်ပြီးကြိုးစားပေးမယ်ငါတို့တွေက
                            ကိုယ်စီကိုယ်စီဖြစ်နေကြမယ့်ငါမင်းတို့ကိုအခုထိမမေ့ပါဘူးနောက်ပြီးဒီလိုမျိုးကော်ဖီဆိုင်ကိုဖွင့်လာဖို့ Force တစ်ခုဖြစ်အောင်လုပ်ခဲ့တဲ့သူငါသူ့ကြောင့်ဒီဟာကိုလုပ်ဖို့စိတ်အားထက်သန်သထက်
                            ထက်သန်လာအောင်လုပ်ပေးခဲ့သူရှိတယ်အဲ့လူတစ်ယောက်ကိုမင်းတို့သိပါတယ်တစ်ခြားသူမဟုတ်ပါဘူးသူကတော့မင်းတို့သိကြတဲ့ Yoon Nadi ပါဘဲငါ့အမျိုးသမီးငယ်ပေါ့သူကလည်းကော်ဖီဆိုင်ဖွင့်ခြင်တဲ့
                            သူတစ်ယောက်သူကနောက်မှငါတို့မိသားစုကြားထဲဝင်လာခဲ့ကြပေမယ့်ငါတို့ကိုသူကနားလည်တယ်ဒီဆန္ဒကိုလည်းဖြစ်မြှောက်ဖို့သူငါ့ကိုအားပေခဲ့တယ်ငါတို့သူကိုလည်းဒီမိသားစုထဲမှာငါထည့်လိုက်တယ်
                            ဒါဟာငါ့တစ်ဦးတည်းဆန္ဒဆိုတာမင်းတို့သိလောက်မှာပါစာဖတ်ကြည့်တာနဲ့ဒါမယ်ငါဘာကြောင့်ထည့်လိုက်သလည်းဆိုတာကိုရောမင်းတို့နားလည်လောက်မယ်လို့လည်းငါသိနေပါတယ်ငါ့ကိုနားလည်ပေးကြပါ
                            အထူးတလည်သိပ်မပြောတော့ဘူးဆိုတာကမင်းတို့နဲ့ငါကအချိတ်ဆက်ရှိပြီးသားမို့အများကြီးပြောစရာမလိုလောက်တော့ဘူးလို့ငါထင်ပါတယ်မင်းတို့တင်မဟုတ်ဘူးဒီ Coffee Shop ကိုလာခဲ့ကြတဲ့သူတွေ
                            ဒီ Website ကိုလာဝင်ပြီးကြည့်ခဲ့ကြတဲ့သူတွေလည်းဒီစာကိုဖတ်မိချိန်မှာသူတို့ကိုယ်တိုင်လည်းငါတို့ဒီဆိုင်ကိုဘာကြောင့်ဖွင့်ခဲ့သလည်းဆိုတာရိပ်စားမိလောက်မယ်ထင်ပါတယ်။ဒီဆိုင်ကမိသားစု signature
                            ငါတို့အားလုံးရဲ့နွေးထွေးမှုငါတို့အားလုံးရဲ့စည်းလုံးမှုငါတို့အားလုံးရဲ့အိမ်မက်ငါတို့အားလုံးရဲ့ဆိုင်လေးထဲမှာ‌နွေးထွေးမှုမေတ္တာတွေရှိနေခဲ့ကြောင်းဒီဆိုင်လေးကသက်သေရပ်တစ်ခုအဖြစ်ရှိနေမှာပါ
                            ဒီစာကိုဖတ်နေသူတွေကိုလည်းပြောခြင်တာကဘဝမှာမိသားစုဆိုတာသည်ချစ်ခြင်းမေတ္တာတွေသည်သွေးမတော်သားမစပ်လည်းရင်ဘက်ခြင်းနီးစပ်ခဲ့ကြတာနဲ့တင်အကုန်ဖြစ်နိုင်ကြောင်းဆိုတာကိုပြောကြားရင်
                            ဒီကော်ဖီဆိုင်လေးကသက်သေတစ်ခုဆိုတာကိုပြောပြခဲ့ခြင်ပါတယ်။
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Second-Body-end -->

    <!-- third-Body-start -->
    <div class="thirdbody py-5">
        <div class="container text-center">
            <h2 class="team-main-title mb-5">Meet Our Team</h2>

            <div class="row g-5 justify-content-center">
                <div class="col-md-3 col-sm-6">
                    <div class="team-card">
                        <div class="img-wrapper mb-3">
                            <img src="${pageContext.request.contextPath}/IMG/HTET.jpg" alt="Htet Naing Htun">
                        </div>
                        <h5 class="member-name">Htet Naing Htun</h5>
                        <p class="member-role">Purchasing Officer</p>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="team-card">
                        <div class="img-wrapper mb-3">
                            <img src="${pageContext.request.contextPath}/IMG/YE.jpg" alt="Ye Myat Htut">
                        </div>
                        <h5 class="member-name">Ye Myat Htut</h5>
                        <p class="member-role">Social Media Manager</p>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="team-card">
                        <div class="img-wrapper mb-3">
                            <img src="${pageContext.request.contextPath}/IMG/SHIN.jpg" alt="Shin Thant Min Htet">
                        </div>
                        <h5 class="member-name">Shin Thant Min Htet</h5>
                        <p class="member-role">Librarian</p>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="team-card">
                        <div class="img-wrapper mb-3">
                            <img src="${pageContext.request.contextPath}/IMG/Sai (1).jpg" alt="Sai Onn Won">
                        </div>
                        <h5 class="member-name">Sai Onn Won</h5>
                        <p class="member-role">Maintenance Staff</p>
                        <!-- <p class="member-desc">Creative mind behind our engaging community events and workshops.</p> -->
                    </div>
                </div>
            </div>

            <div class="row g-5 justify-content-center">
                <div class="col-md-3 col-sm-6">
                    <div class="team-card">
                        <div class="img-wrapper mb-3">
                            <img src="${pageContext.request.contextPath}/IMG/HTETEAIN.jpg" alt="Htet Eaindra Kyaw">
                        </div>
                        <h5 class="member-name">Htet Eaindra Kyaw</h5>
                        <p class="member-role">Inventory Controller</p>
                        <!-- <p class="member-desc">Coffee enthusiast and book lover who turned his passion into reality.</p> -->
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="team-card">
                        <div class="img-wrapper mb-3">
                            <img src="${pageContext.request.contextPath}/IMG/LONE.jpg" alt="Shoon Lae Hnin">
                        </div>
                        <h5 class="member-name">Shoon Lae Hnin</h5>
                        <p class="member-role">Barista</p>
                        <!-- <p class="member-desc">Award-winning barista with 10 years of experience in specialty coffee.</p> -->
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="team-card">
                        <div class="img-wrapper mb-3">
                            <img src="${pageContext.request.contextPath}/IMG/WATHON.jpg" alt="Wathon Phue That Mon">
                        </div>
                        <h5 class="member-name">Wathon Phue That Mon</h5>
                        <p class="member-role">Kitchen Staff</p>
                        <!-- <p class="member-desc">Former librarian who carefully curates our diverse book collection.</p> -->
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="team-card">
                        <div class="img-wrapper mb-3">
                            <img src="${pageContext.request.contextPath}/IMG/LI.jpg" alt="Yu Mon Kyaw">
                        </div>
                        <h5 class="member-name">Yu Mon Kyaw</h5>
                        <p class="member-role">Quality Control</p>
                        <!-- <p class="member-desc">Creative mind behind our engaging community events and workshops.</p> -->
                    </div>
                </div>
            </div>

            <div class="row g-5 justify-content-center">
                <div class="col-md-3 col-sm-6">
                    <div class="team-card">
                        <div class="img-wrapper mb-3">
                            <img src="${pageContext.request.contextPath}/IMG/WAI.jpg" alt="Wai Chit Phyo">
                        </div>
                        <h5 class="member-name">Wai Chit Phyo</h5>
                        <p class="member-role">Server</p>
                        <!-- <p class="member-desc">Coffee enthusiast and book lover who turned his passion into reality.</p> -->
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="team-card">
                        <div class="img-wrapper mb-3">
                            <img src="${pageContext.request.contextPath}/IMG/SAIL.jpg" alt="Sai Laung Khun Naunt">
                        </div>
                        <h5 class="member-name">Sai Laung Khun Naunt</h5>
                        <p class="member-role">Kitchen Staff</p>
                        <!-- <p class="member-desc">Award-winning barista with 10 years of experience in specialty coffee.</p> -->
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="team-card">
                        <div class="img-wrapper mb-3">
                            <img src="${pageContext.request.contextPath}/IMG/Kaung.jpg" alt="Sir-Bat">
                        </div>
                        <h5 class="member-name">Kaung Thant Zaw</h5>
                        <p class="member-role">Manager</p>
                        <!-- <p class="member-desc">Former librarian who carefully curates our diverse book collection.</p> -->
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="team-card">
                        <div class="img-wrapper mb-3">
                            <img src="${pageContext.request.contextPath}/IMG/Yoon.jpg" alt="Yoon Nadi">
                        </div>
                        <h5 class="member-name">Yoon Nadi</h5>
                        <p class="member-role">Events Manager</p>
                        <!-- <p class="member-desc">Creative mind behind our engaging community events and workshops.</p> -->
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- third-Body-end -->

    <!-- LIB-end-page-start -->
    <footer class="main-lastblock pt-5 pb-3">
        <div class="container text-white">
            <div class="row g-4">
                <div class="col-md-3">
                    <h4 class="fw-bold mb-3">Chapter-11's IDIOTS</h4>
                    <p class="small opacity-75">Where Coffee Meets Literature</p>
                </div>
                
                <div class="col-md-3">
                    <h5 class="fw-bold mb-3">Quick Links</h5>
                    <ul class="list-unstyled footer-links">
                        <c:choose>
                            <c:when test="${sessionScope.userRole eq 'ADMIN'}">
                                <li><a href="${pageContext.request.contextPath}/admin-home">Home</a></li>
                                <li><a href="${pageContext.request.contextPath}/admin-menu">Menu</a></li>
                                <li><a href="${pageContext.request.contextPath}/admin-events">Events</a></li>
                            </c:when>
                            <c:otherwise>
                                <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                                <li><a href="${pageContext.request.contextPath}/menu">Menu</a></li>
                                <li><a href="${pageContext.request.contextPath}/event">Events</a></li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>

                <div class="col-md-3">
                    <h5 class="fw-bold mb-3">Contact</h5>
                    <ul class="list-unstyled small opacity-75">
                        <li class="mb-2">123 Literary Lane</li>
                        <li class="mb-2">Book District, City 12345</li>
                        <li class="mb-2">Phone: (+95) 9978407566</li>
                        <li>Email: kaunglinux.dev@gmail.com</li>
                    </ul>
                </div>

                <div class="col-md-3">
                    <h5 class="fw-bold mb-3">Hours</h5>
                    <ul class="list-unstyled small opacity-75">
                        <li class="mb-2">Mon-Fri: 7AM - 10PM</li>
                        <li class="mb-2">Saturday: 8AM - 11PM</li>
                        <li>Sunday: 8AM - 9PM</li>
                    </ul>
                </div>
            </div>

            <hr class="mt-5 mb-4 opacity-25">
            
            <div class="text-center small opacity-75">
                <p>&copy; 2026 Chapter-11's IDIOTS. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>