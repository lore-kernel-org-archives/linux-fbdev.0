From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] logo: move declarations of logos to
	linux_logo.h
Date: Fri, 14 Dec 2007 23:00:05 +0100
Message-ID: <20071214220005.GA22937@uranus.ravnborg.org>
References: <20071209214027.GG9440@joi>
	<20071213023111.30ddc487.akpm@linux-foundation.org>
	<20071213213130.GA1822@joi>
	<Pine.LNX.4.64.0712142148390.4881@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J3IYA-0002jW-N5 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Dec 2007 13:58:32 -0800
Received: from pasmtpa.tele.dk ([80.160.77.114])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1J3IY0-0003c4-JY
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Dec 2007 13:58:24 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0712142148390.4881@anakin>
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
Content-Type: text/plain; charset="windows-1252"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Antonino Daplas <adaplas@gmail.com>

T24gRnJpLCBEZWMgMTQsIDIwMDcgYXQgMDk6NDk6MDNQTSArMDEwMCwgR2VlcnQgVXl0dGVyaG9l
dmVuIHdyb3RlOgo+IE9uIFRodSwgMTMgRGVjIDIwMDcsIE1hcmNpbiBTbHVzYXJ6IHdyb3RlOgo+
ID4gT24gVGh1LCBEZWMgMTMsIDIwMDcgYXQgMDI6MzE6MTFBTSAtMDgwMCwgQW5kcmV3IE1vcnRv
biB3cm90ZToKPiA+ID4gT24gU3VuLCA5IERlYyAyMDA3IDIyOjQwOjMxICswMTAwIE1hcmNpbiDF
mmx1c2FyeiA8bWFyY2luLnNsdXNhcnpAZ21haWwuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gPiBs
b2dvOiBtb3ZlIGRlY2xhcmF0aW9ucyBvZiBsb2dvcyB0byBsaW51eF9sb2dvLmgKPiA+ID4gPgo+
ID4gPiA+IHRoZXJlIHdhcyBhIG1pc21hdGNoIGJldHdlZW4gZXh0ZXJucyBpbiBsb2dvLmMgYW5k
IGNvZGUgZ2VuZXJhdGVkIGJ5IHBubXRvbG9nbwo+ID4gPiA+IChvbiBvbGQgdHJlZSwgeW91IG5l
ZWQgdG8gcm0gZHJpdmVycy92aWRlby9sb2dvL2xvZ29fKi5jIGJlZm9yZSBjb21waWxhdGlvbikK
PiA+ID4KPiA+ID4gVGhpcyBwYXRjaCAoYWZ0ZXIgSSBmaXhlZCBpdCkga2VlcHMgb24gY2F1c2lu
ZyB0cm91YmxlOiBtaXNtYXRjaGVzIGJldHdlZW4KPiA+ID4gdGhlIGhlYWRlciBmaWxlIGRlY2xh
cmF0aW9ucyBhbmQgdGhlIGFjdHVhbCBkZWZpbml0aW9ucyBvZiB0aGUgbG9va3VwCj4gPiA+IHRh
Ymxlcy4gIFRoaXMgaGFwcGVucyBhcyBJIGFwcGx5IGFuZCB1bmFwcGx5IHRoZSBwYXRjaC4KPiA+
ID4KPiA+ID4gSXQgX3Nob3VsZG4ndF8gaGFwcGVuLCBidXQgdGhlcmUgd291bGQgYXBwZWFyIHRv
IGJlIHNvbWUgbWlzc2luZyBtYWtlZmlsZQo+ID4gPiBydWxlcy4gIEkgZ3Vlc3MgdGhlIEMgZmls
ZXMgYXJlbid0IGJlaW5nIHJlZ2VuZXJhdGVkIHdoZW4KPiA+ID4gc2NyaXB0cy9wbm10b2xvZ28u
YyBoYXMgYmVlbiBhbHRlcmVkLCBzbyB0aGUgQyBmaWxlcyBhcmVuJ3QgbWF0Y2hpbmcgdGhlCj4g
PiA+IGhlYWRlciB3aGljaCB0aGlzIHBhdGNoIGFsdGVycy4KPiA+IAo+ID4gT2ssIHVwZGF0ZWQg
cGF0Y2ggYmVsb3c6Cj4gPiAKPiA+IGxvZ286IG1vdmUgZGVjbGFyYXRpb25zIG9mIGxvZ29zIHRv
IGxpbnV4X2xvZ28uaAo+ID4gCj4gPiB0aGVyZSB3YXMgYSBtaXNtYXRjaCBiZXR3ZWVuIGV4dGVy
bnMgaW4gbG9nby5jIGFuZCBjb2RlIGdlbmVyYXRlZCBieSBwbm10b2xvZ28KPiAKPiBUaGlzIG1h
eSBjYXVzZSBzZWN0aW9uIGNvbmZsaWN0cywgY2ZyLgo+IGh0dHA6Ly9sa21sLm9yZy9sa21sLzIw
MDcvMTAvMjQvNjUKCklmIEkgcmVjYWxsIGNvcnJlY3QgdGhlbiBpZiB0aGUgZmlyc3QgX19pbml0
ZGF0YSB2YXJpYWJsZSBpcyBjb25zdCB0aGVuCmFsbCBkYXRlIGRlY2xhcmVkIF9faW5pdGRhdGEg
YXJlIGF0dGVtcHRlZCBwdXQgaW4gdGhlIGNvbnN0IHNlY3Rpb24uClNvIG1heWJlIGEgYml0IHJl
b3JkZXJpbmcgY291bGQgaGVscCBpdD8KCkJ1dCB0aGF0IHdvdWxkIHNlcnZlIGEgZmF0IGV4cGxh
bmF0aW9uIHdoeS4uLgoKCVNhbQoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpTRi5OZXQgZW1haWwgaXMgc3Bv
bnNvcmVkIGJ5OgpDaGVjayBvdXQgdGhlIG5ldyBTb3VyY2VGb3JnZS5uZXQgTWFya2V0cGxhY2Uu
Ckl0J3MgdGhlIGJlc3QgcGxhY2UgdG8gYnV5IG9yIHNlbGwgc2VydmljZXMKZm9yIGp1c3QgYWJv
dXQgYW55dGhpbmcgT3BlbiBTb3VyY2UuCmh0dHA6Ly9hZC5kb3VibGVjbGljay5uZXQvY2xrOzE2
NDIxNjIzOTsxMzUwMzAzODt3P2h0dHA6Ly9zZi5uZXQvbWFya2V0cGxhY2UKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZmJkZXYtZGV2ZWwgbWFp
bGluZyBsaXN0CkxpbnV4LWZiZGV2LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczov
L2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mYmRldi1kZXZlbAo=
