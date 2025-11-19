Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FCE34AAF7
	for <linux-fbdev@vger.kernel.org>; Wed, 19 Nov 2025 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763547524; cv=none; b=Hz+s/VyhkQ0moij1xm7F4g0DxIGfEpvqMV9UO+S7SmcIrNso01LTbik4BlmkMPzY9PP9NTAWdiVOdqoU8arTsFGBc8Hc8g/FoxOosB9p1hchOh17qPBRsuUIi3JZ8ELUf3HvptZ6fzA7KHy7ZiwbhS+R+g5HsfS6A+aIRjEg/qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763547524; c=relaxed/simple;
	bh=i5jrwu2khNIASVVE4w6mIB7MzCxaBQWjGiiDYE0y4Ds=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To; b=STFmlcS2LKFN7GPQEkDvpF62w7hmfz8O3cSFKH2cOjcskUHn86Xf8frfjLrchQLiukV5U8+P2f1wemrZ30qYksP/jkliu42HP50ds+RJe+MC7VFGrVKW4oid1Y0CSIyixr4sxGC96UTKj4PcceAGQTKxZX6Aw6VLYgi6BlFGHYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQpL5b+0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQpL5b+0"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-299d40b0845so58798835ad.3
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Nov 2025 02:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763547522; x=1764152322; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:subject:references:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5jrwu2khNIASVVE4w6mIB7MzCxaBQWjGiiDYE0y4Ds=;
        b=PQpL5b+00jOo5E33iwAJDFRDvjN5RPltkS1zcFj2nTCaH7SL3r/19b2QLsBfOsfDeP
         9eRGQXD1X45Mh1RvXPtIsvZS9KDqf+e0j0gTu+PYQOw6wXL960QRDGD/uTru/5mdg/h7
         Ok5VuMF9ArdvqBqeAlUuMwNInGcqzEX+xm25ZPh4tjS/zuQSIHJVJL4XqpgxBozCsMtQ
         v6l8uu7ECle/0N4jJCVsqHbBnd/m4DGAE1R409akhJW5wPx+qJDGPFhPqQlAAAGjsc01
         jguGNC3aQIREcoU+mo/HukdEcE5B3IvsJRiebdBzf+WkH/PN9r2C6kuZcvn1/2iY0OfO
         ZlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763547522; x=1764152322;
        h=in-reply-to:from:content-language:subject:references:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i5jrwu2khNIASVVE4w6mIB7MzCxaBQWjGiiDYE0y4Ds=;
        b=rVB6R/hWjmy5zyw8MPeMmYyDaVag017+HlxdoaJ/DdhvTDHX9QgN1deFngsbrxuz0j
         v2bnBkRhUHtq0Ugwrfs1mLARypg9EyWki+CSKc8yyITGPCCSs6ZqSLeEXre3eAE5gt8n
         fUhjnGs8UNjkRtcE9Oybvxc5c91nh+f2Uc5xcZnE0AeIxlWBZAxikXWszEtURxzIbC4g
         gaF6KUJMhGjGJQiWQ9kYh0EQGO/ythpOybe7oEpMAtGD85o07KcTBtj4N31qJUzQx7BH
         bj0X7falWcMRrOamLdLoiB2ftswt2L0CT8Juz8hIv2+hEB1qDk+CdjOcxiqE/UuQQ+q3
         UfLw==
X-Gm-Message-State: AOJu0Yxs3xSzrLmpgpV05nHCsxxaA0OVxOqwCXEVaFeBrZYsrcUDal0c
	SP8PtCiKzzGJ3D/KhQik9fLxr8XZBmcGuP5jeuKNE0QSee3WoZ0uood2
X-Gm-Gg: ASbGncsrd5FTfjNpq1AQnmkabhOgg6rV5gL5cenMkPw3SpIz3ZXtcYFzZLN46ywSMRl
	2L8Wo3ejNiqgGvykZQ6PIt+cGUEdsi5tCR1Fet9WDwMh/sjz0+FJISnS0fhdN5IU3bHhFKj6ekF
	w7tpDvQNNUjT6WLzdcckwdUBtM6ud2UuAnQu0iTAW8XXiWn/F74OWkcCV9bd4AxUhwXPlWXcWP5
	qaIK+qk+CB4YwKHetsFxU1uLt70ScEndRnv1w9JYPheLpuuqmg6BYlUnqpHckZQTOVruFXX0LE7
	Z9QSbUBS2lepeIFid7JIZnL2mL8mA8veWzJbSVCGlSrnxt8/rN7iidSluK0t8KKyZBsQj1MFSaJ
	OiKdZP7zQKeHehTYBHhPdDE5e9KYPKFGG1Wh6BKVlBZb+V7DZwRVw2FoALu0sIlCLFxQ9+tYMTg
	CiWyloDtzKb/uECit1
X-Google-Smtp-Source: AGHT+IHo81EFKjdonFQULY1623YZ31+3U7GxWRqYCXpWQ3Xyke8u7PJQDpGSccbnBuVm5L2hrvtr6Q==
X-Received: by 2002:a17:902:f602:b0:298:5736:de9b with SMTP id d9443c01a7336-2986a7668f6mr218243835ad.50.1763547522467;
        Wed, 19 Nov 2025 02:18:42 -0800 (PST)
Received: from [192.168.0.149] ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0e15sm202304865ad.60.2025.11.19.02.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 02:18:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------ByzKerrVfgv0yworCRMeTYyF"
Message-ID: <e69c10c5-ee82-4229-b7b6-e3993442595b@gmail.com>
Date: Wed, 19 Nov 2025 15:48:41 +0530
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+5a40432dfe8f86ee657a@syzkaller.appspotmail.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <691c279e.a70a0220.3124cb.00b5.GAE@google.com>
Subject: Re: [syzbot] [fbdev?] KASAN: vmalloc-out-of-bounds Write in imageblit
 (6)
Content-Language: en-US
From: shaurya <ssranevjti@gmail.com>
In-Reply-To: <691c279e.a70a0220.3124cb.00b5.GAE@google.com>

This is a multi-part message in MIME format.
--------------ByzKerrVfgv0yworCRMeTYyF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
--------------ByzKerrVfgv0yworCRMeTYyF
Content-Type: text/x-patch; charset=UTF-8; name="0001-testing-my-fix.patch"
Content-Disposition: attachment; filename="0001-testing-my-fix.patch"
Content-Transfer-Encoding: base64

RnJvbSAxODhmYzdlZWE0YTAwNTAwYTgwNmI3YjEyMmQyMDI4OWFiYzJiZjAwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTaGF1cnlhIFJhbmUgPHNzcmFuZV9iMjNAZWUudmp0
aS5hYy5pbj4KRGF0ZTogV2VkLCAxOSBOb3YgMjAyNSAxNTo0NDo1MSArMDUzMApTdWJqZWN0
OiBbUEFUQ0hdIHRlc3RpbmcgbXkgZml4CgpTaWduZWQtb2ZmLWJ5OiBTaGF1cnlhIFJhbmUg
PHNzcmFuZV9iMjNAZWUudmp0aS5hYy5pbj4KLS0tCiBkcml2ZXJzL3ZpZGVvL2ZiZGV2L2Nv
cmUvZmJfaW1hZ2VibGl0LmggfCA2NiArKysrKysrKysrKysrKysrKysrKysrKy0tCiAxIGZp
bGUgY2hhbmdlZCwgNjIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJfaW1hZ2VibGl0LmggYi9kcml2ZXJz
L3ZpZGVvL2ZiZGV2L2NvcmUvZmJfaW1hZ2VibGl0LmgKaW5kZXggM2IyYmI0OTQ2NTA1Li5h
ZWU3ZjQwMzIxNjQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmlkZW8vZmJkZXYvY29yZS9mYl9p
bWFnZWJsaXQuaAorKysgYi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJfaW1hZ2VibGl0
LmgKQEAgLTQ4NSwxMSArNDg1LDY5IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBmYl9pbWFnZWJs
aXQoc3RydWN0IGZiX2luZm8gKnAsIGNvbnN0IHN0cnVjdCBmYl9pbWFnZSAqaW1hZ2UpCiAJ
c3RydWN0IGZiX2FkZHJlc3MgZHN0ID0gZmJfYWRkcmVzc19pbml0KHApOwogCXN0cnVjdCBm
Yl9yZXZlcnNlIHJldmVyc2UgPSBmYl9yZXZlcnNlX2luaXQocCk7CiAJY29uc3QgdTMyICpw
YWxldHRlID0gZmJfcGFsZXR0ZShwKTsKKwlzdHJ1Y3QgZmJfaW1hZ2UgY2xpcHBlZF9pbWFn
ZTsKKwl1MzIgbWF4X3gsIG1heF95OworCXVuc2lnbmVkIGxvbmcgbWF4X29mZnNldF9ieXRl
czsKKworCS8qIFZhbGlkYXRlIGJhc2ljIHBhcmFtZXRlcnMgKi8KKwlpZiAoIWltYWdlIHx8
ICFwLT5zY3JlZW5fYnVmZmVyIHx8ICFwLT5zY3JlZW5fc2l6ZSB8fCAKKwkgICAgIWltYWdl
LT53aWR0aCB8fCAhaW1hZ2UtPmhlaWdodCkKKwkJcmV0dXJuOworCisJLyogQ2FsY3VsYXRl
IG1heGltdW0gYWRkcmVzc2FibGUgY29vcmRpbmF0ZXMgYmFzZWQgb24gdmlydHVhbCByZXNv
bHV0aW9uIGFuZCBidWZmZXIgc2l6ZSAqLworCW1heF94ID0gcC0+dmFyLnhyZXNfdmlydHVh
bDsKKwltYXhfeSA9IHAtPnZhci55cmVzX3ZpcnR1YWw7CisJCisJLyogQWxzbyBjaGVjayBh
Z2FpbnN0IGFjdHVhbCBidWZmZXIgc2l6ZSB0byBwcmV2ZW50IHZtYWxsb2Mgb3ZlcmZsb3cg
Ki8KKwl7CisJCXVuc2lnbmVkIGxvbmcgZWZmZWN0aXZlX3dpZHRoX2J5dGVzOworCQl1MzIg
cmlnaHRfZWRnZSA9IGltYWdlLT5keCArIGltYWdlLT53aWR0aDsKKworCQlpZiAocmlnaHRf
ZWRnZSA8IGltYWdlLT5keCkKKwkJCXJpZ2h0X2VkZ2UgPSBtYXhfeDsKKwkJZWxzZQorCQkJ
cmlnaHRfZWRnZSA9IG1pbihyaWdodF9lZGdlLCBtYXhfeCk7CisKKwkJZWZmZWN0aXZlX3dp
ZHRoX2J5dGVzID0gKHVuc2lnbmVkIGxvbmcpcmlnaHRfZWRnZSAqIGJwcDsKKwkJZWZmZWN0
aXZlX3dpZHRoX2J5dGVzID0gKGVmZmVjdGl2ZV93aWR0aF9ieXRlcyArIDcpIC8gODsKKwor
CQlpZiAoZWZmZWN0aXZlX3dpZHRoX2J5dGVzID4gcC0+c2NyZWVuX3NpemUpIHsKKwkJCW1h
eF95ID0gMDsKKwkJfSBlbHNlIGlmIChwLT5maXgubGluZV9sZW5ndGgpIHsKKwkJCXUzMiBt
YXhfbGluZXMgPSAocC0+c2NyZWVuX3NpemUgLSBlZmZlY3RpdmVfd2lkdGhfYnl0ZXMpIC8K
KwkJCQkJcC0+Zml4LmxpbmVfbGVuZ3RoICsgMTsKKwkJCWlmIChtYXhfbGluZXMgPCBtYXhf
eSkKKwkJCQltYXhfeSA9IG1heF9saW5lczsKKwkJfQorCX0KKworCS8qIElmIGltYWdlIGlz
IGNvbXBsZXRlbHkgb3V0c2lkZSBib3VuZHMsIHNraXAgaXQgKi8KKwlpZiAoaW1hZ2UtPmR4
ID49IG1heF94IHx8IGltYWdlLT5keSA+PSBtYXhfeSkKKwkJcmV0dXJuOworCisJLyogQ3Jl
YXRlIGNsaXBwZWQgaW1hZ2UgLSBjbGlwIHRvIHZpcnR1YWwgcmVzb2x1dGlvbiBib3VuZHMg
Ki8KKwljbGlwcGVkX2ltYWdlID0gKmltYWdlOworCQorCS8qIENsaXAgd2lkdGggaWYgaXQg
ZXh0ZW5kcyBiZXlvbmQgcmlnaHQgZWRnZSAqLworCWlmIChjbGlwcGVkX2ltYWdlLmR4ICsg
Y2xpcHBlZF9pbWFnZS53aWR0aCA+IG1heF94KSB7CisJCWlmIChjbGlwcGVkX2ltYWdlLmR4
IDwgbWF4X3gpCisJCQljbGlwcGVkX2ltYWdlLndpZHRoID0gbWF4X3ggLSBjbGlwcGVkX2lt
YWdlLmR4OworCQllbHNlCisJCQlyZXR1cm47IC8qIGNvbXBsZXRlbHkgb3V0c2lkZSAqLwor
CX0KKwkKKwkvKiBDbGlwIGhlaWdodCBpZiBpdCBleHRlbmRzIGJleW9uZCBib3R0b20gZWRn
ZSAqLworCWlmIChjbGlwcGVkX2ltYWdlLmR5ICsgY2xpcHBlZF9pbWFnZS5oZWlnaHQgPiBt
YXhfeSkgeworCQlpZiAoY2xpcHBlZF9pbWFnZS5keSA8IG1heF95KQorCQkJY2xpcHBlZF9p
bWFnZS5oZWlnaHQgPSBtYXhfeSAtIGNsaXBwZWRfaW1hZ2UuZHk7CisJCWVsc2UKKwkJCXJl
dHVybjsgLyogY29tcGxldGVseSBvdXRzaWRlICovCisJfQogCi0JZmJfYWRkcmVzc19mb3J3
YXJkKCZkc3QsIGltYWdlLT5keSAqIGJpdHNfcGVyX2xpbmUgKyBpbWFnZS0+ZHggKiBicHAp
OworCWZiX2FkZHJlc3NfZm9yd2FyZCgmZHN0LCBjbGlwcGVkX2ltYWdlLmR5ICogYml0c19w
ZXJfbGluZSArIGNsaXBwZWRfaW1hZ2UuZHggKiBicHApOwogCi0JaWYgKGltYWdlLT5kZXB0
aCA9PSAxKQotCQlmYl9iaXRtYXBfaW1hZ2VibGl0KGltYWdlLCAmZHN0LCBiaXRzX3Blcl9s
aW5lLCBwYWxldHRlLCBicHAsIHJldmVyc2UpOworCWlmIChjbGlwcGVkX2ltYWdlLmRlcHRo
ID09IDEpCisJCWZiX2JpdG1hcF9pbWFnZWJsaXQoJmNsaXBwZWRfaW1hZ2UsICZkc3QsIGJp
dHNfcGVyX2xpbmUsIHBhbGV0dGUsIGJwcCwgcmV2ZXJzZSk7CiAJZWxzZQotCQlmYl9jb2xv
cl9pbWFnZWJsaXQoaW1hZ2UsICZkc3QsIGJpdHNfcGVyX2xpbmUsIHBhbGV0dGUsIGJwcCwg
cmV2ZXJzZSk7CisJCWZiX2NvbG9yX2ltYWdlYmxpdCgmY2xpcHBlZF9pbWFnZSwgJmRzdCwg
Yml0c19wZXJfbGluZSwgcGFsZXR0ZSwgYnBwLCByZXZlcnNlKTsKIH0KLS0gCjIuMzQuMQoK


--------------ByzKerrVfgv0yworCRMeTYyF--
