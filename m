From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
Subject: Re: [PATCH] Add fb_check_var() for fixed
	mode	device.
Date: Fri, 29 Aug 2008 10:49:18 +0200
Message-ID: <1219999758.4421.259.camel@thor.sulgenrain.local>
References: <48B4E16C.4000107@renesas.com>
	<Pine.LNX.4.64.0808270855110.7910@anakin> <g94i4r$2hq$1@ger.gmane.org>
	<20080828074521.GO16680@sci.fi>  <48B785DA.1030408@renesas.com>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYzfc-00015a-FK for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 01:49:28 -0700
Received: from fg-out-1718.google.com ([72.14.220.157])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYzfb-0003PU-3N
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 01:49:28 -0700
Received: by fg-out-1718.google.com with SMTP id d23so483271fga.32
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 29 Aug 2008 01:49:25 -0700 (PDT)
In-Reply-To: <48B785DA.1030408@renesas.com>
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
To: Takashi Yoshii <yoshii.takashi@renesas.com>
Cc: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>, linux-fbdev-devel@lists.sourceforge.net

T24gRnJpLCAyMDA4LTA4LTI5IGF0IDE0OjE1ICswOTAwLCBUYWthc2hpIFlvc2hpaSB3cm90ZToK
PiAKPiArCS8qIGJpZ2dlciBpcyBlcnJvciwgc21hbGxlciBpcyBPSyAqLwo+ICsJaWYoICggdmFy
LT54cmVzID4gY29uc3RhbnQtPnhyZXMgKQo+ICsJICB8fCggdmFyLT55cmVzID4gY29uc3RhbnQt
PnlyZXMgKQoKVGhlIHJlc29sdXRpb24gbXVzdCBtYXRjaCwgb3RoZXJ3aXNlIHVzZXJzcGFjZSB0
aGlua3MgaXQgY2FuIGUuZy4gc2V0CjgwMHg2MDAgd2hlbiB0aGUgZml4ZWQgbW9kZSBpcyAxMDI0
eDc2OC4KCkkgdGhpbmsgdGhpcyBpcyBqdXN0IGEgYmFkIGlkZWEgaW4gZ2VuZXJhbCB0aG91Z2gs
IGFzIGl0IHJlaW50cm9kdWNlcwp0aGUgcHJvYmxlbSB0aGF0IHdhcyBmaXhlZCB3aXRoIHRoZSBj
aGVjayBpbiB0aGUgWCBzZXJ2ZXI6IHRoZSBYIHNlcnZlcgp3aWxsIGJlIG1pc2xlYWQgaW50byB0
aGlua2luZyBpdCBjYW4gc2V0IG1vZGVzIHRoYXQgaXQgcmVhbGx5IGNhbid0LgoKCi0tIApFYXJ0
aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgIHwgICAgICAgICAgaHR0cDovL3R1bmdzdGVu
Z3JhcGhpY3MuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICB8ICAgICAgICAg
IERlYmlhbiwgWCBhbmQgRFJJIGRldmVsb3BlcgoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KVGhpcyBTRi5O
ZXQgZW1haWwgaXMgc3BvbnNvcmVkIGJ5IHRoZSBNb2JsaW4gWW91ciBNb3ZlIERldmVsb3Blcidz
IGNoYWxsZW5nZQpCdWlsZCB0aGUgY29vbGVzdCBMaW51eCBiYXNlZCBhcHBsaWNhdGlvbnMgd2l0
aCBNb2JsaW4gU0RLICYgd2luIGdyZWF0IHByaXplcwpHcmFuZCBwcml6ZSBpcyBhIHRyaXAgZm9y
IHR3byB0byBhbiBPcGVuIFNvdXJjZSBldmVudCBhbnl3aGVyZSBpbiB0aGUgd29ybGQKaHR0cDov
L21vYmxpbi1jb250ZXN0Lm9yZy9yZWRpcmVjdC5waHA/YmFubmVyX2lkPTEwMCZ1cmw9LwpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mYmRldi1k
ZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZmJkZXYtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0
Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWZiZGV2
LWRldmVsCg==
