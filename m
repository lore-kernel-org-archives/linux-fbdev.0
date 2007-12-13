From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] logo: move declarations of logos to
	linux_logo.h
Date: Thu, 13 Dec 2007 02:31:11 -0800
Message-ID: <20071213023111.30ddc487.akpm@linux-foundation.org>
References: <20071209214027.GG9440@joi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J2lLm-00036N-Nc for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Dec 2007 02:31:31 -0800
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J2lLl-0002A8-HM
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Dec 2007 02:31:29 -0800
In-Reply-To: <20071209214027.GG9440@joi>
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
To: Marcin =?UTF-8?B?xZpsdXNhcno=?= <marcin.slusarz@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Antonino Daplas <adaplas@gmail.com>

T24gU3VuLCA5IERlYyAyMDA3IDIyOjQwOjMxICswMTAwIE1hcmNpbiDFmmx1c2FyeiA8bWFyY2lu
LnNsdXNhcnpAZ21haWwuY29tPiB3cm90ZToKCj4gbG9nbzogbW92ZSBkZWNsYXJhdGlvbnMgb2Yg
bG9nb3MgdG8gbGludXhfbG9nby5oCj4gCj4gdGhlcmUgd2FzIGEgbWlzbWF0Y2ggYmV0d2VlbiBl
eHRlcm5zIGluIGxvZ28uYyBhbmQgY29kZSBnZW5lcmF0ZWQgYnkgcG5tdG9sb2dvCj4gKG9uIG9s
ZCB0cmVlLCB5b3UgbmVlZCB0byBybSBkcml2ZXJzL3ZpZGVvL2xvZ28vbG9nb18qLmMgYmVmb3Jl
IGNvbXBpbGF0aW9uKQoKVGhpcyBwYXRjaCAoYWZ0ZXIgSSBmaXhlZCBpdCkga2VlcHMgb24gY2F1
c2luZyB0cm91YmxlOiBtaXNtYXRjaGVzIGJldHdlZW4KdGhlIGhlYWRlciBmaWxlIGRlY2xhcmF0
aW9ucyBhbmQgdGhlIGFjdHVhbCBkZWZpbml0aW9ucyBvZiB0aGUgbG9va3VwCnRhYmxlcy4gIFRo
aXMgaGFwcGVucyBhcyBJIGFwcGx5IGFuZCB1bmFwcGx5IHRoZSBwYXRjaC4KCkl0IF9zaG91bGRu
J3RfIGhhcHBlbiwgYnV0IHRoZXJlIHdvdWxkIGFwcGVhciB0byBiZSBzb21lIG1pc3NpbmcgbWFr
ZWZpbGUKcnVsZXMuICBJIGd1ZXNzIHRoZSBDIGZpbGVzIGFyZW4ndCBiZWluZyByZWdlbmVyYXRl
ZCB3aGVuCnNjcmlwdHMvcG5tdG9sb2dvLmMgaGFzIGJlZW4gYWx0ZXJlZCwgc28gdGhlIEMgZmls
ZXMgYXJlbid0IG1hdGNoaW5nIHRoZSAKaGVhZGVyIHdoaWNoIHRoaXMgcGF0Y2ggYWx0ZXJzLgoK
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQpTRi5OZXQgZW1haWwgaXMgc3BvbnNvcmVkIGJ5OgpDaGVjayBvdXQg
dGhlIG5ldyBTb3VyY2VGb3JnZS5uZXQgTWFya2V0cGxhY2UuCkl0J3MgdGhlIGJlc3QgcGxhY2Ug
dG8gYnV5IG9yIHNlbGwgc2VydmljZXMKZm9yIGp1c3QgYWJvdXQgYW55dGhpbmcgT3BlbiBTb3Vy
Y2UuCmh0dHA6Ly9hZC5kb3VibGVjbGljay5uZXQvY2xrOzE2NDIxNjIzOTsxMzUwMzAzODt3P2h0
dHA6Ly9zZi5uZXQvbWFya2V0cGxhY2UKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtZmJkZXYtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWZiZGV2
LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5l
dC9saXN0cy9saXN0aW5mby9saW51eC1mYmRldi1kZXZlbAo=
