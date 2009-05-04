From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] clps711xfb: use framebuffer_alloc()
	to allocate fb_info struct
Date: Mon, 4 May 2009 21:39:27 +0200
Message-ID: <10f740e80905041239u792aca14kc7056bbce98d2a15@mail.gmail.com>
References: <20090504185746.a8507d17.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert.uytterhoeven@gmail.com>) id 1M140p-00067q-7O
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 May 2009 19:39:39 +0000
Received: from mail-ew0-f217.google.com ([209.85.219.217])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M140f-0005c6-AH for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 May 2009 19:39:39 +0000
Received: by ewy17 with SMTP id 17so4307829ewy.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 04 May 2009 12:39:28 -0700 (PDT)
In-Reply-To: <20090504185746.a8507d17.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

T24gTW9uLCBNYXkgNCwgMjAwOSBhdCAxODo1NywgS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5o
MUBwb2N6dGEuZm0+IHdyb3RlOgo+IEZyb206IEtyenlzenRvZiBIZWx0IDxrcnp5c3p0b2YuaDFA
d3AucGw+Cj4KPiBVc2UgdGhlIGZyYW1lYnVmZmVyX2FsbG9jKCkgZnVuY3Rpb24gdG8gYWxsb2Nh
dGUgdGhlIGZiX2luZm8KPiBzdHJ1Y3R1cmUgc28gdGhlIHN0cnVjdHVyZSBpcyBjb3JyZWN0bHkg
aW5pdGlhbGl6ZWQgYWZ0ZXIgYWxsb2NhdGlvbi4KPgo+IFNpZ25lZC1vZmYtYnk6IEtyenlzenRv
ZiBIZWx0IDxrcnp5c3p0b2YuaDFAd3AucGw+Cj4gLS0tCj4gwqBkcml2ZXJzL3ZpZGVvL2NscHM3
MTF4ZmIuYyB8IMKgIMKgMiArLQo+IMKgMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9jbHBzNzExeGZi
LmMgYi9kcml2ZXJzL3ZpZGVvL2NscHM3MTF4ZmIuYwo+IGluZGV4IDE2ZjVkYjQuLjgwZmQ1ZjEg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aWRlby9jbHBzNzExeGZiLmMKPiArKysgYi9kcml2ZXJz
L3ZpZGVvL2NscHM3MTF4ZmIuYwo+IEBAIC0zNjYsNyArMzY2LDcgQEAgaW50IF9faW5pdCBjbHBz
NzExeGZiX2luaXQodm9pZCkKPiDCoCDCoCDCoCDCoGlmIChmYl9nZXRfb3B0aW9ucygiY2xwczcx
MXhmYiIsIE5VTEwpKQo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1FTk9ERVY7Cj4K
PiAtIMKgIMKgIMKgIGNmYiA9IGt6YWxsb2Moc2l6ZW9mKCpjZmIpLCBHRlBfS0VSTkVMKTsKPiAr
IMKgIMKgIMKgIGNmYiA9IGZyYW1lYnVmZmVyX2FsbG9jKDAsIE5VTEwpOwo+IMKgIMKgIMKgIMKg
aWYgKCFjZmIpCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIG91dDsKCldoaWxlIGN1cnJl
bnRseSBmcmFtZWJ1ZmZlcl9yZWxlYXNlKCkgaXMgaWRlbnRpY2FsIHRvIGtmcmVlKCksIEkgdGhp
bmsKdGhlc2Ugc2hvdWxkCmFsc28gYmUgY29udmVydGVkIGZyb20ga2ZyZWUoKSB0byBmcmFtZWJ1
ZmZlcl9yZWxlYXNlKCkuCgpHcntvZXRqZSxlZXRpbmd9cywKCgkJCQkJCUdlZXJ0CgotLQpHZWVy
dCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdl
ZXJ0QGxpbnV4LW02OGsub3JnCgpJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5p
Y2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0CndoZW4gSSdtIHRhbGtpbmcg
dG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2Ug
dGhhdC4KCQkJCQkJCSAgICAtLSBMaW51cyBUb3J2YWxkcwoKLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
ClJlZ2lzdGVyIE5vdyAmIFNhdmUgZm9yIFZlbG9jaXR5LCB0aGUgV2ViIFBlcmZvcm1hbmNlICYg
T3BlcmF0aW9ucyAKQ29uZmVyZW5jZSBmcm9tIE8nUmVpbGx5IE1lZGlhLiBWZWxvY2l0eSBmZWF0
dXJlcyBhIGZ1bGwgZGF5IG9mIApleHBlcnQtbGVkLCBoYW5kcy1vbiB3b3Jrc2hvcHMgYW5kIHR3
byBkYXlzIG9mIHNlc3Npb25zIGZyb20gaW5kdXN0cnkgCmxlYWRlcnMgaW4gZGVkaWNhdGVkIFBl
cmZvcm1hbmNlICYgT3BlcmF0aW9ucyB0cmFja3MuIFVzZSBjb2RlIHZlbDA5c2NmIAphbmQgU2F2
ZSBhbiBleHRyYSAxNSUgYmVmb3JlIDUvMy4gaHR0cDovL3Auc2YubmV0L3NmdS92ZWxvY2l0eWNv
bmYKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
ZmJkZXYtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWZiZGV2LWRldmVsQGxpc3RzLnNvdXJjZWZv
cmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51
eC1mYmRldi1kZXZlbAo=
