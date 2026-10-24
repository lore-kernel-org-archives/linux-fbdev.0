Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792855945;
	b=1D7orclQKv1CeawCwc0Ue7l2N3H2n/0fgk8m/qe3QBAHc5aJkZb26KdVb8TwjBxjR704
	 W7ges1YUnC6b3MDcnGVM6NWfA138RmsxjHtZJSwTGbopHp4nXNIUgz8WzmlT9Y1nC5bZ3
	 IL7feNsmQH8H8dpPNg9ZnNCtnBQLNbU2mPT5Pra9wbLGII7W3XjxNIVNrmXDhUvo2Yq9m
	 YLwuzBvSVaNiqbkCjQauFNoSauAmgN/0Qk8aLngIO24m20Xcw1WGpU41qkaiqxkunhx6u
	 ec6oUzHS6wb+qps5RbZy0Lje33LsToPP14KeHFmITnt1K7VAxGPM/i/o0xh2EaVwZBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792855945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=Pq5TTBQpf3VwcXoGs4pN0FqJDNE4MP0bsbNANOOcrSQ=;
	b=M2ykzumVv8u2x/z6K9DIvAIhfRcFZqiPOm+t1nEsHPbgFvMYNWf2NbBtmnn4uTED8A3s
	 6X6/JC2QBPWOKMzchg7K4t0S1PdIUbiObsLhOA32IIYpzxEEy1D09z+OD34LnjvN3PFhX
	 Q1dcE3/Jdt1zv7/mTXazuXlM7w+uSKNi0eLeZ+UfW2/2foyXHlUlD34lQomlFU8CGMigr
	 FTRdKHHC3rujMIFZ2NBTLGg6N8jqJoa/+/OMpzYT62Q3Hid5wvCYE/Re7nV24ey8VBOan
	 zoAEXR/4134tbYWtyYcQBeq6fjM0xTAz911P4dq8Hz7MYPpev03UShq/XutfuECQ2yg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SApMvrWE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B02606A31F
	for <linux-fbdev@vger.kernel.org>; Sat, 24 Oct 2026 15:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44B02606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SApMvrWE
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b1aa377c61so2173663a12.3
        for <linux-fbdev@vger.kernel.org>; Sat, 24 Oct 2026 08:32:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792855943; cv=none;
        d=google.com; s=arc-20260327;
        b=D3iMAjFhZgfIFocVX5otLCJanwVqmgE/hHshdcfyRr/eUESj4pF/RWuDW0wQvz9bnu
         qXb0qXMbYPHO1C20XhdOjsHlXCbnbAZWZdGD9yqR0nKsiH8pKrxEXftM1Aq/rprwmdKf
         V9v/BRlQi7IurTmAIfztXwsXgEVOWjp3twNeJCBJ3dPlKlPvyj8rNVXEDuNfoR8jvbby
         DzHYCSYRAl95YGQuGYCiLpAv+Yf7+dxeuVZCio0jIYZ61PrBLtxjrdgSuUAnV40UNDhq
         vYCvGOY9hNgxjc+V9iqjBZojMAvULS10B3mfThkN4L2hwegf0/4LRWZNytW8odjIUFwy
         azEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Pq5TTBQpf3VwcXoGs4pN0FqJDNE4MP0bsbNANOOcrSQ=;
        fh=Z3UtipSTah2eb9mLvoft6ubnOeINF3z3MJgWFRDs2q8=;
        b=QzaNs9nHD99wFcviodWJSjAWhe02huNMQmu3uyQxPmH3XSN5RvsN08WRQith1SlyBA
         4ZnRVknQfgOpPPGt81uxmOifIQiC05TLCZXEG5iIlBFTibd2Jxn2nseYpyWpugEpccuR
         RuaU+fwR66nv8OkOAhIn4Pg2AT2xZoAox21sP62PmN0jHyWcTbqOAJIfLXBnNoLfdyF0
         EjQRUhd0Us1Zg1uJ+PH7aLCTbI+Aj904W6EhKOTFTAyUaZObsvJAUO2VEl7I1hdrqil6
         YbzDlzv8Qp/OvRIAeJZXNjHQ2fbviUUtPsgDby2ozjGre8PZkm3kYuIhOXc+0uIJ92Xz
         e9JA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792855943; x=1793460743; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pq5TTBQpf3VwcXoGs4pN0FqJDNE4MP0bsbNANOOcrSQ=;
        b=SApMvrWEOo3SbIVhYSlC5ZBmjy79BCQcbqY+FZ9miSU2+CubFE5QcwgEpZrMr1U7os
         qCjYKzBzWjYEwzhhEhx6ADi1e9TWOk/iGe1Te+X2MkEFB1NK3merWE5ak4z6Ph7t/zZW
         lKyv1VR1rr6R+cq1yzBym8JQtNd+ALXf/KoFpRaOgYXU1QvsXX88aBsiCU11imeYYtEn
         aDvx4pHB013MW9tyzwNUIcvKjZpwk5Z0SuE9dcCGAreI/1hwtGOAAunx2H+wsykp+EpL
         JM8NZnZqQX9E2FgeBmUBZ4tACHydDKcGsBnssEj8AvECA8DdssS3ElyUETrKAvpt1qcK
         /yZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792855943; x=1793460743;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Pq5TTBQpf3VwcXoGs4pN0FqJDNE4MP0bsbNANOOcrSQ=;
        b=TOXSE2rLW0qYQ+h5VmwUveutuXLCRvdn0+cRyJzehA0ZW7OL0eqNIfzbo1q+Mppyfw
         lVgUizNTOBtj380HUPxlAuHVwYeo0003tj1qPXo7I4xuu08m798rz+rm3MwURrnmv8MM
         xlvH6kMe5856KHIkq2af5lrWvrrfBT9lQ28dB44i7qbIE4n9oYR1LiCGwrlM9Gg2XV+d
         5r/MsiQsk+XlyT0FjcYOyJEVGwNR0bMBnR1OVC9W3vQEuDLrM7JGUmqbE51D0XsCsmth
         hol54VUfKCAAItdY1wAagjX6y2gOihyX3got+5/wXQqadejZhT2DMaCS+/h+Tkg6CIxx
         AiAQ==
X-Forwarded-Encrypted: i=1; AKwUvBwdfuQ5SZQh/dUGIq4cbQIzVksPxhoFoRBzAlM33P6O3QzFgL4nGzKslpXJnB2U38SSeumHaVTwa5TEcw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIG4loNOYi2Nc5olAwWM/rQ7I/d9dk527qgtzvDi41L9Z/LdPdM
	5xGGw9koeWRlsguYXVCycQgxCrP47zNTfL0ZSaxnjLJVUEJZMAlNNJ7PX0QWOaOj60mzQ1chKmD
	GvCwdecwabidmbPoErw1n2/yumU06m8ljVx1824n52BUN
X-Gm-Gg: AYBFou3D9VUtsI+pQJs/Tc5hEiz47UHlm/fKD39oi+VFnYg7JMqpUwUj+DT/hT4N+Vn
	wiJrUGdgorRHs6rrg658DFygjwq9E2K5adIU1Ok8cW4W3qcBr1kA9zGC9pCAXKz4XQ3kzfvoYxR
	IfcoannXUMhSJ7cqC5fBhljkDQ6qXQiMsvhsNFp20KtNdsxI04MX5dZWzhvejzLPdZJrrp4PswO
	o48lgphN5FdfutK9AfiDVoPLuVY+g1p48DxZGDy5pdmU5UeK6iAGv3ePkDYLfmppGPEeSv8mEzq
	saSPVUloO4wPCsUOH2SnwCF0NFO9KctUroimrz21RFk/mp7bFFjIcBYJitf4rfzfNpcPmb8WHCA
	kfHYHu4io3e0E3SsvYiDTlWG2rqcE9jUEWZGUlWrGxOoWvxF1TTXOdS5xIvUGUtzN8oO1/ToEDo
	ggXdhk6aYlr4Kc4eQ=
X-Received: by 2002:a17:907:930a:b0:c40:4965:72cb with SMTP id
 a640c23a62f3a-c46bde1c9acmr252909566b.21.1792855943476; Sat, 24 Oct 2026
 08:32:23 -0700 (PDT)
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
Date: Sat, 24 Oct 2026 16:32:11 +0100
X-Gm-Features: AclHuK9TU3AwsoiPULkfHVkczTh8p5LJGwDjkZKuc4re9S6dugKLiYK4K0vrngU
Message-ID: <CAHxSwT8=ZA2sFqXNjfX2=Bf369+gNRLfCO+VtVmmWiTzenLwWQ@mail.gmail.com>
Subject: staging: fbtft: fb_upd161704: Replace udelay() with usleep_range()
To: andy@kernel.org, gregkh@linuxfoundation.org, outreachy@lists.linux.dev
Cc: linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a53d1b065e97cd84"

--000000000000a53d1b065e97cd84
Content-Type: text/plain; charset="UTF-8"

Hi Andy and Greg,

Please find attached the patch that replaces non-atomic udelay()
instances with appropriate usleep_range() bounds in
drivers/staging/fbtft/fb_upd161704.c.

Thanks,

Abubakar Musa Samaila

--000000000000a53d1b065e97cd84
Content-Type: application/octet-stream; 
	name="0001-staging-fbtft-fb_upd161704-Replace-udelay-with-uslee.patch"
Content-Disposition: attachment; 
	filename="0001-staging-fbtft-fb_upd161704-Replace-udelay-with-uslee.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mvmk3skb0>
X-Attachment-Id: f_mvmk3skb0

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
--000000000000a53d1b065e97cd84--
