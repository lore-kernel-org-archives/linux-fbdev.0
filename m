Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792854412;
	b=rOUGb5VbDRrqfYOF+QqY+Wh8AXc7wKUUmj4HWkc0wOyHjzsjRnMbRMlyjnQM9IAaSVa0
	 t+Uit8kTYBxVvdl8YVfidMzEPfKwJIMeLHw3ebZSlzO9o9eKlTmKMOpDG/9gOT9AAzAXP
	 ftRhZJh/QajHNWbto5furbITXjFinGI6lkMJWBzrPHRi0DWnl0t2IUAi8UNNQ9wqwCKi8
	 EZiL7m6JltyWyhdc2OwcPKA0GhbklCdQ14zK4jn9SvmQg7JS26+llxi/lzH5xR/RItJPW
	 GVifzZAXPdc7VxD4O59SKBE7slFi5k947lz4tnlUnOLirz3IHysrc9hTvgPl+KngWbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792854412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=hCCqssXOeZVkDx8ZE/ynn3/Hgi/kUYrLr11inzz+yzM=;
	b=pI85CWGVjjbAZAOlBF6Xtt1G6xakrkY3TGe9WtsQNJpTrtWCCMplGBfBHQklrwWOMR1K
	 oo3GsQb4Ymp5AHCksMBOFWvDnpgVQC32Rb+cMHZsgjxxW/l9MmjMIx8WRG215noctHmoV
	 13ixQTbRicfFxw1eGN8YGhuZp+0YkjDTA/0YyiJjtn9wJMRm/T61Cdnh2tMSFsTHS8Hz6
	 mjWm2qiqetpEev6t7lTyAl0DFzCnUqCghG7vC0/szYokxXn7yRqQ0lZ8TSGdVl41QI/n0
	 IxVajVvGSf+RCWmuP+C0g2vRqcvl78xPyoxU6EGqNQ0qATAXchuVyoKfwcvRIQeqhBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gIYFHd8D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536EE606A31B
	for <linux-fbdev@vger.kernel.org>; Sat, 24 Oct 2026 15:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 536EE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gIYFHd8D
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2acc1e170cso247544066b.1
        for <linux-fbdev@vger.kernel.org>; Sat, 24 Oct 2026 08:06:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792854411; cv=none;
        d=google.com; s=arc-20260327;
        b=NR2GQgRhknhiz+63XtSWMpGBTAqROTl//oZ5IhwGTAm+3aogwBQfMIM4NnB1UobqkG
         +PTT11rgtzsIxUZjgkEfbMNBbPpFO3wVwlYjUdgeTuCRiQwDgEzZg7hbIqxJuqauWqJq
         3o89gCcuaJQU+rt5eNAPsv4Z2mr+uO6aoiZVHJQRezUY8TqaXvBi2O4tTwwznbXehKfu
         vr9v54yBboNtkQN/hGAtTt/w5xMiD9Bzckzp+hscQDjwVX85ibo3bjaEDEyF5ScfGtmB
         XWnzvjZxcAiXx2LHUKkgadarA9w/eA04WthfJi+vz6bNEdOXQEswYQlT/mZydOEWjdYw
         /fDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=hCCqssXOeZVkDx8ZE/ynn3/Hgi/kUYrLr11inzz+yzM=;
        fh=0o/RObXEdxpPFX23pYkDLGNQEkS+ZqRCh7axAassoVs=;
        b=Pp/NlVNwJYfeBhJ+8VRb6qIc718tvQgJw52z/xlBJDF+eZmACsfwzk5AZVd4RgNUnT
         cxZzeGzWPTItP1N4kJ5O3p/MnlFK7tmnV8UjhsvjQOsMnpo5aBYPjiAfe9CAzXSscvcx
         knJis1imxBdcvFD3mHfDJ7V5ALCmI+NQkvztgTTDeHAy3WeXbvHHfjgbLe3R4jGXknzj
         +bZMHw09MvoOmOwqYTp6jkLzrBispowCvYRL0AjRMKY5KrpF7f11qTMhy30VuvykewVN
         3a5nEZMyBExgaQ5eEiM0wWni3CO1b9Myx4bfXg0y/U8CEWc9vOT/3du95V95d/4XkWep
         N1NQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792854411; x=1793459211; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hCCqssXOeZVkDx8ZE/ynn3/Hgi/kUYrLr11inzz+yzM=;
        b=gIYFHd8DsEXamix+NMalBmpbJ1aAc9wR8B4CGy892vSJyUNML2hmJ0NRacqctbZOjV
         uGG9hpaaDlxaNlh5gU5jYxYNW7B7z7iSnHn2vHk/uC15bzEKgFubDpuolsX2e6xeeH4M
         WaTEzDXQJjwrMtbb5JgtaorqWm9yVLEP9TMe8kHTqFdpAdaXn9dF0p79p5c2NCRiYfMa
         gCwVBW7TsCo4Nte/3NDWPMo9FpQIk+0q0a8ToklKUX8istFSWHB5YYkJ302D/B8Poegu
         uh51+1oBggN3VcM8XWNM1Bz44h2tRdlbsbRojMTcW2MvP7lCDFkNrzznE8+M8MXPXUms
         t0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792854411; x=1793459211;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hCCqssXOeZVkDx8ZE/ynn3/Hgi/kUYrLr11inzz+yzM=;
        b=yK6oefHeq9R197zWdtpO58S18sGp0fPcQQ/4+jl24RHGx51gXMIpoYt3Y85YOvg+BT
         bP2BSvGmAMjSHQR21Z8TdgUMPpK9advc5dayP6SmfXIKs1YFRjrCCUL0RHj4bd/piubD
         NrOKu693904IJ/y/0lb7DDNy5BQ9/0+jktJgUY2jcVCgFA7EvHY5hjuz37ZXkmBwe6tc
         sePytoCq1NQP0Y2IPgsYCJeiXaueAhZrig+Kw3BzDgsUHYkSYGmW0WXZ/4VZqb5jlgCg
         kmmhJJnas3gPIHJb2Kn/L42zXtHci5+NaQxlJiG+096Us/3eBfLrHn8ZvT82aS9FYuBw
         V+ZA==
X-Forwarded-Encrypted: i=1; AKwUvBwdn8mLoQs4I8V1WORj+Ve+J4aLZxff2c2X/BYnUh1mw/zgEB8TO0C/QPi32u8I1RxAhI0fThgiWh2CZQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKIiiOXQosimt1/MBVTTPdn99x31Gylgp+DxI+tNKIFH092Ttwz
	S+0i1I9Grl6eOuwDuUglif1Av8v8XVqlAqYQNi+t1/zdMK8fCt+8cJt9URhKDltwPTjCJZHMx6y
	Ktuz9izlnHZdAPiwzl30fjESBfrYpY7kk5H15See8Ug==
X-Gm-Gg: AYBFou2AeGb+7WEOMhvp6+GKe4L/v7VbM7gwS1ZeRckGmTEtPwrDo/xHNL5+SdMmH7c
	pqqo81yEkF13NUdqP78gwpOplaMihL9lQDrDlDopYxS7MwPpGzRxOlW6wuj+/iCTgu03Pd15amz
	gGzLmx2Ky+0JnV4yb1ODm3+AolP9hGSGltpV4Sh8y1dGZ0cQ8qZAu3NB4X1CArsMjPILIUwbIFK
	zkpIgC9BObKsE5e1Mp0d1jzP8jJIcQGuXET+vR/s287lEOoHSdMvFzz66o1Ce35fwKN7e9hqaRX
	lePSZudNuYTLJZGPCw4Gr6rz7sP1AspHMgL0+VwS6rMUATwI0rxkMw7Sh/2TusFa6KElU+dLP+Y
	F8z+XWQZDSgGBgVn+yH+NHHV9+ZDcqZ0SmxfqtsJOWpem32O1se9k1NgP74UAvAorMOGC
X-Received: by 2002:a17:907:6d16:b0:c24:87e5:6491 with SMTP id
 a640c23a62f3a-c46bda69f8dmr291186666b.2.1792854410627; Sat, 24 Oct 2026
 08:06:50 -0700 (PDT)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Abubakar Musa Samaila <abubakarmusasamaila@gmail.com>
Date: Sat, 24 Oct 2026 16:06:36 +0100
X-Gm-Features: AclHuK99BklcQsEQBiE_tBGIeGBFoFNj7HpEgy0uA-KhpZyzNFx1YZjL5cBBczA
Message-ID: <CAHxSwT_gJbatihGE4DAu=JmSnvWXpguUq4Yzg7jreTRhqzdQhA@mail.gmail.com>
Subject: staging: fbtft: fb_upd161704: Replace udelay() with usleep_range()
To: andy@kernel.org, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000047f7ec065e9772eb"

--00000000000047f7ec065e9772eb
Content-Type: text/plain; charset="UTF-8"

Hi Andy and Greg,

Please find attached the patch that replaces non-atomic udelay()
instances with appropriate usleep_range() bounds in
drivers/staging/fbtft/fb_upd161704.c.

Thanks,

Abubakar Musa Samaila

--00000000000047f7ec065e9772eb
Content-Type: application/octet-stream; 
	name="0001-staging-fbtft-fb_upd161704-Replace-udelay-with-uslee.patch"
Content-Disposition: attachment; 
	filename="0001-staging-fbtft-fb_upd161704-Replace-udelay-with-uslee.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mvmj4hza0>
X-Attachment-Id: f_mvmj4hza0

RnJvbSA3NzgwMzBhYTkyOTFlM2E3ZDQwZmZiMDNiMTllNjg3NzA0MWNkZGM4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBYnViYWthciBNdXNhIFNhbWFpbGEgPGFidWJha2FybXVzYXNh
bWFpbGFAZ21haWwuY29tPgpEYXRlOiBTYXQsIDI0IE9jdCAyMDI2IDEyOjAyOjI1ICswMTAwClN1
YmplY3Q6IFtQQVRDSF0gc3RhZ2luZzogZmJ0ZnQ6IGZiX3VwZDE2MTcwNDogUmVwbGFjZSB1ZGVs
YXkoKSB3aXRoCiB1c2xlZXBfcmFuZ2UoKQoKU2lnbmVkLW9mZi1ieTogQWJ1YmFrYXIgTXVzYSBT
YW1haWxhIDxhYnViYWthcm11c2FzYW1haWxhQGdtYWlsLmNvbT4KLS0tCiBkcml2ZXJzL3N0YWdp
bmcvZmJ0ZnQvZmJfdXBkMTYxNzA0LmMgfCAxOCArKysrKysrKystLS0tLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9zdGFnaW5nL2ZidGZ0L2ZiX3VwZDE2MTcwNC5jIGIvZHJpdmVycy9zdGFnaW5nL2ZidGZ0
L2ZiX3VwZDE2MTcwNC5jCmluZGV4IDcyODgxNDBlNy4uOTRhZTViYmYwIDEwMDY0NAotLS0gYS9k
cml2ZXJzL3N0YWdpbmcvZmJ0ZnQvZmJfdXBkMTYxNzA0LmMKKysrIGIvZHJpdmVycy9zdGFnaW5n
L2ZidGZ0L2ZiX3VwZDE2MTcwNC5jCkBAIC0zMiwyNyArMzIsMjcgQEAgc3RhdGljIGludCBpbml0
X2Rpc3BsYXkoc3RydWN0IGZidGZ0X3BhciAqcGFyKQogCiAJLyogb3NjaWxsYXRvciBzdGFydCAq
LwogCXdyaXRlX3JlZyhwYXIsIDB4MDAzQSwgMHgwMDAxKTsJLypPc2NpbGxhdG9yIDA6IHN0b3As
IDE6IG9wZXJhdGlvbiAqLwotCXVkZWxheSgxMDApOworCXVzbGVlcF9yYW5nZSgxMDAsIDE1MCk7
CiAKIAkvKiB5LXNldHRpbmcgKi8KIAl3cml0ZV9yZWcocGFyLCAweDAwMjQsIDB4MDA3Qik7CS8q
IGFtcGxpdHVkZSBzZXR0aW5nICovCi0JdWRlbGF5KDEwKTsKKwl1c2xlZXBfcmFuZ2UoMTAsIDIw
KTsKIAl3cml0ZV9yZWcocGFyLCAweDAwMjUsIDB4MDAzQik7CS8qIGFtcGxpdHVkZSBzZXR0aW5n
ICovCiAJd3JpdGVfcmVnKHBhciwgMHgwMDI2LCAweDAwMzQpOwkvKiBhbXBsaXR1ZGUgc2V0dGlu
ZyAqLwotCXVkZWxheSgxMCk7CisJdXNsZWVwX3JhbmdlKDEwLCAyMCk7CiAJd3JpdGVfcmVnKHBh
ciwgMHgwMDI3LCAweDAwMDQpOwkvKiBhbXBsaXR1ZGUgc2V0dGluZyAqLwogCXdyaXRlX3JlZyhw
YXIsIDB4MDA1MiwgMHgwMDI1KTsJLyogY2lyY3VpdCBzZXR0aW5nIDEgKi8KLQl1ZGVsYXkoMTAp
OworCXVzbGVlcF9yYW5nZSgxMCwgMjApOwogCXdyaXRlX3JlZyhwYXIsIDB4MDA1MywgMHgwMDMz
KTsJLyogY2lyY3VpdCBzZXR0aW5nIDIgKi8KIAl3cml0ZV9yZWcocGFyLCAweDAwNjEsIDB4MDAx
Qyk7CS8qIGFkanVzdG1lbnQgVjEwIHBvc2l0aXZlIHBvbGFyaXR5ICovCi0JdWRlbGF5KDEwKTsK
Kwl1c2xlZXBfcmFuZ2UoMTAsIDIwKTsKIAl3cml0ZV9yZWcocGFyLCAweDAwNjIsIDB4MDAyQyk7
CS8qIGFkanVzdG1lbnQgVjkgbmVnYXRpdmUgcG9sYXJpdHkgKi8KIAl3cml0ZV9yZWcocGFyLCAw
eDAwNjMsIDB4MDAyMik7CS8qIGFkanVzdG1lbnQgVjM0IHBvc2l0aXZlIHBvbGFyaXR5ICovCi0J
dWRlbGF5KDEwKTsKKwl1c2xlZXBfcmFuZ2UoMTAsIDIwKTsKIAl3cml0ZV9yZWcocGFyLCAweDAw
NjQsIDB4MDAyNyk7CS8qIGFkanVzdG1lbnQgVjMxIG5lZ2F0aXZlIHBvbGFyaXR5ICovCi0JdWRl
bGF5KDEwKTsKKwl1c2xlZXBfcmFuZ2UoMTAsIDIwKTsKIAl3cml0ZV9yZWcocGFyLCAweDAwNjUs
IDB4MDAxNCk7CS8qIGFkanVzdG1lbnQgVjYxIG5lZ2F0aXZlIHBvbGFyaXR5ICovCi0JdWRlbGF5
KDEwKTsKKwl1c2xlZXBfcmFuZ2UoMTAsIDIwKTsKIAl3cml0ZV9yZWcocGFyLCAweDAwNjYsIDB4
MDAxMCk7CS8qIGFkanVzdG1lbnQgVjYxIG5lZ2F0aXZlIHBvbGFyaXR5ICovCiAKIAkvKiBCYXNp
Y2FsIGNsb2NrIGZvciAxIGxpbmUgKEJBU0VDT1VOVFs3OjBdKSBudW1iZXIgc3BlY2lmaWVkICov
CkBAIC02MCw3ICs2MCw3IEBAIHN0YXRpYyBpbnQgaW5pdF9kaXNwbGF5KHN0cnVjdCBmYnRmdF9w
YXIgKnBhcikKIAogCS8qIFBvd2VyIHN1cHBseSBzZXR0aW5nICovCiAJd3JpdGVfcmVnKHBhciwg
MHgwMDE5LCAweDAwMDApOwkvKiBEQy9EQyBvdXRwdXQgc2V0dGluZyAqLwotCXVkZWxheSgyMDAp
OworCXVzbGVlcF9yYW5nZSgyMDAsIDI1MCk7CiAJd3JpdGVfcmVnKHBhciwgMHgwMDFBLCAweDEw
MDApOwkvKiBEQy9EQyBmcmVxdWVuY3kgc2V0dGluZyAqLwogCXdyaXRlX3JlZyhwYXIsIDB4MDAx
QiwgMHgwMDIzKTsJLyogREMvREMgcmlzaW5nIHNldHRpbmcgKi8KIAl3cml0ZV9yZWcocGFyLCAw
eDAwMUMsIDB4MEMwMSk7CS8qIFJlZ3VsYXRvciB2b2x0YWdlIHNldHRpbmcgKi8KLS0gCjIuMzQu
MQoK
--00000000000047f7ec065e9772eb--
