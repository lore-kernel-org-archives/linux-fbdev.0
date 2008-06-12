From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [RFC 2.6.26-rc3 1/7] pxafb: module
	unloading support
Date: Thu, 12 Jun 2008 18:20:02 +0800
Message-ID: <4850F852.40501@gmail.com>
References: <1212814166-10313-1-git-send-email-jayakumar.lkml@gmail.com>	<1212814166-10313-2-git-send-email-jayakumar.lkml@gmail.com>	<18510.8821.785915.671710@ipc1.ka-ro>	<484E30E6.8090204@gmail.com>	<45a44e480806112136j7f96cc68ga4c92d796f64b057@mail.gmail.com>
	<20080612072534.adc46a9e.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K6jul-0002Xr-VU for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jun 2008 03:20:20 -0700
Received: from rv-out-0708.google.com ([209.85.198.241])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K6juh-00045z-Ij
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jun 2008 03:20:19 -0700
Received: by rv-out-0708.google.com with SMTP id f25so3181548rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 12 Jun 2008 03:20:10 -0700 (PDT)
In-Reply-To: <20080612072534.adc46a9e.krzysztof.h1@poczta.fm>
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: linux-fbdev-devel@lists.sourceforge.net, ymiao3@marvell.com, Jaya Kumar <jayakumar.lkml@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk

S3J6eXN6dG9mIEhlbHQgd3JvdGU6Cj4gT24gV2VkLCAxMSBKdW4gMjAwOCAyMTozNjowNCAtMDcw
MAo+ICJKYXlhIEt1bWFyIiA8amF5YWt1bWFyLmxrbWxAZ21haWwuY29tPiB3cm90ZToKPiAKPj4g
T24gVHVlLCBKdW4gMTAsIDIwMDggYXQgMTI6NDQgQU0sIEVyaWMgTWlhbyA8ZXJpYy55Lm1pYW9A
Z21haWwuY29tPiB3cm90ZToKPj4+IExvdGhhciBXYcOfbWFubiB3cm90ZToKPj4+PiBKYXlhIEt1
bWFyIHdyb3RlOgo+Pj4+PiBAQCAtMTU4Nyw3ICsxNTg3LDcgQEAgc3RhdGljIGludCBfX2luaXQg
cHhhZmJfcGFyc2Vfb3B0aW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsIGNoYXIgKm9wdGlvbnMpCj4+
Pj4+ICBzdGF0aWMgY2hhciBnX29wdGlvbnNbMjU2XSBfX2RldmluaXRkYXRhID0gIiI7Cj4+Pj4+
Cj4+Pj4+ICAjaWZuZGVmIENPTkZJR19NT0RVTEVTCj4+Pj4gICAgICAgICAgICBeXl5eXl5eXl5e
Xl5eXgo+Pj4+PiAtc3RhdGljIGludCBfX2RldmluaXQgcHhhZmJfc2V0dXBfb3B0aW9ucyh2b2lk
KQo+Pj4+PiArc3RhdGljIGludCBfX2luaXQgcHhhZmJfc2V0dXBfb3B0aW9ucyh2b2lkKQo+Pj4+
Pgo+Pj4+IFRoYXQgc2hvdWxkIGJlICcjaWZuZGVmIE1PRFVMRScuCj4+Pj4gT3RoZXJ3aXNlIHN1
cHBvcnQgZm9yIGNtZGxpbmUgb3B0aW9ucyBmb3IgdGhlIGJ1aWx0LWluIGRyaXZlciB3aWxsCj4+
Pj4gb25seSBiZSBlbmFibGVkIGlmIHRoZSBrZXJuZWwgaXMgY29tcGlsZWQgd2l0aG91dCBtb2R1
bGUgc3VwcG9ydC4KPj4+Pgo+Pj4gWWVzLCBpbmRlZWQuIEl0IHJlcXVpcmVzIGFub3RoZXIgZml4
IHBhdGNoIGZvciB0aGlzLgo+Pj4KPj4gSGkgRXJpYywgTG90aGFyLAo+Pgo+PiBUaGF0IENPTkZJ
R19NT0RVTEVTIGlzIGZyb20gdGhlIHB4YWZiIGNvZGUuIEl0IGlzIG5vdCBwYXJ0IG9mIHRoZQo+
PiBjaGFuZ2VzIHRoYXQgSSBtYWRlIHRvIHB4YWZiLgo+Pgo+IAo+IEkgc3VwcG9ydCBKYXlhIHBv
c2l0aW9uIG9uIHRoaXMuIFRoZSBvZmZlbmRpbmcgbGluZSBpcyBub3QgcGFydCBvZiBoaXMKPiBw
YXRjaC4gSSB0aGluayB0aGF0IHRoaXMgc2V0IG9mIHBhdGNoZXMgY2FuIGJlIGFjY2VwdGVkIHdp
dGggYWRkaXRpb25hbAo+IHBhdGNoIHdoaWNoIGNvcnJlY3RzIGV4aXN0aW5nIHB4YWZiIHByb2Js
ZW1zIChub3QgcmVsYXRlZCB0byBoaXMgY2hhbmdlcykuCj4gSGUgbWF5IGV2ZW4gcG9zdCB0aGlz
IHBhdGNoIGJlZm9yZSBoaXMgc2V0IGlmIHRoaXMgaXMgcmVxdWlyZWQgdGhpcyB3YXkuCj4gCgpP
SywgSSBzZWUuIEknbSBub3QgcHJvcG9zaW5nIGEgcXVpY2sgZml4IHBhdGNoIGZvciB0aGUgbW9t
ZW50LgoKSSBzdGlsbCBmZWVsIGEgYml0IHVwc2V0IHRvIHRoaXMgc2V0IG9mIHBhdGNoZXMsIGFu
ZCBJIG5lZWQgbW9yZSB0aW1lCnRvIHJldmlldywgdGhhbmtzLgoKPiBSZWdhcmRzLAo+IEtyenlz
enRvZgo+IAo+IAo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiBQb2RiaWogRHppa2kgWmFjaG9kIUdyYSBzdHJh
dGVnaWN6bmEgb25saW5lCj4gU3ByYXdkeiA+Pj4gaHR0cDovL2xpbmsuaW50ZXJpYS5wbC9mMWRm
Zgo+IAoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KQ2hlY2sgb3V0IHRoZSBuZXcgU291cmNlRm9yZ2UubmV0
IE1hcmtldHBsYWNlLgpJdCdzIHRoZSBiZXN0IHBsYWNlIHRvIGJ1eSBvciBzZWxsIHNlcnZpY2Vz
IGZvcgpqdXN0IGFib3V0IGFueXRoaW5nIE9wZW4gU291cmNlLgpodHRwOi8vc291cmNlZm9yZ2Uu
bmV0L3NlcnZpY2VzL2J1eS9pbmRleC5waHAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtZmJkZXYtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWZi
ZGV2LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdl
Lm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mYmRldi1kZXZlbAo=
