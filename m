From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
Subject: Re: [PATCH] Add fb_check_var() for fixed
	mode	device.
Date: Fri, 29 Aug 2008 16:23:10 +0200
Message-ID: <1220019790.4421.297.camel@thor.sulgenrain.local>
References: <48B4E16C.4000107@renesas.com>
	<Pine.LNX.4.64.0808270855110.7910@anakin> <g94i4r$2hq$1@ger.gmane.org>
	<20080828074521.GO16680@sci.fi>  <48B785DA.1030408@renesas.com>
	<1219999758.4421.259.camel@thor.sulgenrain.local>
	<Pine.LNX.4.64.0808291127510.18326@anakin>
	<1220017912.4421.291.camel@thor.sulgenrain.local>
	<Pine.LNX.4.64.0808291610230.18326@anakin>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KZ4sg-00007X-15 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 07:23:23 -0700
Received: from fk-out-0910.google.com ([209.85.128.184])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KZ4se-0003Rc-H2
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 07:23:17 -0700
Received: by fk-out-0910.google.com with SMTP id 18so585925fkq.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 29 Aug 2008 07:23:15 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0808291610230.18326@anakin>
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

T24gRnJpLCAyMDA4LTA4LTI5IGF0IDE2OjE0ICswMjAwLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3Jv
dGU6Cj4gT24gRnJpLCAyOSBBdWcgMjAwOCwgTWljaGVsIERuemVyIHdyb3RlOgo+ID4gT24gRnJp
LCAyMDA4LTA4LTI5IGF0IDE0OjE2ICswMjAwLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6Cj4g
PiA+IAo+ID4gPiB8IFguT3JnIFggU2VydmVyIDEuNC4yCj4gPiAKPiA+IFsuLi5dCj4gPiAKPiA+
ID4gfCAoRUUpIEZCREVWKDApOiBGQklPUFVUX1ZTQ1JFRU5JTkZPIHN1Y2NlZWRlZCBidXQgbW9k
aWZpZWQgbW9kZQo+ID4gCj4gPiBbLi4uXQo+ID4gCj4gPiA+IEhlbmNlIFhvcmcgaXMgYnJva2Vu
IG9uIGFsbCBlbWJlZGRlZCBkZXZpY2VzIHdpdGggYSBmcmFtZSBidWZmZXIgZHJpdmVyCj4gPiA+
IHRoYXQgc3VwcG9ydHMgYSBzaW5nbGUgZml4ZWQgdmlkZW8gbW9kZSBvbmx5Pwo+ID4gCj4gPiBO
by4gQXMgZGlzY3Vzc2VkIGJlZm9yZSwgeW91J3JlIHByb2JhYmx5IG1pc3NpbmcKPiA+IAo+ID4g
aHR0cDovL2NnaXQuZnJlZWRlc2t0b3Aub3JnL3hvcmcveHNlcnZlci9jb21taXQvP2lkPWMwOTVk
YTA0ZmU3YzczYjY1MDNlZjViOTM1NDliMTM3OTZjNTFiMjIKPiA+IAo+ID4gd2hpY2ggaXMgaW4g
dGhlIHVwY29taW5nIHhzZXJ2ZXIgMS41IHJlbGVhc2UuCj4gCj4gQWgsIHVwY29taW5nLiBUaGF0
J3Mgbm90IGN1cnJlbnQvcHJldmlvdXMvLi4uIDstKQoKWWVhaCwgaXQgbWlnaHQgaGF2ZSBiZWVu
IG5pY2UgdG8gYmFja3BvcnQgdGhpcyB0byB0aGUgMS40IGJyYW5jaCwgYnV0Cml0J3Mga2luZCBv
ZiB0b28gbGF0ZSBub3cuIE9mIGNvdXJzZSwgeW91IGNhbiBhbHdheXMgYnVnIHlvdXIKZGlzdHJp
YnV0b3IgdG8gYmFja3BvcnQgaXQuIDopCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAg
ICAgICAgICAgfCAgICAgICAgICBodHRwOi8vdHVuZ3N0ZW5ncmFwaGljcy5jb20KTGlicmUgc29m
dHdhcmUgZW50aHVzaWFzdCAgICAgICAgIHwgICAgICAgICAgRGViaWFuLCBYIGFuZCBEUkkgZGV2
ZWxvcGVyCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpUaGlzIFNGLk5ldCBlbWFpbCBpcyBzcG9uc29yZWQg
YnkgdGhlIE1vYmxpbiBZb3VyIE1vdmUgRGV2ZWxvcGVyJ3MgY2hhbGxlbmdlCkJ1aWxkIHRoZSBj
b29sZXN0IExpbnV4IGJhc2VkIGFwcGxpY2F0aW9ucyB3aXRoIE1vYmxpbiBTREsgJiB3aW4gZ3Jl
YXQgcHJpemVzCkdyYW5kIHByaXplIGlzIGEgdHJpcCBmb3IgdHdvIHRvIGFuIE9wZW4gU291cmNl
IGV2ZW50IGFueXdoZXJlIGluIHRoZSB3b3JsZApodHRwOi8vbW9ibGluLWNvbnRlc3Qub3JnL3Jl
ZGlyZWN0LnBocD9iYW5uZXJfaWQ9MTAwJnVybD0vCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWZiZGV2LWRldmVsIG1haWxpbmcgbGlzdApMaW51
eC1mYmRldi1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vm
b3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZmJkZXYtZGV2ZWwK
