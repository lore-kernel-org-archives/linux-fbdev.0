From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
Subject: Re: [PATCH] Do set
	var	even	if	no	fb_check_var() provided.
Date: Fri, 29 Aug 2008 00:30:19 +0200
Message-ID: <1219962619.4421.230.camel@thor.sulgenrain.local>
References: <48B4E16C.4000107@renesas.com>
	<Pine.LNX.4.64.0808270855110.7910@anakin> <g94i4r$2hq$1@ger.gmane.org>
	<1219906414.4421.142.camel@thor.sulgenrain.local>
	<48B71C1D.9040908@gmx.de>
	<1219961318.4421.213.camel@thor.sulgenrain.local>
	<48B723B2.9060306@gmx.de>
	<1219961927.4421.220.camel@thor.sulgenrain.local>
	<48B72576.9050302@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYq0Z-00024q-6C for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 15:30:27 -0700
Received: from fg-out-1718.google.com ([72.14.220.159])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYq0X-00009R-QI
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 15:30:27 -0700
Received: by fg-out-1718.google.com with SMTP id d23so364400fga.32
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 28 Aug 2008 15:30:24 -0700 (PDT)
In-Reply-To: <48B72576.9050302@gmx.de>
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
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

T24gRnJpLCAyMDA4LTA4LTI5IGF0IDAwOjIzICswMjAwLCBIZWxnZSBEZWxsZXIgd3JvdGU6Cj4g
TWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gPiBPbiBGcmksIDIwMDgtMDgtMjkgYXQgMDA6MTYgKzAy
MDAsIEhlbGdlIERlbGxlciB3cm90ZToKPiA+PiBNaWNoZWwgRMOkbnplciB3cm90ZToKPiA+Pj4g
T24gVGh1LCAyMDA4LTA4LTI4IGF0IDIzOjQzICswMjAwLCBIZWxnZSBEZWxsZXIgd3JvdGU6Cj4g
Pj4+PiBZb3VyIGlkZWEgYWJvdXQgdGVzdGluZyBhIGZldyBtb2RlIGxpbmVzIGlzIG5vcm1hbGx5
IGEgZ29vZCBpZGVhLgo+ID4+PiBNeSBpZGVhIGlzIHF1aXRlIHRoZSBvcHBvc2l0ZSAtIHRvIHRy
eSAqd2l0aG91dCogZXZlbiB0aGUgTW9kZXMgbGluZSBpbgo+ID4+PiBTdWJTZWN0aW9uICJEaXNw
bGF5Ii4gQ2FuIHlvdSB0cnkgdGhhdCBwbGVhc2U/Cj4gPj4KPiA+PiBEb2Vzbid0IHdvcmsgZWl0
aGVyLgo+ID4+Cj4gPj4gYSkgSWYgSSBkcm9wIHRoZSAibW9uaXRvciIgbGluZSBpbiB0aGUgU2Ny
ZWVuIHNlY3Rpb24gaXQgY2hvb3NlcyBhIAo+ID4gCj4gPiBbLi4uXQo+ID4gCj4gPj4gYikgSWYg
SSBqdXN0IGRyb3AgdGhlIEhvcml6U3luYyBhbmQgVmVydFJlZnJlc2ggZW50cmllcywgaXQgZmFp
bHMgYXMgd2VsbDoKPiA+IAo+ID4gWy4uLl0KPiA+IAo+ID4gV2hpY2ggcGFydCBvZiAndGhlIE1v
ZGVzIGxpbmUgaW4gU3ViU2VjdGlvbiAiRGlzcGxheSInIGlzIHNvIGhhcmQgdG8KPiA+IHVuZGVy
c3RhbmQ/ICpzaHJ1ZyoKPiAKPiBEbyB5b3Ugd2FudCBtZSB0byBjaGFuZ2UgdGhpcyAoMTAyNHg3
NjgpOiA/Cj4gCVN1YlNlY3Rpb24gIkRpc3BsYXkiCj4gICAgICAgICAgICAgICAgICBEZXB0aCAg
ICAgICAgICAgOAo+ICAgICAgICAgICAgICAgICAgTW9kZXMgICAgICAgICAgICIxMDI0eDc2OCIK
PiAgICAgICAgICBFbmRTdWJTZWN0aW9uCgpOb3QgY2hhbmdlIGl0LCByZW1vdmUgaXQgKGhlbmNl
ICd3aXRob3V0JykuCgpJIHN1c3BlY3QgdGhlIHByb2JsZW0gaXMgdGhhdCB5b3UncmUgbWlzdW5k
ZXJzdGFuZGluZyB0aGUgbWVhbmluZyBvZgp0aGlzIGxpbmUuIEl0IHRlbGxzIHRoZSBYIHNlcnZl
ciB0byB0cnkgYWxsIHRoZSAxMDI0eDc2OCBtb2RlcyBmcm9tIGl0cwppbnRlcm5hbCBtb2RlIGRh
dGFiYXNlLCBub25lIG9mIHdoaWNoIG1hdGNoIHRoZSBtb2RlIG9mIHlvdXIgZnJhbWVidWZmZXIK
ZGV2aWNlIHVuc3VycHJpc2luZ2x5LiBJZiB5b3Ugb21pdCB0aGUgbGluZSwgdGhlIGZiZGV2IGRy
aXZlciB3aWxsIGdldAp0aGUgY3VycmVudCBtb2RlIGZyb20gdGhlIGZyYW1lYnVmZmVyIGRldmlj
ZSBhbmQgdHJ5IHRoYXQuIE5vdGUgdGhhdCB0aGUKcGl4Y2xvY2sgMCBjYW4gc3RpbGwgY2F1c2Ug
dHJvdWJsZSB3aXRoIFggc2VydmVycyBiZWZvcmUgdGhlIHVwY29taW5nCjEuNSByZWxlYXNlLgoK
Ci0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgIHwgICAgICAgICAgaHR0cDov
L3R1bmdzdGVuZ3JhcGhpY3MuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICB8
ICAgICAgICAgIERlYmlhbiwgWCBhbmQgRFJJIGRldmVsb3BlcgoKCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
VGhpcyBTRi5OZXQgZW1haWwgaXMgc3BvbnNvcmVkIGJ5IHRoZSBNb2JsaW4gWW91ciBNb3ZlIERl
dmVsb3BlcidzIGNoYWxsZW5nZQpCdWlsZCB0aGUgY29vbGVzdCBMaW51eCBiYXNlZCBhcHBsaWNh
dGlvbnMgd2l0aCBNb2JsaW4gU0RLICYgd2luIGdyZWF0IHByaXplcwpHcmFuZCBwcml6ZSBpcyBh
IHRyaXAgZm9yIHR3byB0byBhbiBPcGVuIFNvdXJjZSBldmVudCBhbnl3aGVyZSBpbiB0aGUgd29y
bGQKaHR0cDovL21vYmxpbi1jb250ZXN0Lm9yZy9yZWRpcmVjdC5waHA/YmFubmVyX2lkPTEwMCZ1
cmw9LwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1mYmRldi1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZmJkZXYtZGV2ZWxAbGlzdHMuc291cmNl
Zm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xp
bnV4LWZiZGV2LWRldmVsCg==
