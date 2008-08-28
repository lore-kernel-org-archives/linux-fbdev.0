From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] Do set var
 even	if	no	fb_check_var() provided.
Date: Fri, 29 Aug 2008 00:23:50 +0200
Message-ID: <48B72576.9050302@gmx.de>
References: <48B4E16C.4000107@renesas.com>	
	<Pine.LNX.4.64.0808270855110.7910@anakin>
	<g94i4r$2hq$1@ger.gmane.org>	
	<1219906414.4421.142.camel@thor.sulgenrain.local>
	<48B71C1D.9040908@gmx.de>	
	<1219961318.4421.213.camel@thor.sulgenrain.local>
	<48B723B2.9060306@gmx.de>
	<1219961927.4421.220.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYpuK-0001Rt-Mk for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 15:24:01 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1KYpuJ-0006EM-3q
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 15:24:00 -0700
In-Reply-To: <1219961927.4421.220.camel@thor.sulgenrain.local>
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
To: =?UTF-8?B?TWljaGVsIETDpG56ZXI=?= <michel@tungstengraphics.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

TWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gT24gRnJpLCAyMDA4LTA4LTI5IGF0IDAwOjE2ICswMjAw
LCBIZWxnZSBEZWxsZXIgd3JvdGU6Cj4+IE1pY2hlbCBEw6RuemVyIHdyb3RlOgo+Pj4gT24gVGh1
LCAyMDA4LTA4LTI4IGF0IDIzOjQzICswMjAwLCBIZWxnZSBEZWxsZXIgd3JvdGU6Cj4+Pj4gWW91
ciBpZGVhIGFib3V0IHRlc3RpbmcgYSBmZXcgbW9kZSBsaW5lcyBpcyBub3JtYWxseSBhIGdvb2Qg
aWRlYS4KPj4+IE15IGlkZWEgaXMgcXVpdGUgdGhlIG9wcG9zaXRlIC0gdG8gdHJ5ICp3aXRob3V0
KiBldmVuIHRoZSBNb2RlcyBsaW5lIGluCj4+PiBTdWJTZWN0aW9uICJEaXNwbGF5Ii4gQ2FuIHlv
dSB0cnkgdGhhdCBwbGVhc2U/Cj4+Cj4+IERvZXNuJ3Qgd29yayBlaXRoZXIuCj4+Cj4+IGEpIElm
IEkgZHJvcCB0aGUgIm1vbml0b3IiIGxpbmUgaW4gdGhlIFNjcmVlbiBzZWN0aW9uIGl0IGNob29z
ZXMgYSAKPiAKPiBbLi4uXQo+IAo+PiBiKSBJZiBJIGp1c3QgZHJvcCB0aGUgSG9yaXpTeW5jIGFu
ZCBWZXJ0UmVmcmVzaCBlbnRyaWVzLCBpdCBmYWlscyBhcyB3ZWxsOgo+IAo+IFsuLi5dCj4gCj4g
V2hpY2ggcGFydCBvZiAndGhlIE1vZGVzIGxpbmUgaW4gU3ViU2VjdGlvbiAiRGlzcGxheSInIGlz
IHNvIGhhcmQgdG8KPiB1bmRlcnN0YW5kPyAqc2hydWcqCgpEbyB5b3Ugd2FudCBtZSB0byBjaGFu
Z2UgdGhpcyAoMTAyNHg3NjgpOiA/CglTdWJTZWN0aW9uICJEaXNwbGF5IgogICAgICAgICAgICAg
ICAgIERlcHRoICAgICAgICAgICA4CiAgICAgICAgICAgICAgICAgTW9kZXMgICAgICAgICAgICIx
MDI0eDc2OCIKICAgICAgICAgRW5kU3ViU2VjdGlvbgoKV2h5PwpUaGVyZSBpcyBubyByZWFzb24u
ClRoZSBoYXJkd2FyZSBjYW4gb25seSBydW4gYXQgMTAyNHg3NjggYXQgOGJwcC4KSWYgSSBjaGFu
Z2UgdGhpcywgaXQgd2lsbCBjbGVhcmx5IGZhaWwuCk5vIG5lZWQgdG8gdHJ5IGFzIHRoZSBhbnN3
ZXIgaXMgY2xlYXIuCgpSZWFzb246CnJvb3RAYzMwMDA6L3Vzci9saWIveG9yZy9tb2R1bGVzL2xp
bnV4IyBmYnNldCAtaQoKbW1vZGUgIjEwMjR4NzY4IgogICAgIGdlb21ldHJ5IDEwMjQgNzY4IDEw
MjQgNzY4IDgKICAgICB0aW1pbmdzIDAgMCAwIDAgMCAwIDAKICAgICByZ2JhIDgvMCw4LzAsOC8w
LDAvMAplbmRtb2RlCgpGcmFtZSBidWZmZXIgZGV2aWNlIGluZm9ybWF0aW9uOgogICAgIE5hbWUg
ICAgICAgIDogc3RpZmIKICAgICBBZGRyZXNzICAgICA6IDB4ZjkwMDAwMDAKICAgICBTaXplICAg
ICAgICA6IDE1NzI4NjQKICAgICBUeXBlICAgICAgICA6IFBBQ0tFRCBQSVhFTFMKICAgICBWaXN1
YWwgICAgICA6IFBTRVVET0NPTE9SCiAgICAgWFBhblN0ZXAgICAgOiAwCiAgICAgWVBhblN0ZXAg
ICAgOiAwCiAgICAgWVdyYXBTdGVwICAgOiAwCiAgICAgTGluZUxlbmd0aCAgOiAyMDQ4CiAgICAg
TU1JTyBBZGRyZXNzOiAweGY4MTAwMDAwCiAgICAgTU1JTyBTaXplICAgOiA0MTk0MzA0CiAgICAg
QWNjZWxlcmF0b3IgOiBObwoKSGVsZ2UKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KVGhpcyBTRi5OZXQgZW1h
aWwgaXMgc3BvbnNvcmVkIGJ5IHRoZSBNb2JsaW4gWW91ciBNb3ZlIERldmVsb3BlcidzIGNoYWxs
ZW5nZQpCdWlsZCB0aGUgY29vbGVzdCBMaW51eCBiYXNlZCBhcHBsaWNhdGlvbnMgd2l0aCBNb2Js
aW4gU0RLICYgd2luIGdyZWF0IHByaXplcwpHcmFuZCBwcml6ZSBpcyBhIHRyaXAgZm9yIHR3byB0
byBhbiBPcGVuIFNvdXJjZSBldmVudCBhbnl3aGVyZSBpbiB0aGUgd29ybGQKaHR0cDovL21vYmxp
bi1jb250ZXN0Lm9yZy9yZWRpcmVjdC5waHA/YmFubmVyX2lkPTEwMCZ1cmw9LwpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mYmRldi1kZXZlbCBt
YWlsaW5nIGxpc3QKTGludXgtZmJkZXYtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBz
Oi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWZiZGV2LWRldmVs
Cg==
