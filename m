From: =?utf-8?q?Hans-J=C3=BCrgen_Koch?= <hjk@linutronix.de>
Subject: Re: [PATCH] pxafb: Add support for other
	palette formats
Date: Fri, 13 Jul 2007 14:39:43 +0200
Message-ID: <200707131439.43676.hjk@linutronix.de>
References: <200707031607.08511.hjk@linutronix.de>
	<200707031703.53102.hjk@linutronix.de>
	<1184329235.4702.14.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I9KRX-0001ki-P2 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 05:40:19 -0700
Received: from www.osadl.org ([213.239.205.134] helo=mail.tglx.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I9KRW-0003Cg-Ao
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 05:40:19 -0700
In-Reply-To: <1184329235.4702.14.camel@daplas>
Content-Disposition: inline
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-fbdev-devel@lists.sourceforge.net, Paulo Marques <pmarques@grupopie.com>, linux-arm-kernel@lists.arm.linux.org.uk

QW0gRnJlaXRhZyAxMyBKdWxpIDIwMDcgMTQ6MjAgc2NocmllYiBBbnRvbmlubyBBLiBEYXBsYXM6
Cj4gT24gVHVlLCAyMDA3LTA3LTAzIGF0IDE3OjAzICswMjAwLCBIYW5zLUrDvHJnZW4gS29jaCB3
cm90ZToKPiA+IEFtIERpZW5zdGFnIDAzIEp1bGkgMjAwNyAxNjo0NiBzY2hyaWViIFBhdWxvIE1h
cnF1ZXM6Cj4gPiA+IEhhbnMtSsO8cmdlbiBLb2NoIHdyb3RlOgo+IAo+ID4gPiBXZSBjYW4gZWl0
aGVyIGFwcGx5IHRoaXMgcGF0Y2ggYXMgaXMgYW5kIEknbGwganVzdCBtZXJnZSBteSB3b3JrIGxh
dGVyLCAKPiA+ID4gb3IgSSBjYW4gdHJ5IHRvIG1lcmdlIGJvdGggcGF0Y2hlcyBhbmQgc2VuZCBh
IHNpbmdsZSBwYXRjaCB1cHN0cmVhbS4gCj4gPiA+IEVpdGhlciB3YXkgaXMgZmluZSBieSBtZS4K
PiA+IAo+ID4gSXQncyBwcm9iYWJseSBjbGVhbmVyIHRvIG1lcmdlIHR3byBzbWFsbCBwYXRjaGVz
IHRoYW4gYSBiaWcgb25lLgo+ID4gCj4gCj4gV2hhdCBzaG91bGQgSSBkbyB3aXRoIHRoaXM/IFNo
b3VsZCBJIHB1c2ggdGhpcyB0byBha3BtLCBvciBzaG91bGQgSSB3YWl0Cj4gZm9yIGEgbWVyZ2U/
CgpNeSBwYWxldHRlIGZvcm1hdCBwYXRjaCBpcyBjb21wbGV0ZWx5IGluZGVwZW5kZW50IG9mIFBh
dWxvJ3MgdHJ1ZS1jb2xvciB3b3JrLgpJJ2QgYmUgZ2xhZCBpZiB5b3UgY291bGQgcHVzaCBpdC4K
ClRoYW5rcywKSGFucwoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpUaGlzIFNGLm5ldCBlbWFpbCBpcyBzcG9u
c29yZWQgYnkgREIyIEV4cHJlc3MKRG93bmxvYWQgREIyIEV4cHJlc3MgQyAtIHRoZSBGUkVFIHZl
cnNpb24gb2YgREIyIGV4cHJlc3MgYW5kIHRha2UKY29udHJvbCBvZiB5b3VyIFhNTC4gTm8gbGlt
aXRzLiBKdXN0IGRhdGEuIENsaWNrIHRvIGdldCBpdCBub3cuCmh0dHA6Ly9zb3VyY2Vmb3JnZS5u
ZXQvcG93ZXJiYXIvZGIyLwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1mYmRldi1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZmJkZXYtZGV2ZWxA
bGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3Rz
L2xpc3RpbmZvL2xpbnV4LWZiZGV2LWRldmVsCg==
