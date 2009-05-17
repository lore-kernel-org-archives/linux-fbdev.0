From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] platinumfb: misplaced parenthesis
Date: Sun, 17 May 2009 19:11:09 +0200
Message-ID: <10f740e80905171011r7955a23bq24081e993b8f50cb@mail.gmail.com>
References: <4A0C0C4E.6070401@gmail.com>
	<20090514093827.33a099f7.akpm@linux-foundation.org>
	<1242343459.1867.27.camel@pasglop> <4A0DD407.9090206@gmail.com>
	<20090515212449.GD6520@sci.fi> <1242426067.9691.4.camel@pasglop>
	<4A0FFA9C.5000404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert.uytterhoeven@gmail.com>) id 1M5jtM-0002qC-R2
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 17 May 2009 17:11:16 +0000
Received: from mail-ew0-f169.google.com ([209.85.219.169])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M5jtI-0007cp-2l for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 17 May 2009 17:11:16 +0000
Received: by ewy17 with SMTP id 17so3730573ewy.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 17 May 2009 10:11:09 -0700 (PDT)
In-Reply-To: <4A0FFA9C.5000404@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Roel Kluin <roel.kluin@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <syrjala@sci.fi>, Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>

T24gU3VuLCBNYXkgMTcsIDIwMDkgYXQgMTM6NTMsIFJvZWwgS2x1aW4gPHJvZWwua2x1aW5AZ21h
aWwuY29tPiB3cm90ZToKPiBTaW5jZSBgKycgaGFzIGEgaGlnaGVyIHByZWNlZGVuY2UgdGhhbiB0
aGUgdHJpbmFyeSBvcGVyYXRvciBgPycsIHRoaXMKPiBhZGRlZCBgaHJlcyAqICgxIDw8IGNvbG9y
X21vZGUpJyB0byB0aGUgYm9vbGVhbiB0ZXN0aW5nIHZpZGVvbW9kZQo+IGFuZCBkZXB0aC4KPgo+
IFNpZ25lZC1vZmYtYnk6IFJvZWwgS2x1aW4gPHJvZWwua2x1aW5AZ21haWwuY29tPgo+IC0tLQo+
IMKgc3RhdGljIGlubGluZSBpbnQgcGxhdGludW1fdnJhbV9yZXFkKGludCB2aWRlb19tb2RlLCBp
bnQgY29sb3JfbW9kZSkKPiDCoHsKPiArIMKgIMKgIMKgIGludCBvZmZzZXQ7Cj4gKwo+ICsgwqAg
wqAgwqAgaWYgKCh2aWRlb19tb2RlID09IFZNT0RFXzgzMl82MjRfNzUpICYmIChjb2xvcl9tb2Rl
ID4gQ01PREVfOCkpCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBvZmZzZXQgPSAweDEwMTA7Cj4g
KyDCoCDCoCDCoCBlbHNlCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBvZmZzZXQgPSAweDEwMjA7
Cj4gKwo+IMKgIMKgIMKgIMKgcmV0dXJuIHZtb2RlX2F0dHJzW3ZpZGVvX21vZGUtMV0udnJlcyAq
Cj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCh2bW9kZV9hdHRyc1t2aWRlb19tb2RlLTFdLmhyZXMg
KiAoMTw8Y29sb3JfbW9kZSkgKwo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgKCh2aWRlb19tb2Rl
ID09IFZNT0RFXzgzMl82MjRfNzUpICYmCj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoChjb2xv
cl9tb2RlID4gQ01PREVfOCkpID8gMHgxMCA6IDB4MjApICsgMHgxMDAwOwo+ICsgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgKHZtb2RlX2F0dHJzW3ZpZGVvX21vZGUtMV0uaHJlcyAqICgxPDxjb2xvcl9t
b2RlKSArIG9mZnNldCk7CgpOb3cgw7JmZnNldCcgaXMgaW5zaWRlIHRoZSBwYXJlbnRoZXNlcywg
aGVuY2UgaXQncyBtdWx0aXBsaWVkIGJ5IC4uLnZyZXM/CgpHcntvZXRqZSxlZXRpbmd9cywKCgkJ
CQkJCUdlZXJ0CgotLQpHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4
IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnCgpJbiBwZXJzb25hbCBjb252ZXJz
YXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0
CndoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIg
b3Igc29tZXRoaW5nIGxpa2UgdGhhdC4KCQkJCQkJCSAgICAtLSBMaW51cyBUb3J2YWxkcwoKLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCkNyeXN0YWwgUmVwb3J0cyAtIE5ldyBGcmVlIFJ1bnRpbWUgYW5k
IDMwIERheSBUcmlhbApDaGVjayBvdXQgdGhlIG5ldyBzaW1wbGlmaWVkIGxpY2Vuc2luZyBvcHRp
b24gdGhhdCBlbmFibGVzIAp1bmxpbWl0ZWQgcm95YWx0eS1mcmVlIGRpc3RyaWJ1dGlvbiBvZiB0
aGUgcmVwb3J0IGVuZ2luZSAKZm9yIGV4dGVybmFsbHkgZmFjaW5nIHNlcnZlciBhbmQgd2ViIGRl
cGxveW1lbnQuIApodHRwOi8vcC5zZi5uZXQvc2Z1L2J1c2luZXNzb2JqZWN0cwpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mYmRldi1kZXZlbCBt
YWlsaW5nIGxpc3QKTGludXgtZmJkZXYtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBz
Oi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWZiZGV2LWRldmVs
Cg==
