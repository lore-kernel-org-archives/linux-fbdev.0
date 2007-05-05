From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 06/20] vt8623fb: New
	framebuffer	driver for VIA VT8623
Date: Sun, 06 May 2007 07:03:05 +0800
Message-ID: <1178406185.22828.2.camel@daplas>
References: <463C996A.9050005@gmail.com> <20070505181551.GB6016@sci.fi>
	<20070505200801.GA28014@localhost.localdomain>
	<20070505203450.GC6016@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HkTHV-0002Mf-NC for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 16:03:13 -0700
Received: from py-out-1112.google.com ([64.233.166.183])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HkTHU-0007Kc-W6
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 16:03:13 -0700
Received: by py-out-1112.google.com with SMTP id a29so947237pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 05 May 2007 16:03:12 -0700 (PDT)
In-Reply-To: <20070505203450.GC6016@sci.fi>
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
Cc: Andrew Morton <akpm@osdl.org>, Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>

T24gU2F0LCAyMDA3LTA1LTA1IGF0IDIzOjM0ICswMzAwLCBWaWxsZSBTeXJqw6Rsw6Qgd3JvdGU6
Cj4gT24gU2F0LCBNYXkgMDUsIDIwMDcgYXQgMTA6MDg6MDFQTSArMDIwMCwgT25kcmVqIFphamlj
ZWsgd3JvdGU6Cj4gPiBPbiBTYXQsIE1heSAwNSwgMjAwNyBhdCAwOToxNTo1MVBNICswMzAwLCBW
aWxsZSBTeXJqw6Rsw6Qgd3JvdGU6Cj4gPiA+ID4gKwl2dDg2MjNmYiAtIGZiZGV2IGRyaXZlciBm
b3IgZ3JhcGhpY3MgY29yZSBpbiBWSUEgVlQ4NjIzIGNoaXBzZXQKPiA+ID4gPiArCT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+
ID4gPiAKPiA+ID4gRG9lc24ndCB2aWFmYiBzdXBwb3J0IHRoaXMgaGFyZHdhcmU/Cj4gPiAKPiA+
IFllcywgdGhpcyBoYXJkd2FyZSBpcyBzdXBwb3J0ZWQgYnkgc2V2ZXJhbCBvdXQtb2YtdHJlZSBk
cml2ZXJzLAo+ID4gc29tZSBvZiB0aGVtIGFyZSBuYW1lZCB2aWFmYi4KPiAKPiBUaGUgIm9mZmlj
aWFsIiAoaWUuIHRoZSBvbmUgZnJvbSB2aWEpIHdhcyBqdXN0IHBvc3RlZCBoZXJlIGZvciBpbmNs
dXNpb24uCgpUaGUgcGF0Y2ggZnJvbSBWSUEsIGF0IGl0cyBwcmVzZW50IHN0YXRlLCBpcyBub3Qg
Zml0IGZvciBpbmNsdXNpb24uIFdlCmVpdGhlciB3YWl0IGZvciB0aGF0IChpbmRlZmluaXRlbHkp
IG9yIGluY2x1ZGUgdGhpcyBhbmQgdGhlbiBtZXJnZSBsYXRlcgpvbi4KClRvbnkKCgoKLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQpUaGlzIFNGLm5ldCBlbWFpbCBpcyBzcG9uc29yZWQgYnkgREIyIEV4cHJlc3MK
RG93bmxvYWQgREIyIEV4cHJlc3MgQyAtIHRoZSBGUkVFIHZlcnNpb24gb2YgREIyIGV4cHJlc3Mg
YW5kIHRha2UKY29udHJvbCBvZiB5b3VyIFhNTC4gTm8gbGltaXRzLiBKdXN0IGRhdGEuIENsaWNr
IHRvIGdldCBpdCBub3cuCmh0dHA6Ly9zb3VyY2Vmb3JnZS5uZXQvcG93ZXJiYXIvZGIyLwpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mYmRldi1k
ZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZmJkZXYtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0
Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWZiZGV2
LWRldmVsCg==
