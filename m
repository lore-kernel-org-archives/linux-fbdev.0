From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] new fix: radeon backlight shutoff
 flashes momentarily
Date: Mon, 23 Mar 2009 12:16:16 +0100
Message-ID: <1237806976.25253.569.camel@thor.local>
References: <49C719B2.8070701@earthlink.net>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michel@daenzer.net>) id 1Lli9O-0005xq-LI
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Mar 2009 11:17:02 +0000
Received: from darkcity.gna.ch ([195.226.6.51] helo=mail.gna.ch)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Lli9J-0001sX-L7 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Mar 2009 11:17:02 +0000
In-Reply-To: <49C719B2.8070701@earthlink.net>
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
To: "Robert T. Drury" <rtdrury@earthlink.net>
Cc: benh@kernel.crashing.org, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net

T24gU3VuLCAyMDA5LTAzLTIyIGF0IDIyOjEwIC0wNzAwLCBSb2JlcnQgVC4gRHJ1cnkgd3JvdGU6
Cj4gVGhpcyBwYXRjaCBzaG91bGQgcmVwbGFjZSB0aGUgcHJldmlvdXMKPiBmaXgtcmFkZW9uLWJh
Y2tsaWdodC1zaHV0b2ZmLWZsYXNoZXMtbW9tZW50YXJpbHkucGF0Y2ggYWRkZWQgdG8gLW1tIHRy
ZWUKPiAKPiBUaGlzIHJlcGxhY2VtZW50IHBhdGNoIHJlbW92ZXMgb25seSB0aGUgJiB+TFZEU19C
TF9NT0RfRU4gb24gc2h1dG9mZiAKPiBhbmQgYXBwbGllcyBvbmx5IHRvIG1hY2hpbmUgcG93ZXJi
b29rNSwzICYmIENISVBfRkFNSUxZX1JWMzUwLiAKCkkgdGhpbmsgSSdtIGFsc28gc2VlaW5nIHRo
ZSBmbGFzaCBvbiBhIFBvd2VyQm9vazUsOC4gSXMgdGhlcmUgcmVhc29uIHRvCmJlbGlldmUgYW55
IG1vZGVsIHdpdGggYW4gUlYzNTAgaXNuJ3QgYWZmZWN0ZWQ/CgoKLS0gCkVhcnRobGluZyBNaWNo
ZWwgRMOkbnplciAgICAgICAgICAgfCAgICAgICAgICAgICAgICBodHRwOi8vd3d3LnZtd2FyZS5j
b20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgIHwgICAgICAgICAgRGViaWFuLCBY
IGFuZCBEUkkgZGV2ZWxvcGVyCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KQXBwcyBidWlsdCB3aXRo
IHRoZSBBZG9iZShSKSBGbGV4KFIpIGZyYW1ld29yayBhbmQgRmxleCBCdWlsZGVyKFRNKSBhcmUK
cG93ZXJpbmcgV2ViIDIuMCB3aXRoIGVuZ2FnaW5nLCBjcm9zcy1wbGF0Zm9ybSBjYXBhYmlsaXRp
ZXMuIFF1aWNrbHkgYW5kCmVhc2lseSBidWlsZCB5b3VyIFJJQXMgd2l0aCBGbGV4IEJ1aWxkZXIs
IHRoZSBFY2xpcHNlKFRNKWJhc2VkIGRldmVsb3BtZW50CnNvZnR3YXJlIHRoYXQgZW5hYmxlcyBp
bnRlbGxpZ2VudCBjb2RpbmcgYW5kIHN0ZXAtdGhyb3VnaCBkZWJ1Z2dpbmcuCkRvd25sb2FkIHRo
ZSBmcmVlIDYwIGRheSB0cmlhbC4gaHR0cDovL3Auc2YubmV0L3NmdS93d3ctYWRvYmUtY29tCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWZiZGV2
LWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mYmRldi1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5u
ZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZmJk
ZXYtZGV2ZWwK
