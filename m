From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: Re: [RFC] driving a LCD panel via I2C
Date: Mon, 24 Sep 2007 12:34:08 +0200
Message-ID: <20070924123408.596a3c69@dhcp-255-175.norway.atmel.com>
References: <41784.213.84.50.107.1190624288.squirrel@webmail.enneenne.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IZlGq-0005YA-Ou for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Sep 2007 03:34:33 -0700
Received: from nat-132.atmel.no ([80.232.32.132] helo=relay.atmel.no)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IZlGq-0004mP-1J
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Sep 2007 03:34:32 -0700
In-Reply-To: <41784.213.84.50.107.1190624288.squirrel@webmail.enneenne.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: rpurdie@rpsys.net, i2c@lm-sensors.org, linux-kernel@vger.kernel.org

T24gTW9uLCAyNCBTZXAgMjAwNyAxMDo1ODowOCArMDIwMCAoQ0VTVCkKIlJvZG9sZm8gR2lvbWV0
dGkiIDxnaW9tZXR0aUBlbm5lZW5uZS5jb20+IHdyb3RlOgoKPiBIZWxsbywKPiAKPiBJIGhhdmUg
YW4gTENEIHBhbmVsIG9uIGEgY3VzdG9tIFBYQTI3eCBiYXNlZCBib2FyZCBhbmQgaXQgbXVzdCBi
ZQo+IHR1cm5lZCBvbi9vZmYgYnkgc29tZSBzcGVjaWFsIGNvbW1hbmRzIHZpYSBhIEdQSU8gdGhy
b3VnaHQgYSBJMkMgY2hpcC4KPiAKPiBJJ2QgbGlrZSBzb21lIHN1Z2dlc3Rpb24gYWJvdXQgSSBj
YW4gZWFzaWx5IG1hbmFnZSB0aGlzIHNpdHVhdGlvbi4KCkkgaGF2ZSBhIHNpbWlsYXIgcGFuZWwg
aW4gdGhlIHNlbnNlIHRoYXQgaXQgbmVlZHMgYSBidW5jaCBvZiBTUEkKY29tbWFuZHMgdG8gZ2V0
IHN0YXJ0ZWQuIEkgaW1wbGVtZW50ZWQgYSBMQ0QgZHJpdmVyCihkcml2ZXJzL3ZpZGVvL2JhY2ts
aWdodCkgZm9yIGl0IHNvIHRoYXQgaXQgaXMgYXV0b21hdGljYWxseSB0dXJuZWQKb24vb2ZmIGF0
IGJvb3R1cC9zaHV0ZG93biwgYW5kIGNhbiBiZSBtYW51YWxseSB0dXJuZWQgb24vb2ZmCnRocm91
Z2ggL3N5cy9jbGFzcy9sY2QvbHR2MzUwcXYvcG93ZXIuIEFGQUlLIHRoZSBkcml2ZXIgaXMgY3Vy
cmVudGx5CnNpdHRpbmcgaW4gdGhlIGJhY2tsaWdodCB0cmVlIHNjaGVkdWxlZCBmb3IgaW5jbHVz
aW9uIGluIDIuNi4yNC4KCj4gTWF5YmUgY2FuIEkgYWRkIGEgc3BlY2lhbCBJMkMgZnVuY3Rpb24g
dG8gZ2V0IGkyY19jbGllbnQgcG9pbnRlciBhbmQKPiB0aGVuIHVzaW5nIGl0IHRvIHNlbmQgb24v
b2ZmIGNvbW1hbmRzIHRvIHRoZSBMQ0Q/CgpKdXN0IGltcGxlbWVudCBpdCBhcyBhIHJlZ3VsYXIg
STJDIGNoaXAgZHJpdmVyIHdoaWNoIHJlZ2lzdGVycyBhIGRldmljZQp3aXRoIHRoZSBMQ0QgZnJh
bWV3b3JrIHdoZW4gaXQgaXMgc3VjY2Vzc2Z1bGx5IHByb2JlZC4KCkjDpXZhcmQKCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KVGhpcyBTRi5uZXQgZW1haWwgaXMgc3BvbnNvcmVkIGJ5OiBNaWNyb3NvZnQKRGVm
eSBhbGwgY2hhbGxlbmdlcy4gTWljcm9zb2Z0KFIpIFZpc3VhbCBTdHVkaW8gMjAwNS4KaHR0cDov
L2Nsay5hdGRtdC5jb20vTVJUL2dvL3ZzZTAxMjAwMDAwNzBtcnQvZGlyZWN0LzAxLwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mYmRldi1kZXZl
bCBtYWlsaW5nIGxpc3QKTGludXgtZmJkZXYtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0
dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWZiZGV2LWRl
dmVsCg==
