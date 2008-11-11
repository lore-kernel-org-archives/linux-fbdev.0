From: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
Subject: Re: Seg fault on any FB write (Epson S1D13A04on
 Coldfire running 2.6.25)
Date: Tue, 11 Nov 2008 16:04:03 +0100
Message-ID: <49199EE3.5090101@cetrtapot.si>
References: <4918E5C3.2090108@one.net> <49195726.2060103@cetrtapot.si>
	<43185.137.237.242.42.1226415047.squirrel@webmail.nuvox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hinko.kocevar@cetrtapot.si>) id 1KzuqK-0008W1-Bi
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Nov 2008 15:07:48 +0000
Received: from zimbra-mta.cetrtapot.si ([89.212.80.172])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KzuqI-00029r-3H for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Nov 2008 15:07:48 +0000
In-Reply-To: <43185.137.237.242.42.1226415047.squirrel@webmail.nuvox.net>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: jkimble@one.net
Cc: linux-fbdev-devel@lists.sourceforge.net

amtpbWJsZUBvbmUubmV0IHdyb3RlOgo+PiBKYW1lcyBLaW1ibGUgd3JvdGU6Cj4gCj4gL3Byb2Mv
aW9tZW0gc2hvd3M6Cj4gCj4gNzQwMDAwMDAtNzQwMDkwMDAgOiBzMWQxM2EwNGZiLjAKPiA3NDAw
MDAwMC03NDAwOTAwMCA6IHMxZDEzeHh4ZmIgcmVncwo+IDc0MDQwMDAwLTc0MDY4MDAwIDogczFk
MTNhMDRmYi4wCj4gNzQwNDAwMDAtNzQwNjgwMDAgOiBzMWQxM3h4eGZiIG1lbQoKSSdtIG5vdCBz
dXJlIGlmIHRoaXMgaXMgY29ycmVjdCAtIHR3byBkcml2ZXJzIG1hcHBlZCB0aGUgc2FtZSByZWdp
b24gdHdpY2UgIT8KTWF5YmUgdGhlIGV4cGVydHMgd2lsbCBzaGVkIHNvbWUgbGlnaHQgb24gdGhp
cy4uCgo+IGYwMDAwNzBjLWYwMDAwNzBjIDogc3BpLWludC1tYXNrCj4gZjAwMDA3NDAtZjAwMDA3
NWYgOiBzcGktaW50LWxldmVsCj4gZjAwMDBhNTAtZjAwMDBhNTAgOiBzcGktcGFyCj4gZjAwMDhh
MDAtZjAwMDhhYjggOiBzcGktbW9kdWxlCj4gZjAwMDhmMDAtZjAwMDhmMjAgOiBNQ0Y1NDhYLWky
Ywo+IGYwMDBhMDAwLWYwMDBhN2ZmIDogbWNmNTQ4eC1mbGV4Y2FuLjAKPiBmMDAwYTAwMC1mMDAw
YTdmZiA6IG1jZjU0OHgtZmxleGNhbgo+IGYwMDBhODAwLWYwMDBhZmZmIDogbWNmNTQ4eC1mbGV4
Y2FuLjEKPiBmMDAwYTgwMC1mMDAwYWZmZiA6IG1jZjU0OHgtZmxleGNhbgo+IGYwMDIwMDAwLWYw
MDMzMDAwIDogZnNsLXNlYzEKPiBmYzAwMDAwMC1mZmZmZmZmZiA6IHBoeXNtYXAtZmxhc2guMAo+
IAoKSSBoYXZlbid0IHRvb2sgYSBsb25nIGxvb2sgYXQgeW91ciBkcml2ZXIsIGJ1dCBoZXJlIGlz
IG91ciBkcml2ZXIgZm9yIFMxMzcwNkZCIHRoYXQKd2UgdXNlIG9uIG91ciBlbWJlZGRlZCBwbGF0
Zm9ybS4gSG9wZSBpdCBoZWxwcy4KClJlZ2FyZHMsCkhpbmtvCi0tIApIaW5rbyBLb8SNZXZhciwg
T1NTIGRldmVsb3BlcgrEjEVUUlRBIFBPVCwgZC5vLm8uClBsYW5pbmEgMywgNDAwMCBLcmFuaiwg
U0kgRVUKdGVsICAgICArKzM4NiAoMCkgNCAyODAgNjYgMDMKZS1tYWlsICBoaW5rby5rb2NldmFy
QGNldHJ0YXBvdC5zaQpodHRwICAgIHd3dy5jZXRydGFwb3Quc2kKCgotLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
ClRoaXMgU0YuTmV0IGVtYWlsIGlzIHNwb25zb3JlZCBieSB0aGUgTW9ibGluIFlvdXIgTW92ZSBE
ZXZlbG9wZXIncyBjaGFsbGVuZ2UKQnVpbGQgdGhlIGNvb2xlc3QgTGludXggYmFzZWQgYXBwbGlj
YXRpb25zIHdpdGggTW9ibGluIFNESyAmIHdpbiBncmVhdCBwcml6ZXMKR3JhbmQgcHJpemUgaXMg
YSB0cmlwIGZvciB0d28gdG8gYW4gT3BlbiBTb3VyY2UgZXZlbnQgYW55d2hlcmUgaW4gdGhlIHdv
cmxkCmh0dHA6Ly9tb2JsaW4tY29udGVzdC5vcmcvcmVkaXJlY3QucGhwP2Jhbm5lcl9pZD0xMDAm
dXJsPS8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtZmJkZXYtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWZiZGV2LWRldmVsQGxpc3RzLnNvdXJj
ZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9s
aW51eC1mYmRldi1kZXZlbAo=
