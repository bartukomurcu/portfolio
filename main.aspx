<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="Nooluo.main1" %>
<asp:Content ID="wrapper" ContentPlaceHolderID="mainWrapper" runat="server">
    <div class="container-fluid" id="panelHolder">
        <% Response.Write(contentToAdd); %>
        <% if(Session["mode"].Equals("dev")) {%>
        <div class="row">
            <%--Detailed Stock Info--%>
            <div class="col-md-6">
                <div class="hpanel">
                    <div class="panel-heading">
                        <div class="panel-tools">
                            <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                            <a class="closebox"><i class="fa fa-times"></i></a>
                        </div>
                        Detaylı Stok Bilgisi
                    </div>
                    <div class="panel-body list">
                        <div class="hpanel">
                            <span class="h3 text-capitalize">AKBNK</span>
                            <a><i class="fa fa-gear panel-tools"></i></a>
                            <ul class="list-group list-inline font-bold h4">
                                <li class="text-success font-extra-bold m-r-lg h1"><i class ="fa fa-caret-up"></i> 1.55</li>
                                <li class="m-r-md"><span class="h5">Değişim:</span><br />10.40 %</li>
                                <li class="m-r-md"><span class="h5">Hacim:</span><br />3.444.555 <i class="fa fa-turkish-lira"></i></li>
                                <li class="m-r-md"><span class="h5">Hacim Adet:</span><br />1.314.241</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    
        <div class="row">
            <div class="col-md-12">
                <!-- CALCULATOR -->
                <div class="hpanel">
                    <div class="panel-heading">
                        <div class="panel-tools">  <!-- kucultme/kapatma -->
					        <a class="showhide"><i class="fa fa-chevron-up"></i></a>
							<a class="closebox"><i class="fa fa-times"></i></a>
						</div>
                        <h4><b>Calculator</b></h4>
					</div>
					<div class="panel-body list">
                        <div class="row">  <!-- ilk baslik -->
                            <div class="col-sm-12">
                                <form method="get" class="form-horizontal" role="form">
                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label">Symbol:</label>
                                            <div class="col-sm-8">  <!-- sembol input -->
                                                <input type="text" class="form-control" placeholder="GOOG">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-8">
                                        <div class="form-group">
                                            <div class="col-sm-6">  <!-- stock/option dropdown -->
                                                <select class="form-control m-b">
                                                    <option>Stock or Index Sembol</option>
                                                    <option>Option Symbol</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-4">  <!-- ulke dropdown -->
                                                <select class="form-control m-b">
                                                    <option>HEPSİ</option>
                                                    <option>ABD</option>
                                                    <option>Avrupa</option>
                                                    <option>Kanada</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-2 pull-right">  <!-- go button -->
                                                <button class="btn btn-success" type="submit">Getir!</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="row">  <!-- yazilar -->
                            <div class="col-md-12">
                                <div class="col-md-4" id="sirketAdi">
                                    <dl class="dl-horizontal">
                                        <dt>MSFT:</dt>
                                        <dd><p class="text-success">NASDAQ - Microsoft Corp</p></dd>
                                    </dl>
                                </div>
                                <div class="col-md-4">
                                     <div id="kapanmaTarihi">
                                         <dl class="dl-horizontal">
                                             <dt>Son fiyat tarihi:</dt>
                                             <dd><p class="text-success">10/13/2015</p></dd>
                                         </dl>
                                     </div>
                                </div>
                                <div class="col-md-4">
                                     <div id="bugununTarihi">
                                         <dl class="dl-horizontal">
                                             <dt>Bugün:</dt>
                                             <dd><p class="text-success">10/14/2015</p></dd>
                                         </dl>
                                     </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">  <!-- calculator -->
                            <div class="col-sm-5" style="margin-left:15px;margin-right:15px;">   <!-- FORM -->
                                <div class="well well-sm" style="margin-top:34px;">
                                    <form method="get" class="form-horizontal" role="form">
                                        <div class="form-group">
                                            <label class="col-sm-5 control-label" for="f1">Style: </label>
                                            <div class="col-sm-7">
                                                <select class="form-control input-sm" id="f1">
                                                    <option>American</option>
                                                    <option>European</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-5 control-label" for="calculatorPrice">Price:</label>
                                            <div class="col-sm-7">
                                                <input class="form-control input-sm" id="calculatorPrice" type="text" value="50">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-5 control-label" for="calculatorStrike">Strike:</label>
                                            <div class="col-sm-7">
                                                <input class="form-control input-sm" id="calculatorStrike" type="text" value="40">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-5 control-label" for="calculatorExpirationDate">Expiration Date:</label>
                                            <div class="col-sm-7">
                                                <input id="calculatorExpirationDate" type="text" value="02-16-2012" class="form-control input-sm">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-5 control-label" for="f5">Days to Expiration:</label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control input-sm" id="f5">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-5 control-label" for="f6">Volatility:</label>
                                            <div class="col-sm-7">
                                                <div class="input-group" id="f6"> <input type="text" class="form-control input-sm"> <span class="input-group-addon input-sm">%</span></div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-5 control-label" for="f7">Interest Rate:</label>
                                            <div class="col-sm-7">
                                                <div class="input-group" id="f7"> <input type="text" class="form-control input-sm"> <span class="input-group-addon input-sm">%</span></div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-5 control-label" for="calculatorDividendsDate">Dividends Date:</label>
                                            <div class="col-sm-7">
                                                <input id="calculatorDividendsDate" type="text" value="02-16-2012" class="form-control input-sm">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-5 control-label" for="f9">Dividends Amount:</label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control input-sm" id="f9">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-5 control-label" for="f10">Dividends Frequency:</label>
                                            <div class="col-sm-7">
                                                <select class="form-control input-sm" id="f10">
                                                    <option>Monthly</option>
                                                    <option selected="selected">Quarterly</option>
                                                    <option>Semi-annually</option>
                                                    <option>Annually</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-3 pull-right">  <!-- calculator button -->
                                                <button class="btn btn-success" type="submit" style="margin-top:11px;margin-bottom:-9px;margin-right:2px;">Hesapla</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="col-sm-6" style="margin-left:15px;margin-right:15px;">  <!-- TABLE -->
                                <div class="row">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th></th>
                                                <th>Call</th>
                                                <th>Put</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <th>Sembol:</th>
                                                <td>MSFT 151016O</td>
                                                <td>MSFT 151016R</td>
                                            </tr>
                                            <tr>
                                                <th>Option Value:</th>
                                                <td>0.2406</td>
                                                <td>0.3501</td>
                                            </tr>
                                            <tr>
                                                <th>Delta:</th>
                                                <td>0.4435</td>
                                                <td>- 0.5565</td>
                                            </tr>
                                            <tr>
                                                <th>Gamma:</th>
                                                <td>0.5429</td>
                                                <td>0.5429</td>
                                            </tr>
                                            <tr>
                                                <th>Theta:</th>
                                                <td>- 0.0725</td>
                                                <td>- 0.0722</td>
                                            </tr>
                                            <tr>
                                                <th>Vega:</th>
                                                <td>0.0137</td>
                                                <td>0.0137</td>
                                            </tr>
                                            <tr>
                                                <th>Rho:</th>
                                                <td>0.0011</td>
                                                <td>- 0.0013</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="row well well-sm">
                                    <div class="row">
                                        <div class="col-sm-3"></div>
                                        <div class="col-sm-6">
                                            <h3 style="text-align:center;"><b>Implied Volatility</b></h3>
                                        </div>
                                        <div class="col-sm-3"></div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-2"></div>
                                        <div class="col-sm-4" style="text-align:center;">
                                            <p><b>Option Price</b></p>
                                            <div><p>484</p></div>
                                        </div>
                                        <div class="col-sm-4" style="text-align:center;">
                                            <p><b>Volatility (%)</b></p>
                                            <div><p>N/A</p></div>
                                        </div>
                                        <div class="col-sm-2"></div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-3"></div>
                                        <div class="col-sm-6">
                                            <select class="form-control m-b">
                                                <option>Call</option>
                                                <option>Put</option>
                                            </select>
                                        </div>
                                        <div class="col-sm-3"></div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-4 pull-right" style="margin-bottom:7px;">
                                            <button class="btn btn-success" type="submit">Hesapla</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
					</div>
                </div>
            </div>
        </div>
        <% } %>
    </div>
        
        <script type = "text/javascript" charset="utf-8">


            $(function () {
                refresh();
            });

            var loadingScreen = '<div style="margin: 0px; padding: 0px" class="splash-title">' +
                                    '<h1>Yükleniyor...</h1>' +
                                    '<img src="images/loading-bars.svg" />' +
                                '</div>';

            function refresh() {
                var element = "[class*=row]";
                var handle = ".panel-body";
                var connect = "[class*=row]";
                $(element).sortable(
                        {
                            handle: handle,
                            connectWith: connect,
                            tolerance: 'pointer',
                            forcePlaceholderSize: true,
                            opacity: 0.8
                        })
                        .disableSelection();

                $("[class*='runAtLoad']").click(); // click the buttons that loaded in ASP

                // En cok artanlar (gainers)
                var gainersData = '';
                // Loading animation
                $(".gainers").append(loadingScreen);
                $.ajax({
                    type: "GET",
                    url: "api",
                    data: {
                        ns: "security",
                        action: "get-gainers"
                    },
                    dataType: "json",
                    success: function (response) {
                        $.each(response.data, function (i, v) {
                            gainersData += '<tr><td class="text-uppercase" colspan="2">' + v.Ticker +
                                        '</td><td>' + v.Close.toFixed(2) +
                                        '</td><td class="text-success"><i class ="fa fa-caret-up"></i> ' + v.percentage.toFixed(2) +
                                        '</td></tr>';
                        });
                    },
                    complete: function (comp) {
                        // Delete loading animation
                        $(".gainers").empty();
                        $(".gainers").append(gainersData);
                    }
                });

                // En cok azalanlar (losers)
                var losersData = '';
                $(".losers").append(loadingScreen);
                $.ajax({
                    type: "GET",
                    url: "api",
                    data: {
                        ns: "security",
                        action: "get-losers"
                    },
                    dataType: "json",
                    success: function (response) {
                        $.each(response.data, function (i, v) {
                            losersData += '<tr><td class="text-uppercase" colspan="2">' + v.Ticker +
                                        '</td><td>' + v.Close.toFixed(2) +
                                        '</td><td class="text-danger"><i class ="fa fa-caret-down"></i> ' + v.percentage.toFixed(2) +
                                        '</td></tr>';
                        });
                    },
                    complete: function (comp) {
                        // delete animation
                        $(".losers").empty();
                        $(".losers").append(losersData);
                    }
                });
            }

            // Alert Options (toastr)
            toastr.options = {
                "debug": false,
                "newestOnTop": true,
                "positionClass": "toast-top-center",
                "closeButton": true,
                "debug": false,
                "toastClass": "animated fadeInDown",
            };

            // Add News Panel
            function addNews() {
                $.ajax({
                    type: "GET",
                    url: "api",
                    data: {
                        ns: "user",
                        action: "add-news",
                        "user-id": "<% Response.Write(((Nooluo.User)Session["user"]).id); %>",
                        "ticker": null
                    },
                    dataType: "json",
                    success: function (response) {
                        if (response.data != 0) {
                            var newsTemplate = '<div class="col-md-7">\
                                                    <div class="hpanel">\
                                                        <div class="panel-heading">\
                                                            <div class="panel-tools">\
                                                                <a class="showhide"><i class="fa fa-chevron-up"></i></a>\
                                                                <a class="closebox" onclick="deleteNews(\'newsPanel' + response.data + '\')"><i class="fa fa-times"></i></a>\
                                                            </div>\
                                                            Haberler\
                                                        </div>\
                                                        <div class="panel-body list" id="newsPanel' + response.data + '">\
                                                            <div class="table-responsive project-list">\
                                                                <div class="row">\
                                                                    <div class="col-md-5">\
                                                                        <input type="text" class="form-control" id="tickerText" placeholder="Hisse ismi giriniz" />\
                                                                        <span class="help-block">Hisse ismi <a target="_blank" href="http://finance.yahoo.com">Yahoo! Finance</a> hisseleriyle aynı olmak zorundadır.</span>\
                                                                    </div>\
                                                                    <div class="col-md-offset-5"></div>\
                                                                    <div class="col-md-2">\
                                                                        <a class="btn w-xs btn-primary" onclick="getNews(\'newsPanel' + response.data + '\')">Getir</a>\
                                                                    </div>\
                                                                </div>\
                                                                <div class="table-data">\
                                                                    <table class="table table-striped">\
                                                                        <thead>\
                                                                            <tr>\
                                                                                <th colspan="3">Başlık</th>\
                                                                                <th>Tarih</th>\
                                                                            </tr>\
                                                                        </thead>\
                                                                        <tbody class="newsTableBody"></tbody>\
                                                                    </table>\
                                                                </div>\
                                                            </div>\
                                                        </div>\
                                                    </div>\
                                                </div>';
                        $('#panelHolder').prepend(newsTemplate);
                        $.getScript("scripts/homer.js");
                        refresh();
                        toastr.success("Haberler paneli eklenmiştir.");
                    }
                    else {
                        toastr.warning("Haberler paneli eklenemedi.");
                    }
                    },
                    error: function() {
                        toastr.warning("Haberler paneli eklenemedi.");
                    }
                });
            }

            // Get News Data
            function getNews(newsId) {
                if ($('#' + newsId + ' #tickerText')[0].value != null || newsId != null) {
                    $('#' + newsId + " .newsTableBody").empty();
                    $('#' + newsId + " .newsTableBody").append(loadingScreen);
                    console.log(newsId.substring(9));
                    $.ajax({
                        type: "GET",
                        url: "api",
                        data: {
                            ns: "user",
                            action: "update-news",
                            "user-id": "<% Response.Write(((Nooluo.User)Session["user"]).id); %>",
                            "news-id": newsId.substring(9),
                            ticker: $('#' + newsId + ' #tickerText')[0].value
                        },
                        dataType: "json",
                        success: function (response) {
                        }
                    });

                    var newsData = '';
                    $.ajax({ // get the news data and show it on the panel
                        type: "GET",
                        url: "api",
                        data: {
                            ns: "news",
                            action: "get-news",
                            ticker: $('#' + newsId + ' #tickerText')[0].value
                        },
                        dataType: "json",
                        success: function (response) {
                            $.each(response.data, function (i, v) {;
                                newsData += '<tr><td colspan="3"><a href="' + v.link + '" target="_blank">' + v.title + '</a></td>' +
                                            '<td>' + v.date + '</td></tr>';
                            });
                        },
                        complete: function (comp) {
                            $('#' + newsId + " .newsTableBody").empty();
                            $('#' + newsId + " .newsTableBody").append(newsData);
                        }
                    });
                }
            }

            function deleteNews(newsId) {
                $.ajax({
                    type: "GET",
                    url: "api",
                    data: {
                        ns: "user",
                        action: "delete-news",
                        "user-id": "<% Response.Write(((Nooluo.User)Session["user"]).id);%>",
                        "news-id": newsId.substring(9)
                    },
                    dataType: "json",
                    success: function (response) {
                        if (response.data)
                            toastr.info("Haberler paneli silinmiştir.");
                        else
                            toastr.warning("Haberler paneli silinemedi.");
                    }
                });
            }

            // Add Min Max Panel
            function addMinMax() {
                $.ajax({
                    type: "GET",
                    url: "api",
                    data: {
                        ns: "user",
                        action: "add-min-max",
                        "user-id": "<% Response.Write(((Nooluo.User)Session["user"]).id); %>"
                    },
                    dataType: "json",
                    success: function (response) {
                        if (response.data != 0) {
                            var minMaxTemplate = '<div class="col-md-4">\
                                                    <div class="hpanel">\
                                                        <div class="panel-tools">\
                                                            <a class="showhide"><i class="fa fa-chevron-up"></i></a>\
                                                            <a class="closebox" onclick="deleteMinMax(\'minMaxPanel' + response.data + '\')"><i class="fa fa-times"></i></a>\
                                                        </div>\
                                                        <ul class="nav nav-tabs">\
                                                            <li class="active"><a data-toggle="tab" href="#tab-1"> En Çok Artanlar</a></li>\
                                                            <li class=""><a data-toggle="tab" href="#tab-2">En Çok Azalanlar</a></li>\
                                                        </ul>\
                                                        <div class="tab-content" id="minMaxPanel' + response.data + '">\
                                                            <div id="tab-1" class="tab-pane active">\
                                                                <div class="panel-body table-data">\
                                                                    <table class="table table-striped">\
                                                                        <thead>\
                                                                            <tr>\
                                                                                <th colspan="2">Sembol</th>\
                                                                                <th>Son</th>\
                                                                                <th>%</th>\
                                                                            </tr>\
                                                                        </thead>\
                                                                        <tbody class="gainers"></tbody>\
                                                                    </table>\
                                                                </div>\
                                                            </div>\
                                                            <div id="tab-2" class="tab-pane">\
                                                                <div class="panel-body table-data">\
                                                                    <table class="table table-striped">\
                                                                        <thead>\
                                                                            <tr>\
                                                                                <th colspan="2">Sembol</th>\
                                                                                <th>Son</th>\
                                                                                <th>%</th>\
                                                                            </tr>\
                                                                        </thead>\
                                                                        <tbody class="losers"></tbody>\
                                                                    </table>\
                                                                </div>\
                                                            </div>\
                                                        </div>\
                                                    </div>\
                                                </div>';

                            // En cok artanlar (gainers)
                            var gainersData = '';
                            // Loading animation
                            $("#minMaxPanel" + response.data + " .gainers").append(loadingScreen);
                            $.ajax({
                                type: "GET",
                                url: "api",
                                data: {
                                    ns: "security",
                                    action: "get-gainers"
                                },
                                dataType: "json",
                                success: function (response) {
                                    $.each(response.data, function (i, v) {
                                        gainersData += '<tr><td class="text-uppercase" colspan="2">' + v.Ticker +
                                                    '</td><td>' + v.Close.toFixed(2) +
                                                    '</td><td class="text-success"><i class ="fa fa-caret-up"></i> ' + v.percentage.toFixed(2) +
                                                    '</td></tr>';
                                    });
                                },
                                complete: function (comp) {
                                    // Delete loading animation
                                    $("#minMaxPanel" + response.data + " .gainers").empty();
                                    $("#minMaxPanel" + response.data + " .gainers").append(gainersData);
                                }
                            });

                            // En cok azalanlar (losers)
                            var losersData = '';
                            $("#minMaxPanel" + response.data + " .losers").append(loadingScreen);
                            $.ajax({
                                type: "GET",
                                url: "api",
                                data: {
                                    ns: "security",
                                    action: "get-losers"
                                },
                                dataType: "json",
                                success: function (response) {
                                    $.each(response.data, function (i, v) {
                                        losersData += '<tr><td class="text-uppercase" colspan="2">' + v.Ticker +
                                                    '</td><td>' + v.Close.toFixed(2) +
                                                    '</td><td class="text-danger"><i class ="fa fa-caret-down"></i> ' + v.percentage.toFixed(2) +
                                                    '</td></tr>';
                                    });
                                },
                                complete: function (comp) {
                                    // delete animation
                                    $("#minMaxPanel" + response.data + " .losers").empty();
                                    $("#minMaxPanel" + response.data + " .losers").append(losersData);
                                }
                            });

                        $('#panelHolder').prepend(minMaxTemplate);
                        $.getScript("scripts/homer.js");
                        refresh();
                        toastr.success("Min - Max paneli eklenmiştir.");
                    }
                    else {
                        toastr.warning("Min - Max paneli eklenemedi.");
                    }
                    },
                    error: function() {
                        toastr.warning("Min - Max paneli eklenemedi.");
                    }
                });
            }

            function deleteMinMax(minMaxId) {
                $.ajax({
                    type: "GET",
                    url: "api",
                    data: {
                        ns: "user",
                        action: "delete-min-max",
                        "user-id": "<% Response.Write(((Nooluo.User)Session["user"]).id);%>",
                        "min-max-id": minMaxId.substring(11)
                    },
                    dataType: "json",
                    success: function (response) {
                        if (response.data)
                            toastr.info("Min - Max paneli silinmiştir.");
                        else
                            toastr.warning("Min - Max paneli silinemedi.");
                    }
                });
            }

            
            // Add New Chart
            function addChart() {
                $.ajax({
                    type: "GET",
                    url: "api",
                    data: {
                        ns: "user",
                        action: "add-chart",
                        "user-id": "<% Response.Write(((Nooluo.User)Session["user"]).id); %>",
                        "ticker": null,
                        "startDate": null,
                        "endDate": null
                    },
                    dataType: "json",
                    success: function (response) {
                        if (response.data != 0) {
                            var chartTemplate = '<div class="row">\
                                        <div class="col-md-8">\
                                            <div class="hpanel">\
                                                <div class="panel-heading">\
                                                    <div class="panel-tools">\
                                                        <a class="showhide"><i class="fa fa-chevron-up"></i></a>\
                                                        <a class="closebox" onclick="deleteChart(\'chartPanel' + response.data + '\')"><i class="fa fa-times"></i></a>\
                                                    </div>\
                                                    Stock Chart\
                                                </div>\
                                                <div class="panel-body p-xl h-450" id="chartPanel' + response.data + '">\
                                                    <div class="row form-group">\
                                                        <div class="col-md-4">\
                                                            <input type="text" class="form-control" id="tickerText" placeholder="Hisse ismi giriniz"/>\
                                                            <span class="help-block">Hisse ismi <a target="_blank" href="http://finance.yahoo.com">Yahoo! Finance</a> hisseleriyle aynı olmak zorundadır.</span>\
                                                        </div>\
                                                        <div class="col-md-6">\
                                                            <div class=" input-daterange input-group">\
                                                                <span class="input-group-addon">Başlangıç:</span>\
                                                                <input type="text" class="input-sm form-control" id="startDate" onkeydown="return false;"/>\
                                                                <span class="input-group-addon">Bitiş:</span>\
                                                                <input type="text" class="input-sm form-control" id="endDate" onkeydown="return false;" />\
                                                            </div>\
                                                            <div>\
                                                                <a class="btn btn-sm btn-info" onclick="changeChartDays(\'chartPanel' + response.data + '\', 5)>5d</a>"\
                                                                <a class="btn btn-sm btn-info" onclick="changeChartDays(\'chartPanel' + response.data + '\', 30)>1m</a>"\
                                                                <a class="btn btn-sm btn-info" onclick="changeChartDays(\'chartPanel' + response.data + '\', 90)>3m</a>"\
                                                                <a class="btn btn-sm btn-info" onclick="changeChartDays(\'chartPanel' + response.data + '\', 180)>6m</a>"\
                                                                <a class="btn btn-sm btn-info" onclick="changeChartDays(\'chartPanel' + response.data + '\', 0)>YTD</a>"\
                                                                <a class="btn btn-sm btn-info" onclick="changeChartDays(\'chartPanel' + response.data + '\', 365)>1y</a>"\
                                                                <a class="btn btn-sm btn-info" onclick="changeChartDays(\'chartPanel' + response.data + '\', 730)>2y</a>"\
                                                                <a class="btn btn-sm btn-info" onclick="changeChartDays(\'chartPanel' + response.data + '\', 1825)>5y</a>"\
                                                                <a class="btn btn-sm btn-info" onclick="changeChartDays(\'chartPanel' + response.data + '\', 3650)>10y</a>"\
                                                            </div><br />\
                                                        </div>\
                                                        <div class="col-md-2">\
                                                            <a onclick="getStockData(\'chartPanel' + response.data +'\')" class="btn w-xs btn-primary">Getir</a>\
                                                        </div>\
                                                    </div>\
                                                    <div class="flot-chart" id="candle-stick"></div>\
                                                </div>\
                                            </div>\
                                        </div>';
                            $('#panelHolder').prepend(chartTemplate);
                            $('#chartPanel' + response.data + ' .input-daterange').datepicker({});
                            $.getScript("scripts/homer.js");
                            refresh();
                            toastr.success('Grafik paneli eklenmiştir.');
                        }
                        else {
                            toastr.warning("Grafik paneli eklenemedi.");
                        }
                    },
                    error: function () {
                        toastr.warning('Grafik paneli eklenemedi.');
                    }
                });
            }

            // Change Chart Days
            function changeChartDays(chartId, dayDif) {
                if (dayDif >= 0)
                {
                    var today = new Date();
                    var dd = today.getDate();
                    var mm = today.getMonth() + 1; //January is 0!
                    var yyyy = today.getFullYear();
                    var endDate = mm + '/' + dd + '/' + yyyy;
                    today = new Date(endDate);                        
                    var startDate = new Date(today.setDate(today.getDate() - dayDif));
                    if (dayDif == 0)
                        startDate = new Date(yyyy, 0, 1);
                    $('#' + chartId + ' #endDate')[0].value = endDate;
                    $('#' + chartId + ' #startDate')[0].value = (startDate.getMonth() + 1) + '/' + startDate.getDate() + '/' + startDate.getFullYear();
                    getStockData(chartId);
                }
            }

            // Chart Data
            function getStockData(chartId) {
                if ($('#' + chartId + ' #tickerText')[0].value != null && $('#' + chartId + ' #startDate')[0].value != null && $('#' + chartId + ' #endDate')[0].value != null) {
                    var sDate = $('#' + chartId + ' #startDate')[0].value.split("/");
                    var stDate = sDate[2] + "-" + sDate[0] + "-" + sDate[1];
                    var eDate = $('#' + chartId + ' #endDate')[0].value.split("/");
                    var enDate = eDate[2] + "-" + eDate[0] + "-" + eDate[1];
                    $.ajax({ // update the chart
                        type: "GET",
                        url: "api",
                        data: {
                            ns: "user",
                            action: "update-chart",
                            "user-id": "<% Response.Write(((Nooluo.User)Session["user"]).id); %>",
                            "chart-id": chartId.substring(10),
                            "ticker": $('#' + chartId + ' #tickerText')[0].value,
                            "start-date": stDate,
                            "end-date": enDate
                        },
                        dataType: "json",
                        success: function(response) {
                        }
                    });
                    $('#' + chartId + ' #candle-stick').empty();

                    $.ajax({ // get the data and show it on the chart
                        type: 'GET',
                        url: 'api',
                        data: {
                            ns: 'security', 
                            action: 'get-stock-data', 
                            ticker: $('#' + chartId + ' #tickerText')[0].value,
                            start_date: stDate, 
                            end_date: enDate },
                        dataType: 'json',
                        success: function (response) {
                            var dt = response.data;

                            var margin = { top: 20, right: 30, bottom: 25, left: 60 },
                                     width = $('#' + chartId + ' #candle-stick')[0].clientWidth - margin.left - margin.right,
                                     height = $('#' + chartId + ' #candle-stick')[0].clientHeight - margin.top - margin.bottom;

                            var parseDate = d3.time.format("%Y-%m-%d").parse;

                            var x = techan.scale.financetime()
                                    .range([0, width]);

                            var y = d3.scale.linear()
                                    .range([height, 0]);

                            var candlestick = techan.plot.candlestick()
                                    .xScale(x)
                                    .yScale(y);

                            var xAxis = d3.svg.axis()
                                    .scale(x)
                                    .orient("bottom");

                            var yAxis = d3.svg.axis()
                                    .scale(y)
                                    .orient("left");

                            var trendline = techan.plot.trendline()
                                    .xScale(x)
                                    .yScale(y);

                            var timeAnnotation = techan.plot.axisannotation()
                                    .axis(xAxis)
                                    .format(d3.time.format("%d-%m-%Y"))
                                    .width(80)
                                    .translate([0, height]);

                            var candleAnnotation = techan.plot.axisannotation()
                                    .axis(yAxis)
                                .width(70)
                                    .format(d3.format(",.3fs"));

                            var crosshair = techan.plot.crosshair()
                                .xScale(x)
                                .yScale(y)
                                .xAnnotation(timeAnnotation)
                                .yAnnotation([candleAnnotation]);

                            var svg = d3.select('#' + chartId + ' #candle-stick').append("svg")
                                    .attr("width", width + margin.left + margin.right)
                                    .attr("height", height + margin.top + margin.bottom)
                                    .append("g")
                                    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

                            var accessor = candlestick.accessor();

                            var candleSelection = svg.append("g")
                                    .attr("class", "candlestick")
                                    .attr("transform", "translate(0,0)");

                            svg.append("clipPath")
                                    .attr("id", "clip")
                                    .append("rect")
                                    .attr("x", 0)
                                    .attr("y", 0)
                                    .attr("width", width)
                                    .attr("height", y(0) - y(1));

                            svg.append("g")
                                    .attr("class", "x axis")
                                    .attr("transform", "translate(0," + height + ")")
                                    .call(xAxis);

                            svg.append("g")
                                    .attr("class", "y axis")
                                    .call(yAxis)
                                    .append("text")
                                    .attr("transform", "rotate(-90)")
                                    .attr("y", 6)
                                    .attr("dy", ".71em")
                                    .style("text-anchor", "end");

                            svg.append("g")
                                .attr("class", "crosshair candlestick")
                                .call(crosshair);

                            dt = dt.slice(0).map(function (d) {
                                return {
                                    date: parseDate(d.date),
                                    open: +d.open,
                                    high: +d.high,
                                    low: +d.low,
                                    close: +d.close
                                };
                            });

                            td = [{ start: { date: dt[0].date, value: dt[0].open }, end: { date: dt[1].date, value: dt[1].close } }];
                            x.domain(dt.map(accessor.d));
                            y.domain(techan.scale.plot.ohlc(dt, accessor).domain());

                            try {
                                svg.select("g.x.axis").call(xAxis);
                            } catch (e) {
                                svg.select("g.x.axis").remove();
                            }
                            var trendlineData = [
           { start: { date: new Date(2015, 9, 29), value: 720.50 }, end: { date: new Date(2015, 10, 15), value: 630.34 } },
           { start: { date: new Date(2014, 2, 14), value: 620 }, end: { date: new Date(2015, 10, 15), value: 700.50 } }
                            ];
                            
                            svg.append("g")
                                .datum(dt)
                                .attr("class", "candlestick")
                                .attr("clip-path", "url(#clip)")
                                .call(candlestick);

                            svg.append("g")
                                .attr("class", "trendlines analysis")
                                .attr("clip-path", "url(#clip)")
                                .datum(td)
                                .call(trendline);

                            svg.select("g.y.axis").call(yAxis);
                        }
                    });
                }
            }

            // Delete Chart
            function deleteChart(chartId) {
                $.ajax({
                    type: "GET",
                    url: "api",
                    data: {
                        ns: "user",
                        action: "delete-chart",
                        "user-id": "<% Response.Write(((Nooluo.User)Session["user"]).id); %>",
                        "chart-id": chartId.substring(10)
                        },
                    dataType: "json",
                    success: function (response) {
                        toastr.info('Grafik paneli silinmiştir.');
                    }
                });
            }

            // Add New Watchlist
            function addWatchlist(name) {
                $.ajax({
                    type: "GET",
                    url: "api",
                    data: {
                        ns: "user",
                        action: "add-watchlist",
                        "user-id": "<% Response.Write(((Nooluo.User)Session["user"]).id); %>"
                    },
                    dataType: "json",
                    success: function (response) {
                        if (response.data != 0) {
                            var watchListTemplate = '<div class="col-md-4">\
                                                         <div class="hpanel">\
                                                             <div class="panel-heading">\
                                                                 <div class="panel-tools">\
                                                                    <a class="showhide"><i class="fa fa-chevron-up"></i></a>\
                                                                    <a class="closebox" onclick="deleteWatchlist(\'watchlistPanel' + response.data + '\')"><i class="fa fa-times"></i></a>\
                                                                 </div>\
                                                                 Watchlist\
                                                             </div>\
                                                             <div class="panel-body list watchlistTable" id="watchlistPanel' + response.data + '">\
                                                                 <div class="row">\
                                                                     <div class="col-md-12 searchResults">\
                                                                        <div class="input-group">\
                                                                            <input type="text" class="form-control input-s" onkeyup="WatchlistSearch(this, \'watchlistPanel' + response.data + '\');" placeholder="Sembol giriniz..." />\
                                                                            <span class="input-group-btn">\
                                                                                <a class="btn btn-s btn-default">\
                                                                                    <span class="fa fa-search-plus"></span>\
                                                                                </a>\
                                                                            </span>\
                                                                        </div>\
                                                                     </div>\
                                                                 </div>\
                                                                 <div class="row watchlistTableRow">\
                                                                     <table class="table table-striped">\
                                                                         <thead>\
                                                                             <tr>\
                                                                                 <th colspan="2">Sembol</th>\
                                                                                 <th>Son</th>\
                                                                             </tr>\
                                                                         </thead>\
                                                                         <tbody class="watchlistBody"></tbody>\
                                                                     </table>\
                                                                 </div>\
                                                             </div>\
                                                         </div>\
                                                     </div>';
                            $('#panelHolder').prepend(watchListTemplate);
                            $.getScript("scripts/homer.js");
                            refresh();
                            toastr.success('Watchlist paneli eklenmiştir.');
                        }
                        else {
                            toastr.warning("Watchlist paneli eklenemedi.");
                        }
                    },
                    error: function () {
                        toastr.warning('Watchlist paneli eklenemedi.');
                    }
                });
            }

            // Watchlist Search
            function WatchlistSearch(input, watchlistID) {
                var watchlistSearchData = '';
                var inputValue = '';
                if (input.value !== '') {
                    inputValue = input.value;
                    $.ajax({
                        type: "GET",
                        url: "api",
                        dataType: "json",
                        data: {
                            ns: "security",
                            action: "search-by-ticker",
                            str: input.value,
                            limit: 3
                        },
                        success: function (response) {
                            if (input.value == inputValue) {
                                // delete prior results
                                $('#' + watchlistID + ' .results').remove();
                                watchlistSearchData = '';

                                // add the response data
                                $.each(response.data, function (i) {
                                    watchlistSearchData += '<button type="button" class="btn btn-default btn-xs btn-block results" ' +
                                                'onclick="addToWatchlist(this, \'' + watchlistID + '\', \'' + response.data[i].id + '\', \'' + response.data[i].ticker + '\', \'' + response.data[i].percentage + '\');">' + response.data[i].ticker + ', ' + response.data[i].title + '</button>';
                                });


                                $('#' + watchlistID + ' .searchResults').append(watchlistSearchData);
                            }
                        },
                        error: function (e) {
                            debugger;
                            console.log(e)
                            alert(e + " Error");
                        }
                    });
                }
                else {
                    $('#' + watchlistID + ' .results').remove();
                }
            }

            // Watchlist Add Security
            function addToWatchlist(input, watchlistID, id, ticker, percentage) {
                var watchlistData = '';
                if (percentage >= 0) {
                    redGreen = '<td class="text-success"><i class ="fa fa-caret-up"></i> ';
                }
                else {
                    redGreen = '<td class="text-danger"><i class ="fa fa-caret-down"></i> ';
                }
                watchlistData += '<tr ' + 'id="' + ticker + '"><td colspan="2">' + ticker + '</td>' +
                            redGreen + parseFloat(percentage).toFixed(2); + '</td>' +
                            '<td class="pull-right"><a onclick="removeFromWatchlist("' + watchlistID + ', ' + id + ', ' + ticker + '")"><i class="fa fa-minus" /></a></td></tr>';

                if ($('#' + watchlistID).find("#" + ticker)[0] != null) { // It is already in the watchlist
                    // TODO alert it
                    console.log("hisse zaten watchlist'e ekli")
                }
                else {
                    $.ajax({
                        type: "GET",
                        url: "api",
                        dataType: "json",
                        data: {
                            ns: "user",
                            action: "add-watchlist-item",
                            "security-id": id,
                            "watchlist-id": watchlistID.substring(14)
                        },
                        success: function (response) {
                            if (response.data) {
                                $('#' + watchlistID + ' .watchlistBody').prepend(watchlistData);
                            }
                            else {
                                // TODO alert it
                                console.log("Hisse kaydedilirken bir hata oluştu.");
                            }
                        }
                    });
                }
                // delete the search results
                $('#' + watchlistID + ' .results').remove();
            }

            // Watchlist Remove
            function removeFromWatchlist(watchlistId, securityId, ticker) {
                $.ajax({
                    type: "GET",
                    url: "api",
                    data: {
                        ns: "user",
                        action: "remove-watchlist-item",
                        "watchlist-id": watchlistId.substring(14),
                        "security-id": securityId
                    },
                    dataType: "json",
                    success: function (response) {
                        $('#' + watchlistId + ' #' + ticker).remove();
                    }

                });
            }

            // Delete Watchlist
            function deleteWatchlist(watchlistId) {
                $.ajax({
                    type: "GET",
                    url: "api",
                    data: {
                        ns: "user",
                        action: "delete-watchlist",
                        "user-id": "<% Response.Write(((Nooluo.User)Session["user"]).id); %>",
                        "watchlist-id": watchlistId.substring(14)
                    },
                    dataType: "json",
                    success: function (response) {
                        toastr.info('Watchlist paneli silinmiştir.');
                    }
                });
            }
                        
            // Touchspins
            $("#calculatorPrice").TouchSpin({
                min: 0,
                max: 100,
                step: 0.1,
                decimals: 2,
                boostat: 5,
                maxboostedstep: 10,
            });
            $("#calculatorStrike").TouchSpin({
                min: 0,
                max: 100,
                step: 0.1,
                decimals: 2,
                boostat: 5,
                maxboostedstep: 10,
            });

            // Calculators
            $('#calculatorExpirationDate').datepicker();
            $('#calculatorDividendsDate').datepicker();
            $('.input-group.date').datepicker({});
            $('.input-daterange').datepicker({});
        </script>
</asp:Content>