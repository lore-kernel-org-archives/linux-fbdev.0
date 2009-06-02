From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] fb: add support of LCD display
	controller on pxa168/910 (base layer)
Date: Tue, 2 Jun 2009 10:32:50 +0800
Message-ID: <f17812d70906011932u29386664uf4d7a573fee59075@mail.gmail.com>
References: <f17812d70905210203se23d5e7ya60cbb6eb93815aa@mail.gmail.com>
	<20090521094157.GA24078@n2100.arm.linux.org.uk>
	<f17812d70905210728k1349adb6se4ffc26bd5d9cf53@mail.gmail.com>
	<20090524134304.fcf906ad.krzysztof.h1@poczta.fm>
	<f17812d70905270121od092964m673984c427942727@mail.gmail.com>
	<20090601172815.c1631cf6.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <eric.y.miao@gmail.com>) id 1MBJo4-0003iQ-Up
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Jun 2009 02:32:52 +0000
Received: from mail-qy0-f117.google.com ([209.85.221.117])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MBJo4-0007w2-7W for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Jun 2009 02:32:52 +0000
Received: by qyk15 with SMTP id 15so44673qyk.28
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 01 Jun 2009 19:32:50 -0700 (PDT)
In-Reply-To: <20090601172815.c1631cf6.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Green Wan <gwan@marvell.com>, linux-fbdev-devel@lists.sourceforge.net, Jun Nie <njun@marvell.com>, Peter Liao <pliao@marvell.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Lennert Buijtenhek <buytenh@marvell.com>, Kevin Liu <kliu5@marvell.com>

T24gTW9uLCBKdW4gMSwgMjAwOSBhdCAxMToyOCBQTSwgS3J6eXN6dG9mIEhlbHQgPGtyenlzenRv
Zi5oMUBwb2N6dGEuZm0+IHdyb3RlOgo+IE9uIFdlZCwgMjcgTWF5IDIwMDkgMTY6MjE6MTEgKzA4
MDAKPiBFcmljIE1pYW8gPGVyaWMueS5taWFvQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPj4gSGkgS3J6
eXN6dG9mLAo+Pgo+PiBTb3JyeSBmb3IgbGF0ZSByZXBseSwgYW5kIHRoYW5rcyBmb3IgdGhlIHRp
bWUgcmV2aWV3aW5nIHRoaXMuCj4+IFNlZSB0aGUgcmV2aXNlZCB2ZXJzaW9uIGJlbG93IHdpdGgg
Y2hhbmdlczoKPj4KPj4gMS4gcmVtb3ZlZCB0aGUgdW5uZWNlc3NhcnkgZXJyb3IgY2hlY2tpbmcg
b2YgcHNldWRvIGNvbG9yCj4+IGluIGNoZWNrX3ZhcigpLiBUaGUgcHNldWRvIGNvbG9yIG1vZGUg
aXMgYWN0dWFsbHkgYmUgd2VsbAo+PiBzdXBwb3J0ZWQuCj4+Cj4+IDIuIGRldGVybWluZV9iZXN0
X3BpeF9mbXQoKSBtb3ZlZCBpbnRvIGNoZWNrX3ZhcigpLCBhbmQKPj4gc2V0X3BpeF9mbXQoKSBp
cyBjYWxsZWQgdG8gZW5zdXJlIGEgY29ycmVjdCB2YXIuCj4+Cj4+IDMuIHNldF9ncmFwaGljc19z
dGFydCgpIHJlbW92ZWQgZnJvbSBzZXRfcGFyCj4+Cj4+IDQuIHJlbW92ZWQgZHVwbGljYXRlIGZp
ZWxkcyBpbiBweGExNjhmYl9pbmZvIGFuZCBmYl9pbmZvCj4+Cj4+IDUuIGNvcnJlY3QgdGhlIGVy
cm9yIGV4aXRpbmcgcGF0aAo+Pgo+PiA2LiBhZGQgX19pbml0IGF0dHJpYnV0ZSB0byBweGExNjhm
Yl9pbml0X21vZGUoKQo+Pgo+PiA9PT09PT09PT09PT09PT09PT09Pjg9PT09PT09PT09PT09PT09
PT09PT09PQo+Pgo+PiBGcm9tIDI3YTUzZGYwNDY3ZjM3OWRlNWNhMmQ2ZDExNzg1MmZiYWY5M2My
ZmMgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCj4+IEZyb206IExlbm5lcnQgQnV5dGVuaGVrIDxi
dXl0ZW5oQG1hcnZlbGwuY29tPgo+PiBEYXRlOiBXZWQsIDExIEZlYiAyMDA5IDE3OjI1OjI0ICsw
ODAwCj4+IFN1YmplY3Q6IFtQQVRDSF0gZmI6IGFkZCBzdXBwb3J0IG9mIExDRCBkaXNwbGF5IGNv
bnRyb2xsZXIgb24KPj4gcHhhMTY4LzkxMCAoYmFzZSBsYXllcikKPj4KPj4gVGhpcyBkcml2ZXIg
aXMgb3JpZ2luYWxseSB3cml0dGVuIGJ5IExlbm5lcnQsIG1vZGlmaWVkIGJ5IEdyZWVuIHRvIGJl
Cj4+IGZlYXR1cmUgY29tcGxldGUsIMKgYW5kIHBvcnRlZCBieSBKdW4gTmllIGFuZCBLZXZpbiBM
aXUgZm9yIHB4YTE2OC85MTAKPj4gcHJvY2Vzc29ycy4KPj4KPj4gVGhlIHBhdGNoIGFkZHMgc3Vw
cG9ydCBmb3IgdGhlIG9uLWNoaXAgTENEIGRpc3BsYXkgY29udHJvbGxlciwgaXQKPj4gY3VycmVu
dGx5IHN1cHBvcnRzIHRoZSBiYXNlIChncmFwaGljcykgbGF5ZXIgb25seS4KPj4KPj4gU2lnbmVk
LW9mZi1ieTogTGVubmVydCBCdXl0ZW5oZWsgPGJ1eXRlbmhAbWFydmVsbC5jb20+Cj4+IFNpZ25l
ZC1vZmYtYnk6IEdyZWVuIFdhbiA8Z3dhbkBtYXJ2ZWxsLmNvbT4KPj4gQ2M6IFBldGVyIExpYW8g
PHBsaWFvQG1hcnZlbGwuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBKdW4gTmllIDxuanVuQG1hcnZl
bGwuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBLZXZpbiBMaXUgPGtsaXU1QG1hcnZlbGwuY29tPgo+
PiBTaWduZWQtb2ZmLWJ5OiBFcmljIE1pYW8gPGVyaWMubWlhb0BtYXJ2ZWxsLmNvbT4KPj4gLS0t
Cj4KPiBBY2tlZC1ieTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3cC5wbD4KPgo+IFlv
dSBwcm9iYWJseSB3YW50IHRvIHNlbnQgdGhpcyBwYXRjaCB0byB0aGUgUk1LJ3MgdHJlZS4KPiBJ
ZiBub3QgcGxlYXNlIHNlbnQgaXQgdG8gQW5kcmV3IE1vcnRvbi4KCk9LLiBBbmQgYSBiaWcgdGhh
bmtzIGZvciB0aGUgdGltZS4KCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpPcGVuU29sYXJpcyAyMDA5
LjA2IGlzIGEgY3V0dGluZyBlZGdlIG9wZXJhdGluZyBzeXN0ZW0gZm9yIGVudGVycHJpc2VzIAps
b29raW5nIHRvIGRlcGxveSB0aGUgbmV4dCBnZW5lcmF0aW9uIG9mIFNvbGFyaXMgdGhhdCBpbmNs
dWRlcyB0aGUgbGF0ZXN0IAppbm5vdmF0aW9ucyBmcm9tIFN1biBhbmQgdGhlIE9wZW5Tb3VyY2Ug
Y29tbXVuaXR5LiBEb3dubG9hZCBhIGNvcHkgYW5kIAplbmpveSBjYXBhYmlsaXRpZXMgc3VjaCBh
cyBOZXR3b3JraW5nLCBTdG9yYWdlIGFuZCBWaXJ0dWFsaXphdGlvbi4gCkdvIHRvOiBodHRwOi8v
cC5zZi5uZXQvc2Z1L29wZW5zb2xhcmlzLWdldApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1mYmRldi1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgt
ZmJkZXYtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9y
Z2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWZiZGV2LWRldmVsCg==
