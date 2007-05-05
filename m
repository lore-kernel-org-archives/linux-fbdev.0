From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 06/20] vt8623fb: New
	framebuffer	driver for VIA VT8623
Date: Sun, 06 May 2007 07:07:37 +0800
Message-ID: <1178406457.22828.7.camel@daplas>
References: <463C996A.9050005@gmail.com> <20070505181551.GB6016@sci.fi>
	<20070505200801.GA28014@localhost.localdomain>
	<20070505203450.GC6016@sci.fi>  <20070505224855.GA18807@skynet.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HkTLs-0002lG-OV for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 16:07:44 -0700
Received: from py-out-1112.google.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HkTLs-0008Tk-CU
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 16:07:44 -0700
Received: by py-out-1112.google.com with SMTP id a29so947534pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 05 May 2007 16:07:43 -0700 (PDT)
In-Reply-To: <20070505224855.GA18807@skynet.be>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Content-Type: text/plain; charset="euc-kr"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Luc Verhaegen <libv@skynet.be>

T24gU3VuLCAyMDA3LTA1LTA2IGF0IDAwOjQ4ICswMjAwLCBMdWMgVmVyaGFlZ2VuIHdyb3RlOgo+
IE9uIFNhdCwgTWF5IDA1LCAyMDA3IGF0IDExOjM0OjUxUE0gKzAzMDAsIFZpbGxlIFN5cmrDpGzD
pCB3cm90ZToKPiA+IE9uIFNhdCwgTWF5IDA1LCAyMDA3IGF0IDEwOjA4OjAxUE0gKzAyMDAsIE9u
ZHJlaiBaYWppY2VrIHdyb3RlOgo+ID4gPiBPbiBTYXQsIE1heSAwNSwgMjAwNyBhdCAwOToxNTo1
MVBNICswMzAwLCBWaWxsZSBTeXJqw6Rsw6Qgd3JvdGU6Cj4gPiA+ID4gPiArCXZ0ODYyM2ZiIC0g
ZmJkZXYgZHJpdmVyIGZvciBncmFwaGljcyBjb3JlIGluIFZJQSBWVDg2MjMgY2hpcHNldAo+ID4g
PiA+ID4gKwk9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0KPiA+ID4gPiAKPiA+ID4gPiBEb2Vzbid0IHZpYWZiIHN1cHBvcnQgdGhp
cyBoYXJkd2FyZT8KPiA+ID4gCj4gPiA+IFllcywgdGhpcyBoYXJkd2FyZSBpcyBzdXBwb3J0ZWQg
Ynkgc2V2ZXJhbCBvdXQtb2YtdHJlZSBkcml2ZXJzLAo+ID4gPiBzb21lIG9mIHRoZW0gYXJlIG5h
bWVkIHZpYWZiLgo+ID4gCj4gPiBUaGUgIm9mZmljaWFsIiAoaWUuIHRoZSBvbmUgZnJvbSB2aWEp
IHdhcyBqdXN0IHBvc3RlZCBoZXJlIGZvciBpbmNsdXNpb24uCj4gCj4gWW91IG1lYW4gdGhhdCB0
aW55IG9uZSB3aGljaCB0YWxrcyBhYm91dCBHVUVVRXMgYW5kIHN1Y2g/CgpJIGhvcGUgeW91J3Jl
IGJlaW5nIGlyb25pYyB3aXRoIHRoZSAndGlueScgOi0pLCBiZWNhdXNlIHRoZSBwYXRjaCB0aGF0
CmNhbWUgZnJvbSBWSUEgd2FzIGh1bW9uZ291cy4KCj4gCj4gV2hvIHBsYW5zIG9uIGNsZWFuaW5n
IHRoYXQgb25lIHVwPyBXaG8gaXMgcHJlcGFyZWQgdG8gc2VlIFZJQSBqdXN0IAo+IHBsb3VnaCBv
biByZWdhcmRsZXNzIGFmdGVyIHRoYXQsIGp1c3QgbGlrZSBWSUEgZGlkIHdpdGggdGhlIFggZHJp
dmVyPwo+IAoKWWVwLCBqdXN0IGxvb2tpbmcgYXQgdGhhdCBwYXRjaCwgaXQgd2lsbCBiZSBhIGRp
ZmZpY3VsdCBvbmUgdG8gY2xlYW4gdXAuCgpUb255CgoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KVGhpcyBT
Ri5uZXQgZW1haWwgaXMgc3BvbnNvcmVkIGJ5IERCMiBFeHByZXNzCkRvd25sb2FkIERCMiBFeHBy
ZXNzIEMgLSB0aGUgRlJFRSB2ZXJzaW9uIG9mIERCMiBleHByZXNzIGFuZCB0YWtlCmNvbnRyb2wg
b2YgeW91ciBYTUwuIE5vIGxpbWl0cy4gSnVzdCBkYXRhLiBDbGljayB0byBnZXQgaXQgbm93Lgpo
dHRwOi8vc291cmNlZm9yZ2UubmV0L3Bvd2VyYmFyL2RiMi8KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZmJkZXYtZGV2ZWwgbWFpbGluZyBsaXN0
CkxpbnV4LWZiZGV2LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNv
dXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mYmRldi1kZXZlbAo=
