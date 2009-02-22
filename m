From: "Sergei S." <bender.rodriguez@open.by>
Subject: Re: [Bugme-new] [Bug 12712] New: s2disk hangs
 with nvidiafb
Date: Sun, 22 Feb 2009 12:47:11 +0200
Message-ID: <web-46440394@post.open.by>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <bender.rodriguez@open.by>) id 1LbBri-0000Oy-De
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 22 Feb 2009 10:47:18 +0000
Received: from mail.open.by ([193.232.92.17] helo=post.open.by)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LbBre-0007aU-C1 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 22 Feb 2009 10:47:18 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Content-Type: text/plain; charset="maccyrillic"
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, bugme-daemon@bugzilla.kernel.org

SGVsbG8uCgpCeSB0aGUgd2F5LgoKW2RyaXZlcnMvdmlkZW8vdmVzYWZiLmMKc3RhdGljIGludCBf
X2luaXQgdmVzYWZiX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmRldildCgoJaWYgKCFy
ZXF1ZXN0X21lbV9yZWdpb24odmVzYWZiX2ZpeC5zbWVtX3N0YXJ0LCBzaXplX3RvdGFsLCAidmVz
YWZiIikpIHsKCQlwcmludGsoS0VSTl9XQVJOSU5HCgkJICAgICAgICJ2ZXNhZmI6IGNhbm5vdCBy
ZXNlcnZlIHZpZGVvIG1lbW9yeSBhdCAweCVseFxuIiwKCQkJdmVzYWZiX2ZpeC5zbWVtX3N0YXJ0
KTsKCQkvKiBXZSBjYW5ub3QgbWFrZSB0aGlzIGZhdGFsLiBTb21ldGltZXMgdGhpcyBjb21lcyBm
cm9tIG1hZ2ljCgkJICAgc3BhY2VzIG91ciByZXNvdXJjZSBoYW5kbGVycyBzaW1wbHkgZG9uJ3Qg
a25vdyBhYm91dCAqLwoJfQoKSXMgdGhlcmUgYW55IHJlYXNvbiBub3QgdG8gbWFrZSB2ZXNhZmIg
cmVxdWVzdF9tZW1fcmVnaW9uIGZhaWwgZmF0YWw/CgpJbiBjYXNlIHdlIGFscmVhZHkgaGF2ZSBm
cmFtZWJ1ZmZlciBhdCAweGMwMDAwMDAwIGFuZCBmcmFtZWJ1ZmZlcl9hbGxvYyBmYWlsZWQgLQp3
ZSdsbCByZWxlYXNlIG5vbi12ZXNhZmIgbWVtb3J5IHJlZ2lvbi4KCglpbmZvID0gZnJhbWVidWZm
ZXJfYWxsb2Moc2l6ZW9mKHUzMikgKiAyNTYsICZkZXYtPmRldik7CglpZiAoIWluZm8pIHsKCQly
ZWxlYXNlX21lbV9yZWdpb24odmVzYWZiX2ZpeC5zbWVtX3N0YXJ0LCBzaXplX3RvdGFsKTsKCQly
ZXR1cm4gLUVOT01FTTsKCX0KCgpTbywgd2hhdCBkbyB5b3UgdGhpbmsgYWJvdXQgdGhlIGlkZWEg
dG8gY2hlY2sgbnVtX3JlZ2lzdGVyZWRfZmIgd2hlbiByZXF1ZXN0X21lbV9yZWdpb24gCmZhaWxz
PwotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCi4u
LuAg8uXv5fD8IO7v6+Dy6PL8IPjo8O7q7u/u6+7x7fvpIOTu8fLz7wriIPHl8vwgyO3y5fDt5fIg
QnlGbHkg7O7m7e4g/evl6vLw7u3t++zoIOTl7fzj4OzoIEVhc3lQYXkuCmh0dHA6Ly93d3cuZWFz
eXBheS5ieS8KCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpPcGVuIFNvdXJjZSBCdXNpbmVzcyBDb25m
ZXJlbmNlIChPU0JDKSwgTWFyY2ggMjQtMjUsIDIwMDksIFNhbiBGcmFuY2lzY28sIENBCi1PU0JD
IHRhY2tsZXMgdGhlIGJpZ2dlc3QgaXNzdWUgaW4gb3BlbiBzb3VyY2U6IE9wZW4gU291cmNpbmcg
dGhlIEVudGVycHJpc2UKLVN0cmF0ZWdpZXMgdG8gYm9vc3QgaW5ub3ZhdGlvbiBhbmQgY3V0IGNv
c3RzIHdpdGggb3BlbiBzb3VyY2UgcGFydGljaXBhdGlvbgotUmVjZWl2ZSBhICQ2MDAgZGlzY291
bnQgb2ZmIHRoZSByZWdpc3RyYXRpb24gZmVlIHdpdGggdGhlIHNvdXJjZSBjb2RlOiBTRkFECmh0
dHA6Ly9wLnNmLm5ldC9zZnUvWGN2TXpGOEgKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtZmJkZXYtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWZi
ZGV2LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdl
Lm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mYmRldi1kZXZlbAo=
