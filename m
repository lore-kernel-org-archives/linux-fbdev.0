From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] Add fb_check_var() for fixed mode
 device.
Date: Wed, 03 Sep 2008 21:24:39 +0200
Message-ID: <48BEE477.8010505@gmx.de>
References: <48B4E16C.4000107@renesas.com>	
	<Pine.LNX.4.64.0808270855110.7910@anakin>
	<g94i4r$2hq$1@ger.gmane.org>	 <20080828074521.GO16680@sci.fi>
	<48B785DA.1030408@renesas.com>	
	<1219999758.4421.259.camel@thor.sulgenrain.local>	
	<Pine.LNX.4.64.0808291127510.18326@anakin>	
	<1220017912.4421.291.camel@thor.sulgenrain.local>	
	<Pine.LNX.4.64.0808291610230.18326@anakin>	
	<1220019790.4421.297.camel@thor.sulgenrain.local>
	<48B90BD3.4020702@gmx.de>	 <48BD8FF0.5050905@gmx.de>
	<1220436713.4421.623.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KaxyG-0007b8-HB for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 12:24:52 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1KaxyF-0004g9-UJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 12:24:52 -0700
In-Reply-To: <1220436713.4421.623.camel@thor.sulgenrain.local>
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
To: =?UTF-8?B?TWljaGVsIETDpG56ZXI=?= <michel@tungstengraphics.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Ville Syrj?l? <syrjala@sci.fi>, Geert Uytterhoeven <geert@linux-m68k.org>

TWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gT24gVHVlLCAyMDA4LTA5LTAyIGF0IDIxOjExICswMjAw
LCBIZWxnZSBEZWxsZXIgd3JvdGU6Cj4+IEhlbGdlIERlbGxlciB3cm90ZToKPj4+IFRoZSBhdHRh
Y2hlZCBwYXRjaCBpcyBhIGNvbXBsZXRlbHkgZGlmZmVyZW50IGFwcHJvYWNoIHRvIHNvbHZlIHRo
ZSAKPj4+IGlzc3VlLiBJJ3ZlIHRlc3RlZCBpdCwgYW5kIGl0IHdvcmtzIGV2ZW4gd2l0aCB0aGUg
YnVnZ3kgdmVyc2lvbiBvZiBYIAo+Pj4gKDEuNC4yKS4KPj4+Cj4+PiBCYXNpYyBpZGVhIGlzLCB0
aGF0IHdoZW4gd2UgaGF2ZSBmaXhlZCBtb2RlIGRldmljZXMgKGFrYSBkcml2ZXJzIHdoaWNoIAo+
Pj4gZG9uJ3QgaW1wbGVtZW50IGZiX2NoZWNrX3Zhcikgd2UganVzdCBzaW1wbHkgZmlsbCBpbiBh
ICJlbXVsYXRlZCIgdmFsaWQgCj4+PiBtb25pdG9yL21vZGVsaW5lIGludG8gdGhlIHZhciBzdHJ1
Y3QgZHVyaW5nIHRoZSByZWdpc3Rlcl9mcmFtZWJ1ZmZlcigpIAo+Pj4gaW5pdGlhbGl6YXRpb24g
Y2FsbC4gU2luY2UgdGhlIG1vZGVsaW5lIGlzIHZhbGlkLCBYIGRvZXMgbm90IGhhcyBhbnkgCj4+
PiBwcm9ibGVtcyB3aXRoIGl0Lgo+Pj4KPj4+IFRoZSBwYXRjaCBoYXMgYSBmZXcgYmVuZWZpdHM6
Cj4+PiBhKSBXZSBzdGlsbCBrZWVwIGJpbmFyeSBjb21wYXRhYmlsaXR5L2JlaGF2aW9yIGZvciBG
QklPR0VUX1ZTQ1JFRU5JTkZPIAo+Pj4gYW5kIEZCSU9QVVRfVlNDUkVFTklORk8uCj4+PiBiKSBJ
biBYb3JnLmNvbmYgZmlsZXMsIHVzZXJzIGNhbiBzaW1wbHkgZGVsZXRlIGFsbCBtb25pdG9yIGFu
ZCBkaXNwbGF5IAo+Pj4gc2VjdGlvbnMgLT4gWG9yZyB3aWxsIGF1dG9jb25maWd1cmUgaXRzZWxm
IHRvIHRoZSBvbmx5IHZhbGlkIAo+Pj4gcmVzb2x1dGlvbi9tb2RlbGluZSBpdHNlbGYgb24gYWxs
IGRldmljZXMgKEkgcmVhbGx5IGxpa2UgdGhpcyEhISkKPj4+Cj4+PiBUaHVzLCB0aGUgcGF0Y2gg
YmFzaWNhbGx5IGNoYW5nZXMgdGhlIGZpeGVkIG1vZGUgZHJpdmVycyB0byBoYXZlIHNvbWUgCj4+
PiBtb25pdG9yIHRpbWluZ3MgYnkgZGVmYXVsdC4gQXMgYW4gZXhhbXBsZSwgYmVmb3JlIEkgZ290
Ogo+Pj4gcm9vdEBjMzAwMDp+IyBmYnNldCAtaQo+Pj4gbW9kZSAiMTAyNHg3NjgiCj4+PiAgICAg
Z2VvbWV0cnkgMTAyNCA3NjggMTAyNCA3NjggOAo+Pj4gICAgIHRpbWluZ3MgMCAwIDAgMCAwIDAg
MAo+Pj4gICAgIHJnYmEgOC8wLDgvMCw4LzAsMC8wCj4+PiBlbmRtb2RlCj4+Pgo+Pj4gTm93IEkg
c2VlOgo+Pj4gcm9vdEBjMzAwMDp+IyBmYnNldCAtaQo+Pj4gbW9kZSAiMTAyNHg3NjgtNjAiCj4+
PiAgICAgIyBEOiA2NS4wMDMgTUh6LCBIOiA0OC4zNjUga0h6LCBWOiA2MC4wMDYgSHoKPj4+ICAg
ICBnZW9tZXRyeSAxMDI0IDc2OCAxMDI0IDc2OCA4Cj4+PiAgICAgdGltaW5ncyAxNTM4NCAxNjgg
OCAyOSAzIDE0NCA2Cj4+PiAgICAgcmdiYSA4LzAsOC8wLDgvMCwwLzAKPj4+IGVuZG1vZGUKPj4+
Cj4+PiBPcGluaW9ucyA/Cj4+IFNhZGx5IG5vYm9keSBhbnN3ZXJlZCB5ZXQuLi4uCj4gCj4gRldJ
VywgSSBsaWtlIHRoaXMgYXBwcm9hY2ggbXVjaCBiZXR0ZXIuCgpUaGFua3MgTWljaGVsLAoKSSds
bCBzZW5kIGFuIHVwZGF0ZWQgcGF0Y2ggc2hvcnRseSAoaW4gYSBuZXcgdGhyZWFkKSB3aGljaApm
aXhlcyB0aGUgZW5nbGlzaCBjb21tZW50IGFzIHdlbGwuCgpIZWxnZQoKCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KVGhpcyBTRi5OZXQgZW1haWwgaXMgc3BvbnNvcmVkIGJ5IHRoZSBNb2JsaW4gWW91ciBNb3Zl
IERldmVsb3BlcidzIGNoYWxsZW5nZQpCdWlsZCB0aGUgY29vbGVzdCBMaW51eCBiYXNlZCBhcHBs
aWNhdGlvbnMgd2l0aCBNb2JsaW4gU0RLICYgd2luIGdyZWF0IHByaXplcwpHcmFuZCBwcml6ZSBp
cyBhIHRyaXAgZm9yIHR3byB0byBhbiBPcGVuIFNvdXJjZSBldmVudCBhbnl3aGVyZSBpbiB0aGUg
d29ybGQKaHR0cDovL21vYmxpbi1jb250ZXN0Lm9yZy9yZWRpcmVjdC5waHA/YmFubmVyX2lkPTEw
MCZ1cmw9LwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1mYmRldi1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZmJkZXYtZGV2ZWxAbGlzdHMuc291
cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZv
L2xpbnV4LWZiZGV2LWRldmVsCg==
