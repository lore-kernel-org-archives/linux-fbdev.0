From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
Subject: Re: [PATCH] Add fb_check_var() for fixed
	mode	device.
Date: Fri, 29 Aug 2008 15:51:52 +0200
Message-ID: <1220017912.4421.291.camel@thor.sulgenrain.local>
References: <48B4E16C.4000107@renesas.com>
	<Pine.LNX.4.64.0808270855110.7910@anakin> <g94i4r$2hq$1@ger.gmane.org>
	<20080828074521.GO16680@sci.fi>  <48B785DA.1030408@renesas.com>
	<1219999758.4421.259.camel@thor.sulgenrain.local>
	<Pine.LNX.4.64.0808291127510.18326@anakin>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KZ4OO-0005Nb-AZ for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 06:52:00 -0700
Received: from fg-out-1718.google.com ([72.14.220.157])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KZ4OL-00015i-TI
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 06:52:00 -0700
Received: by fg-out-1718.google.com with SMTP id d23so539283fga.32
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 29 Aug 2008 06:51:56 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0808291127510.18326@anakin>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Helge Deller <deller@gmx.de>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Ville Syrj?l? <syrjala@sci.fi>

T24gRnJpLCAyMDA4LTA4LTI5IGF0IDE0OjE2ICswMjAwLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3Jv
dGU6Cj4gCj4gfCBYLk9yZyBYIFNlcnZlciAxLjQuMgoKWy4uLl0KCj4gfCAoRUUpIEZCREVWKDAp
OiBGQklPUFVUX1ZTQ1JFRU5JTkZPIHN1Y2NlZWRlZCBidXQgbW9kaWZpZWQgbW9kZQoKWy4uLl0K
Cj4gSGVuY2UgWG9yZyBpcyBicm9rZW4gb24gYWxsIGVtYmVkZGVkIGRldmljZXMgd2l0aCBhIGZy
YW1lIGJ1ZmZlciBkcml2ZXIKPiB0aGF0IHN1cHBvcnRzIGEgc2luZ2xlIGZpeGVkIHZpZGVvIG1v
ZGUgb25seT8KCk5vLiBBcyBkaXNjdXNzZWQgYmVmb3JlLCB5b3UncmUgcHJvYmFibHkgbWlzc2lu
ZwoKaHR0cDovL2NnaXQuZnJlZWRlc2t0b3Aub3JnL3hvcmcveHNlcnZlci9jb21taXQvP2lkPWMw
OTVkYTA0ZmU3YzczYjY1MDNlZjViOTM1NDliMTM3OTZjNTFiMjIKCndoaWNoIGlzIGluIHRoZSB1
cGNvbWluZyB4c2VydmVyIDEuNSByZWxlYXNlLgoKKEJUVywgd291bGQgeW91IGhhcHBlbiB0byBy
ZW1lbWJlciB3aGF0IHRoZSBtYWdpYyBwaXhjbG9jayB2YWx1ZSB3YXMKdGhlcmUgZm9yIGluIHRo
ZSBmaXJzdCBwbGFjZT8gOikKCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAg
ICB8ICAgICAgICAgIGh0dHA6Ly90dW5nc3RlbmdyYXBoaWNzLmNvbQpMaWJyZSBzb2Z0d2FyZSBl
bnRodXNpYXN0ICAgICAgICAgfCAgICAgICAgICBEZWJpYW4sIFggYW5kIERSSSBkZXZlbG9wZXIK
CgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tClRoaXMgU0YuTmV0IGVtYWlsIGlzIHNwb25zb3JlZCBieSB0aGUg
TW9ibGluIFlvdXIgTW92ZSBEZXZlbG9wZXIncyBjaGFsbGVuZ2UKQnVpbGQgdGhlIGNvb2xlc3Qg
TGludXggYmFzZWQgYXBwbGljYXRpb25zIHdpdGggTW9ibGluIFNESyAmIHdpbiBncmVhdCBwcml6
ZXMKR3JhbmQgcHJpemUgaXMgYSB0cmlwIGZvciB0d28gdG8gYW4gT3BlbiBTb3VyY2UgZXZlbnQg
YW55d2hlcmUgaW4gdGhlIHdvcmxkCmh0dHA6Ly9tb2JsaW4tY29udGVzdC5vcmcvcmVkaXJlY3Qu
cGhwP2Jhbm5lcl9pZD0xMDAmdXJsPS8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtZmJkZXYtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWZiZGV2
LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5l
dC9saXN0cy9saXN0aW5mby9saW51eC1mYmRldi1kZXZlbAo=
