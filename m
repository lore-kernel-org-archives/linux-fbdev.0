From: "Denys Fedoryshchenko" <denys@visp.net.lb>
Subject: Re: atyfb rmmod & vram crash, 2.6.24, 2.6.25-rc8
Date: Thu, 3 Apr 2008 13:10:37 +0300
Message-ID: <20080403095138.M76173@visp.net.lb>
References: <20080402124854.M56647@visp.net.lb> <20080403082336.GD16619@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JhMPH-0005n5-BV for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 Apr 2008 03:10:55 -0700
Received: from usermail.globalproof.net ([194.146.153.18])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JhMPF-0002sI-I4
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 Apr 2008 03:10:55 -0700
In-Reply-To: <20080403082336.GD16619@sci.fi>
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
To: Ville, UTF-8?, =?KOI8-R?Q?Syrj=C3=A4l=C3=A4_?= <syrjala@sci.fi>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

T24gVGh1LCAzIEFwciAyMDA4IDExOjIzOjM2ICswMzAwLCBWaWxsZSBbVVRGLTg/XVN5cmrDpGzD
pCB3cm90ZQo+IFRoaXMgcmVnaW9uIGlzIGFsd2F5cyAxNk1CIHJlZ2FyZGxlc3Mgb2YgaG93IG11
Y2ggYWN0dWFsIFJBTSBpcyBvbiAKPiB0aGUgY2FyZC4KWWVzLCB5b3UgYXJlIHJpZ2h0LgpUaGVy
ZSBpcyA0IGNoaXBzIEtNNDEzMkc1MTJRMTAsIGVhY2ggMTZNYml0LCBzbyBpdCBpcyA4MTkyS2J5
dGUuCgo+IFRoZSB2cmFtIHBhcmFtdGVyIHRha2VzIEtCIG5vdCBNQi4KPiAKPiBXaHkgZG8geW91
IHdhbnQgdG8gb3ZlcnJpZGUgaXQgYW55d2F5PyBJdCBzZWVtcyB0byBkZXRlY3QgdGhlIGFtb3Vu
dCAKPiBvZiBSQU0ganVzdCBmaW5lLgpPbiBzb21lIHNldHRpbmdzIGl0IHdhcyBlbm91Z2gsIGl0
IHdhcyBteSBtaXN0YWtlIHRvIHRyeSBzZXQgaXQgdG8gaGlnaGVyCnZhbHVlLiBCdXQgaW4gZmFj
dCBpdCBpcyBkaWZmaWN1bHQgdG8gZmluZCBhbnkgZG9jdW1lbnRhdGlvbiwgdGhhdCB2YWx1ZSBp
cyBpbgpLYnl0ZS4gUHJvYmFibHkgYXQgbGVhc3QgaXQgaGF2ZSB0byBiZSBkb2N1bWVudGVkIHRv
IGJlIHZpc2libGUgaW4gbW9kaW5mby4KCj4gCj4gRG9lcyB0aGlzIG9ubHkgaGFwcGVuIGFmdGVy
IHRoZSBmYWlsdXJlIGNhdXNlZCBieSB0aGUgYmFkIHZyYW0gcGFyYW1ldGVyPwpZZXMsIG9ubHkg
YnkgYmFkIHZyYW0gcGFyYW1ldGVyLgo+IAo+IC0tIAo+IFZpbGxlIFN5cmrkbOQKPiBzeXJqYWxh
QHNjaS5maQo+IGh0dHA6Ly93d3cuc2NpLmZpL35zeXJqYWxhLwoKCi0tCkRlbnlzIEZlZG9yeXNo
Y2hlbmtvClRlY2huaWNhbCBNYW5hZ2VyClZpcnR1YWwgSVNQIFMuQS5MLgoKCi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KQ2hlY2sgb3V0IHRoZSBuZXcgU291cmNlRm9yZ2UubmV0IE1hcmtldHBsYWNlLgpJdCdz
IHRoZSBiZXN0IHBsYWNlIHRvIGJ1eSBvciBzZWxsIHNlcnZpY2VzIGZvcgpqdXN0IGFib3V0IGFu
eXRoaW5nIE9wZW4gU291cmNlLgpodHRwOi8vYWQuZG91YmxlY2xpY2submV0L2NsazsxNjQyMTYy
Mzk7MTM1MDMwMzg7dz9odHRwOi8vc2YubmV0L21hcmtldHBsYWNlCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWZiZGV2LWRldmVsIG1haWxpbmcg
bGlzdApMaW51eC1mYmRldi1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0
cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZmJkZXYtZGV2ZWwK
