From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 01/58] move acornfb's probe function to
	.devinit.text
Date: Sat, 28 Mar 2009 00:26:22 +0100
Message-ID: <1238196439-16535-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20090327232153.GA16348@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>) id 1LnLSr-0006BO-IF
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 27 Mar 2009 23:27:53 +0000
Received: from metis.ext.pengutronix.de ([92.198.50.35])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LnLSn-0004mw-Q7
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 27 Mar 2009 23:27:53 +0000
In-Reply-To: <20090327232153.GA16348@pengutronix.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: linux-kernel@vger.kernel.org
Cc: Antonino Daplas <adaplas@pol.net>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, Christoph Hellwig <hch@lst.de>

QSBwb2ludGVyIHRvIGFjb3JuZmJfcHJvYmUgaXMgcGFzc2VkIHRvIHRoZSBjb3JlIHZpYQpwbGF0
Zm9ybV9kcml2ZXJfcmVnaXN0ZXIgYW5kIHNvIHRoZSBmdW5jdGlvbiBtdXN0IG5vdCBkaXNhcHBl
YXIgd2hlbiB0aGUKLmluaXQgc2VjdGlvbnMgYXJlIGRpc2NhcmRlZC4gIE90aGVyd2lzZSAoaWYg
YWxzbyBoYXZpbmcgSE9UUExVRz15KQp1bmJpbmRpbmcgYW5kIGJpbmRpbmcgYSBkZXZpY2UgdG8g
dGhlIGRyaXZlciB2aWEgc3lzZnMgd2lsbCByZXN1bHQgaW4gYW4Kb29wcyBhcyBkb2VzIGEgZGV2
aWNlIGJlaW5nIHJlZ2lzdGVyZWQgbGF0ZS4KCkFuIGFsdGVybmF0aXZlIHRvIHRoaXMgcGF0Y2gg
aXMgdXNpbmcgcGxhdGZvcm1fZHJpdmVyX3Byb2JlIGluc3RlYWQgb2YKcGxhdGZvcm1fZHJpdmVy
X3JlZ2lzdGVyIHBsdXMgcmVtb3ZpbmcgdGhlIHBvaW50ZXIgdG8gdGhlIHByb2JlIGZ1bmN0aW9u
CmZyb20gdGhlIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIuCgpTaWduZWQtb2ZmLWJ5OiBVd2UgS2xl
aW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPgpDYzogQ2hyaXN0b3Bo
IEhlbGx3aWcgPGhjaEBsc3QuZGU+CkNjOiBBbnRvbmlubyBEYXBsYXMgPGFkYXBsYXNAcG9sLm5l
dD4KQ2M6IGxpbnV4LWZiZGV2LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApDYzogQW5kcmV3
IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4KLS0tCiBkcml2ZXJzL3ZpZGVvL2Fj
b3JuZmIuYyB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vYWNvcm5mYi5jIGIvZHJpdmVy
cy92aWRlby9hY29ybmZiLmMKaW5kZXggNjFjM2QzZi4uMTllNGIyMSAxMDA2NDQKLS0tIGEvZHJp
dmVycy92aWRlby9hY29ybmZiLmMKKysrIGIvZHJpdmVycy92aWRlby9hY29ybmZiLmMKQEAgLTEy
NTksNyArMTI1OSw3IEBAIGZyZWVfdW51c2VkX3BhZ2VzKHVuc2lnbmVkIGludCB2aXJ0dWFsX3N0
YXJ0LCB1bnNpZ25lZCBpbnQgdmlydHVhbF9lbmQpCiAJcHJpbnRrKCJhY29ybmZiOiBmcmVlZCAl
ZEsgbWVtb3J5XG4iLCBtYl9mcmVlZCk7CiB9CiAKLXN0YXRpYyBpbnQgX19pbml0IGFjb3JuZmJf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqZGV2KQorc3RhdGljIGludCBfX2RldmluaXQg
YWNvcm5mYl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYpCiB7CiAJdW5zaWduZWQg
bG9uZyBzaXplOwogCXVfaW50IGhfc3luYywgdl9zeW5jOwotLSAKMS42LjIKCgotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtZmJkZXYtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWZiZGV2LWRldmVsQGxpc3Rz
LnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0
aW5mby9saW51eC1mYmRldi1kZXZlbAo=
