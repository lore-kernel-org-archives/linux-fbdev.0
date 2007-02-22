From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] atyfb: Replace busy loop with
	mdelay()
Date: Thu, 22 Feb 2007 09:14:37 +0800
Message-ID: <1172106878.4217.57.camel@daplas>
References: <20070222002033.GA26166@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HK2Uv-00038p-E1 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 17:11:49 -0800
Received: from nz-out-0506.google.com ([64.233.162.231])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HK2Ut-0002Oj-Js
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 17:11:49 -0800
Received: by nz-out-0506.google.com with SMTP id i11so28302nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 21 Feb 2007 17:11:47 -0800 (PST)
In-Reply-To: <20070222002033.GA26166@sci.fi>
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
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: akpm@osdl.org, jsimmons@infradead.org, linux-fbdev-devel@lists.sourceforge.net, stable@kernel.org, alex.kern@gmx.de

T24gVGh1LCAyMDA3LTAyLTIyIGF0IDAyOjIwICswMjAwLCBWaWxsZSBTeXJqw6Rsw6Qgd3JvdGU6
Cj4gUmVwbGFjZSBhIGJ1c3kgbG9vcCB3aXRoIG1kZWxheSgpIGluIGF0eWZiIGNsb2NrIHNldHVw
IGNvZGUuIFRoaXMgZml4ZXMKPiBib290IGhhbmdzIHNldmVyYWwgcGVvcGxlIGhhdmUgZXhwZXJp
ZW5jZWQuCgpBZ3JlZSB0aGF0IGlzIGEgY2FuZGlkYXRlIGZvciB0aGUgc3RhYmxlIHRyZWUuIElm
IG5vdCwgSSdsbCB0YWtlIGNhcmUgb2YKdGhpcyBwYXRjaC4KClRvbnkgCgoKCi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KVGFrZSBTdXJ2ZXlzLiBFYXJuIENhc2guIEluZmx1ZW5jZSB0aGUgRnV0dXJlIG9mIElU
CkpvaW4gU291cmNlRm9yZ2UubmV0J3MgVGVjaHNheSBwYW5lbCBhbmQgeW91J2xsIGdldCB0aGUg
Y2hhbmNlIHRvIHNoYXJlIHlvdXIKb3BpbmlvbnMgb24gSVQgJiBidXNpbmVzcyB0b3BpY3MgdGhy
b3VnaCBicmllZiBzdXJ2ZXlzLWFuZCBlYXJuIGNhc2gKaHR0cDovL3d3dy50ZWNoc2F5LmNvbS9k
ZWZhdWx0LnBocD9wYWdlPWpvaW4ucGhwJnA9c291cmNlZm9yZ2UmQ0lEPURFVkRFVgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mYmRldi1kZXZl
bCBtYWlsaW5nIGxpc3QKTGludXgtZmJkZXYtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0
dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWZiZGV2LWRl
dmVsCg==
