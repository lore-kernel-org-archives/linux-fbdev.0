From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [RFC 2.6.26-rc3 1/7] pxafb: module
	unloading support
Date: Tue, 10 Jun 2008 15:44:38 +0800
Message-ID: <484E30E6.8090204@gmail.com>
References: <1212814166-10313-1-git-send-email-jayakumar.lkml@gmail.com>	<1212814166-10313-2-git-send-email-jayakumar.lkml@gmail.com>
	<18510.8821.785915.671710@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K5yXJ-0007Kd-7o for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 10 Jun 2008 00:44:57 -0700
Received: from rv-out-0708.google.com ([209.85.198.248])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K5yXH-0006cx-0P
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 10 Jun 2008 00:44:57 -0700
Received: by rv-out-0708.google.com with SMTP id f25so2227758rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 10 Jun 2008 00:44:54 -0700 (PDT)
In-Reply-To: <18510.8821.785915.671710@ipc1.ka-ro>
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
To: =?UTF-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, ymiao3@marvell.com, Jaya Kumar <jayakumar.lkml@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk

TG90aGFyIFdhw59tYW5uIHdyb3RlOgo+IEpheWEgS3VtYXIgd3JvdGU6Cj4+IEBAIC0xNTg3LDcg
KzE1ODcsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBweGFmYl9wYXJzZV9vcHRpb25zKHN0cnVjdCBk
ZXZpY2UgKmRldiwgY2hhciAqb3B0aW9ucykKPj4gIHN0YXRpYyBjaGFyIGdfb3B0aW9uc1syNTZd
IF9fZGV2aW5pdGRhdGEgPSAiIjsKPj4gIAo+PiAgI2lmbmRlZiBDT05GSUdfTU9EVUxFUwo+ICAg
ICAgICAgICAgXl5eXl5eXl5eXl5eXl4KPj4gLXN0YXRpYyBpbnQgX19kZXZpbml0IHB4YWZiX3Nl
dHVwX29wdGlvbnModm9pZCkKPj4gK3N0YXRpYyBpbnQgX19pbml0IHB4YWZiX3NldHVwX29wdGlv
bnModm9pZCkKPj4KPiBUaGF0IHNob3VsZCBiZSAnI2lmbmRlZiBNT0RVTEUnLgo+IE90aGVyd2lz
ZSBzdXBwb3J0IGZvciBjbWRsaW5lIG9wdGlvbnMgZm9yIHRoZSBidWlsdC1pbiBkcml2ZXIgd2ls
bAo+IG9ubHkgYmUgZW5hYmxlZCBpZiB0aGUga2VybmVsIGlzIGNvbXBpbGVkIHdpdGhvdXQgbW9k
dWxlIHN1cHBvcnQuCj4gCgpZZXMsIGluZGVlZC4gSXQgcmVxdWlyZXMgYW5vdGhlciBmaXggcGF0
Y2ggZm9yIHRoaXMuCgo+IAo+IExvdGhhciBXYcOfbWFubgoKCi0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KQ2hl
Y2sgb3V0IHRoZSBuZXcgU291cmNlRm9yZ2UubmV0IE1hcmtldHBsYWNlLgpJdCdzIHRoZSBiZXN0
IHBsYWNlIHRvIGJ1eSBvciBzZWxsIHNlcnZpY2VzIGZvcgpqdXN0IGFib3V0IGFueXRoaW5nIE9w
ZW4gU291cmNlLgpodHRwOi8vc291cmNlZm9yZ2UubmV0L3NlcnZpY2VzL2J1eS9pbmRleC5waHAK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZmJk
ZXYtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWZiZGV2LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1m
YmRldi1kZXZlbAo=
