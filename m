From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
Subject: Re: [PATCH] Do
	set	var	even	if	no	fb_check_var() provided.
Date: Fri, 29 Aug 2008 00:47:15 +0200
Message-ID: <1219963635.4421.235.camel@thor.sulgenrain.local>
References: <48B4E16C.4000107@renesas.com>
	<Pine.LNX.4.64.0808270855110.7910@anakin> <g94i4r$2hq$1@ger.gmane.org>
	<1219906414.4421.142.camel@thor.sulgenrain.local>
	<48B71C1D.9040908@gmx.de>
	<1219961318.4421.213.camel@thor.sulgenrain.local>
	<48B723B2.9060306@gmx.de>
	<1219961927.4421.220.camel@thor.sulgenrain.local>
	<48B72576.9050302@gmx.de>
	<1219962619.4421.230.camel@thor.sulgenrain.local>
	<48B7284B.6090602@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYqGz-0003em-C3 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 15:47:25 -0700
Received: from fg-out-1718.google.com ([72.14.220.158])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYqGw-00038l-OU
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 15:47:25 -0700
Received: by fg-out-1718.google.com with SMTP id d23so368056fga.32
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 28 Aug 2008 15:47:20 -0700 (PDT)
In-Reply-To: <48B7284B.6090602@gmx.de>
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
Content-Type: text/plain; charset="euc-kr"
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

T24gRnJpLCAyMDA4LTA4LTI5IGF0IDAwOjM1ICswMjAwLCBIZWxnZSBEZWxsZXIgd3JvdGU6Cj4g
TWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gPiBPbiBGcmksIDIwMDgtMDgtMjkgYXQgMDA6MjMgKzAy
MDAsIEhlbGdlIERlbGxlciB3cm90ZToKPiA+PiBNaWNoZWwgRMOkbnplciB3cm90ZToKPiA+Pj4g
T24gRnJpLCAyMDA4LTA4LTI5IGF0IDAwOjE2ICswMjAwLCBIZWxnZSBEZWxsZXIgd3JvdGU6Cj4g
Pj4+PiBNaWNoZWwgRMOkbnplciB3cm90ZToKPiA+Pj4+PiBPbiBUaHUsIDIwMDgtMDgtMjggYXQg
MjM6NDMgKzAyMDAsIEhlbGdlIERlbGxlciB3cm90ZToKPiA+Pj4+Pj4gWW91ciBpZGVhIGFib3V0
IHRlc3RpbmcgYSBmZXcgbW9kZSBsaW5lcyBpcyBub3JtYWxseSBhIGdvb2QgaWRlYS4KPiA+Pj4+
PiBNeSBpZGVhIGlzIHF1aXRlIHRoZSBvcHBvc2l0ZSAtIHRvIHRyeSAqd2l0aG91dCogZXZlbiB0
aGUgTW9kZXMgbGluZSBpbgo+ID4+Pj4+IFN1YlNlY3Rpb24gIkRpc3BsYXkiLiBDYW4geW91IHRy
eSB0aGF0IHBsZWFzZT8KPiA+Pj4+IERvZXNuJ3Qgd29yayBlaXRoZXIuCj4gPj4+Pgo+ID4+Pj4g
YSkgSWYgSSBkcm9wIHRoZSAibW9uaXRvciIgbGluZSBpbiB0aGUgU2NyZWVuIHNlY3Rpb24gaXQg
Y2hvb3NlcyBhIAo+ID4+PiBbLi4uXQo+ID4+Pgo+ID4+Pj4gYikgSWYgSSBqdXN0IGRyb3AgdGhl
IEhvcml6U3luYyBhbmQgVmVydFJlZnJlc2ggZW50cmllcywgaXQgZmFpbHMgYXMgd2VsbDoKPiA+
Pj4gWy4uLl0KPiA+Pj4KPiA+Pj4gV2hpY2ggcGFydCBvZiAndGhlIE1vZGVzIGxpbmUgaW4gU3Vi
U2VjdGlvbiAiRGlzcGxheSInIGlzIHNvIGhhcmQgdG8KPiA+Pj4gdW5kZXJzdGFuZD8gKnNocnVn
Kgo+ID4+IERvIHlvdSB3YW50IG1lIHRvIGNoYW5nZSB0aGlzICgxMDI0eDc2OCk6ID8KPiA+PiAJ
U3ViU2VjdGlvbiAiRGlzcGxheSIKPiA+PiAgICAgICAgICAgICAgICAgIERlcHRoICAgICAgICAg
ICA4Cj4gPj4gICAgICAgICAgICAgICAgICBNb2RlcyAgICAgICAgICAgIjEwMjR4NzY4Igo+ID4+
ICAgICAgICAgIEVuZFN1YlNlY3Rpb24KPiA+IAo+ID4gTm90IGNoYW5nZSBpdCwgcmVtb3ZlIGl0
IChoZW5jZSAnd2l0aG91dCcpLgo+ID4gCj4gPiBJIHN1c3BlY3QgdGhlIHByb2JsZW0gaXMgdGhh
dCB5b3UncmUgbWlzdW5kZXJzdGFuZGluZyB0aGUgbWVhbmluZyBvZgo+ID4gdGhpcyBsaW5lLiBJ
dCB0ZWxscyB0aGUgWCBzZXJ2ZXIgdG8gdHJ5IGFsbCB0aGUgMTAyNHg3NjggbW9kZXMgZnJvbSBp
dHMKPiA+IGludGVybmFsIG1vZGUgZGF0YWJhc2UsIG5vbmUgb2Ygd2hpY2ggbWF0Y2ggdGhlIG1v
ZGUgb2YgeW91ciBmcmFtZWJ1ZmZlcgo+ID4gZGV2aWNlIHVuc3VycHJpc2luZ2x5LiBJZiB5b3Ug
b21pdCB0aGUgbGluZSwgdGhlIGZiZGV2IGRyaXZlciB3aWxsIGdldAo+ID4gdGhlIGN1cnJlbnQg
bW9kZSBmcm9tIHRoZSBmcmFtZWJ1ZmZlciBkZXZpY2UgYW5kIHRyeSB0aGF0LiBOb3RlIHRoYXQg
dGhlCj4gPiBwaXhjbG9jayAwIGNhbiBzdGlsbCBjYXVzZSB0cm91YmxlIHdpdGggWCBzZXJ2ZXJz
IGJlZm9yZSB0aGUgdXBjb21pbmcKPiA+IDEuNSByZWxlYXNlLgo+IAo+IE5vLCBkb2Vzbid0IHdv
cmsgZWl0aGVyIChzZWUgYmVsb3cpLgo+IFNlZW1zIHRvIGJlIHRoZSAicGl4Y2xvY2sgMCIgcHJv
YmxlbSB5b3UgbWVudGlvbi4KPiBXaGF0IGNoYW5nZWQgaW4gMS41PyBBbnkgbGluayB0byBhIHBh
dGNoPwoKaHR0cDovL2NnaXQuZnJlZWRlc2t0b3Aub3JnL3hvcmcveHNlcnZlci9jb21taXQvP2lk
PWMwOTVkYTA0ZmU3YzczYjY1MDNlZjViOTM1NDliMTM3OTZjNTFiMjIKCgotLSAKRWFydGhsaW5n
IE1pY2hlbCBEw6RuemVyICAgICAgICAgICB8ICAgICAgICAgIGh0dHA6Ly90dW5nc3RlbmdyYXBo
aWNzLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgfCAgICAgICAgICBEZWJp
YW4sIFggYW5kIERSSSBkZXZlbG9wZXIKCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClRoaXMgU0YuTmV0IGVt
YWlsIGlzIHNwb25zb3JlZCBieSB0aGUgTW9ibGluIFlvdXIgTW92ZSBEZXZlbG9wZXIncyBjaGFs
bGVuZ2UKQnVpbGQgdGhlIGNvb2xlc3QgTGludXggYmFzZWQgYXBwbGljYXRpb25zIHdpdGggTW9i
bGluIFNESyAmIHdpbiBncmVhdCBwcml6ZXMKR3JhbmQgcHJpemUgaXMgYSB0cmlwIGZvciB0d28g
dG8gYW4gT3BlbiBTb3VyY2UgZXZlbnQgYW55d2hlcmUgaW4gdGhlIHdvcmxkCmh0dHA6Ly9tb2Js
aW4tY29udGVzdC5vcmcvcmVkaXJlY3QucGhwP2Jhbm5lcl9pZD0xMDAmdXJsPS8KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZmJkZXYtZGV2ZWwg
bWFpbGluZyBsaXN0CkxpbnV4LWZiZGV2LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRw
czovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mYmRldi1kZXZl
bAo=
