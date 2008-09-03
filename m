From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
Subject: Re: [PATCH] Add fb_check_var() for fixed
	mode	device.
Date: Wed, 03 Sep 2008 12:11:53 +0200
Message-ID: <1220436713.4421.623.camel@thor.sulgenrain.local>
References: <48B4E16C.4000107@renesas.com>
	<Pine.LNX.4.64.0808270855110.7910@anakin> <g94i4r$2hq$1@ger.gmane.org>
	<20080828074521.GO16680@sci.fi>  <48B785DA.1030408@renesas.com>
	<1219999758.4421.259.camel@thor.sulgenrain.local>
	<Pine.LNX.4.64.0808291127510.18326@anakin>
	<1220017912.4421.291.camel@thor.sulgenrain.local>
	<Pine.LNX.4.64.0808291610230.18326@anakin>
	<1220019790.4421.297.camel@thor.sulgenrain.local>
	<48B90BD3.4020702@gmx.de> <48BD8FF0.5050905@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KapLI-0006KY-3H for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 03:12:04 -0700
Received: from fg-out-1718.google.com ([72.14.220.155])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KapLF-0003vX-UG
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 03:12:03 -0700
Received: by fg-out-1718.google.com with SMTP id d23so108734fga.32
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 03 Sep 2008 03:11:59 -0700 (PDT)
In-Reply-To: <48BD8FF0.5050905@gmx.de>
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
To: Helge Deller <deller@gmx.de>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Ville Syrj?l? <syrjala@sci.fi>, Geert Uytterhoeven <geert@linux-m68k.org>

T24gVHVlLCAyMDA4LTA5LTAyIGF0IDIxOjExICswMjAwLCBIZWxnZSBEZWxsZXIgd3JvdGU6Cj4g
SGVsZ2UgRGVsbGVyIHdyb3RlOgo+ID4gVGhlIGF0dGFjaGVkIHBhdGNoIGlzIGEgY29tcGxldGVs
eSBkaWZmZXJlbnQgYXBwcm9hY2ggdG8gc29sdmUgdGhlIAo+ID4gaXNzdWUuIEkndmUgdGVzdGVk
IGl0LCBhbmQgaXQgd29ya3MgZXZlbiB3aXRoIHRoZSBidWdneSB2ZXJzaW9uIG9mIFggCj4gPiAo
MS40LjIpLgo+ID4gCj4gPiBCYXNpYyBpZGVhIGlzLCB0aGF0IHdoZW4gd2UgaGF2ZSBmaXhlZCBt
b2RlIGRldmljZXMgKGFrYSBkcml2ZXJzIHdoaWNoIAo+ID4gZG9uJ3QgaW1wbGVtZW50IGZiX2No
ZWNrX3Zhcikgd2UganVzdCBzaW1wbHkgZmlsbCBpbiBhICJlbXVsYXRlZCIgdmFsaWQgCj4gPiBt
b25pdG9yL21vZGVsaW5lIGludG8gdGhlIHZhciBzdHJ1Y3QgZHVyaW5nIHRoZSByZWdpc3Rlcl9m
cmFtZWJ1ZmZlcigpIAo+ID4gaW5pdGlhbGl6YXRpb24gY2FsbC4gU2luY2UgdGhlIG1vZGVsaW5l
IGlzIHZhbGlkLCBYIGRvZXMgbm90IGhhcyBhbnkgCj4gPiBwcm9ibGVtcyB3aXRoIGl0Lgo+ID4g
Cj4gPiBUaGUgcGF0Y2ggaGFzIGEgZmV3IGJlbmVmaXRzOgo+ID4gYSkgV2Ugc3RpbGwga2VlcCBi
aW5hcnkgY29tcGF0YWJpbGl0eS9iZWhhdmlvciBmb3IgRkJJT0dFVF9WU0NSRUVOSU5GTyAKPiA+
IGFuZCBGQklPUFVUX1ZTQ1JFRU5JTkZPLgo+ID4gYikgSW4gWG9yZy5jb25mIGZpbGVzLCB1c2Vy
cyBjYW4gc2ltcGx5IGRlbGV0ZSBhbGwgbW9uaXRvciBhbmQgZGlzcGxheSAKPiA+IHNlY3Rpb25z
IC0+IFhvcmcgd2lsbCBhdXRvY29uZmlndXJlIGl0c2VsZiB0byB0aGUgb25seSB2YWxpZCAKPiA+
IHJlc29sdXRpb24vbW9kZWxpbmUgaXRzZWxmIG9uIGFsbCBkZXZpY2VzIChJIHJlYWxseSBsaWtl
IHRoaXMhISEpCj4gPiAKPiA+IFRodXMsIHRoZSBwYXRjaCBiYXNpY2FsbHkgY2hhbmdlcyB0aGUg
Zml4ZWQgbW9kZSBkcml2ZXJzIHRvIGhhdmUgc29tZSAKPiA+IG1vbml0b3IgdGltaW5ncyBieSBk
ZWZhdWx0LiBBcyBhbiBleGFtcGxlLCBiZWZvcmUgSSBnb3Q6Cj4gPiByb290QGMzMDAwOn4jIGZi
c2V0IC1pCj4gPiBtb2RlICIxMDI0eDc2OCIKPiA+ICAgICBnZW9tZXRyeSAxMDI0IDc2OCAxMDI0
IDc2OCA4Cj4gPiAgICAgdGltaW5ncyAwIDAgMCAwIDAgMCAwCj4gPiAgICAgcmdiYSA4LzAsOC8w
LDgvMCwwLzAKPiA+IGVuZG1vZGUKPiA+IAo+ID4gTm93IEkgc2VlOgo+ID4gcm9vdEBjMzAwMDp+
IyBmYnNldCAtaQo+ID4gbW9kZSAiMTAyNHg3NjgtNjAiCj4gPiAgICAgIyBEOiA2NS4wMDMgTUh6
LCBIOiA0OC4zNjUga0h6LCBWOiA2MC4wMDYgSHoKPiA+ICAgICBnZW9tZXRyeSAxMDI0IDc2OCAx
MDI0IDc2OCA4Cj4gPiAgICAgdGltaW5ncyAxNTM4NCAxNjggOCAyOSAzIDE0NCA2Cj4gPiAgICAg
cmdiYSA4LzAsOC8wLDgvMCwwLzAKPiA+IGVuZG1vZGUKPiA+IAo+ID4gT3BpbmlvbnMgPwo+IAo+
IFNhZGx5IG5vYm9keSBhbnN3ZXJlZCB5ZXQuLi4uCgpGV0lXLCBJIGxpa2UgdGhpcyBhcHByb2Fj
aCBtdWNoIGJldHRlci4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICB8
ICAgICAgICAgIGh0dHA6Ly90dW5nc3RlbmdyYXBoaWNzLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRo
dXNpYXN0ICAgICAgICAgfCAgICAgICAgICBEZWJpYW4sIFggYW5kIERSSSBkZXZlbG9wZXIKCgot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tClRoaXMgU0YuTmV0IGVtYWlsIGlzIHNwb25zb3JlZCBieSB0aGUgTW9i
bGluIFlvdXIgTW92ZSBEZXZlbG9wZXIncyBjaGFsbGVuZ2UKQnVpbGQgdGhlIGNvb2xlc3QgTGlu
dXggYmFzZWQgYXBwbGljYXRpb25zIHdpdGggTW9ibGluIFNESyAmIHdpbiBncmVhdCBwcml6ZXMK
R3JhbmQgcHJpemUgaXMgYSB0cmlwIGZvciB0d28gdG8gYW4gT3BlbiBTb3VyY2UgZXZlbnQgYW55
d2hlcmUgaW4gdGhlIHdvcmxkCmh0dHA6Ly9tb2JsaW4tY29udGVzdC5vcmcvcmVkaXJlY3QucGhw
P2Jhbm5lcl9pZD0xMDAmdXJsPS8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtZmJkZXYtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWZiZGV2LWRl
dmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9s
aXN0cy9saXN0aW5mby9saW51eC1mYmRldi1kZXZlbAo=
