Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B064D2FFF8F
	for <linux-fbdev@vger.kernel.org>; Sat, 18 Jul 2026 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784399019; cv=none; b=eBlxrIHjzZqC5N38N4CNjviLO16pX04a4b2Ncb2M8ui+BNlNNNeoei2H1yZLYeTuFP2xdYk3VWWtLPYVvXA40v2jFnZWZQeWPr2s8iKjP3AAuFkbahz4YCj2ph0mX+2zqXPohE2lc6t1uZ3RM78jFCl7ZMN4i07P1VlMLkDVl+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784399019; c=relaxed/simple;
	bh=tgqxdQE/XO2OskQNWT7Hv3Jrb9yWSUauRxFhYp/Q6Lw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject; b=nj0LVt1rEOe2KbTSnmV5itYxV0tLys9uGRh+jL4LE6DsjJQzmadBZf3z64OE9C63hAEBb643Ic1uXObBsXXI5uFY9Vbs5Jsg5HuzYOL4z7VjCvJMrxj7lvgEumfjsz8CTRlKDPXfbC1QF/WtaUYCZzniTwQ5jcUcbuXn9WNmr5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sA4k5cwB; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sA4k5cwB"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-37f9e2642deso859420a91.1
        for <linux-fbdev@vger.kernel.org>; Sat, 18 Jul 2026 11:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784399016; x=1785003816; darn=vger.kernel.org;
        h=subject:cc:to:from:mime-version:content-type:date:message-id:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5bmlimQrWEZJP9wXnBlZyV/J+SO0CL4FeYe6T+B47Hc=;
        b=sA4k5cwBDYATRAtaRtx9y/QcEDHitnIvSiBgFabiEBcExX0ZqwMu1VNfQ9WLJz3ADZ
         WTPJcNyIb8GWUIFHsATxsGw7ez9aNkQHWmTDguo8tXBv8v4g0Y4fbCf0PZpM3B7UAmsO
         JqEmHK6XG6m7D9WE132Hce4ITSswWkUX4nrHX/DYOHdyUttaE/F8+hYhWB99SgJIpGSk
         WdLV57EyQHlk1fw7kogIGiByPiQmxn49tQnEm9jqLcrnJohksY8Qk97NWNHlpN2Q2P1J
         gp2zAp9jQw28udDx/GCD2IoIl8iJPsl/hnshwma69fpR72HVBVUtySGVBm05Sd1b4stq
         7hYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784399016; x=1785003816;
        h=subject:cc:to:from:mime-version:content-type:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5bmlimQrWEZJP9wXnBlZyV/J+SO0CL4FeYe6T+B47Hc=;
        b=SiONC1mPlr/OUsK1vcFxbzysNKXrZCfud5EX9uvi1/J7MyxdEnkkCfI4Xlh8SdmQLZ
         zPKQ7v5ogQhqtb6PHYzRA2d4iZI4W/KVWgHRCh2a1Gz2oNFzKj+HUxsztUdQHYO3hgcW
         /fBp3qDRsgJvUdk8kKviZft39SWFgLi3Mvidvf6IIFrkULTtQ6aK3kxu+t1y/sL+BnqZ
         FkVGe1cHC2JIvj3JqEBZDy0QlurXNoc3z0WzbmeFfS5bbAm7p5zCKGrWxdzC0CzFBV2h
         dLdiT6dKqdM8M9i3kCIQHNMxUlSOehhksLvFZ7zVfy6DBHACIRGKzXhgBvhrduGFI9Bl
         TvPw==
X-Forwarded-Encrypted: i=1; AHgh+RoRAKka/3XKG7SE+2HjjrhrE/NdrJNKyq/FCxDpOSro81Yo8xQlZh2Y8wkwdCwy6QHvUfOeReW7Bgoo4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpVoL4TnLE1svSMmh1QtiaPckOuJVEq5YFyMk/y7KwgQRGv734
	T48ZODJJGtwtEOhvV88pJfEXCaQUzb21PjAqLmeEYc+BbzkNkz0qXMPs
X-Gm-Gg: AfdE7cmtjoiUjrQ7AycqssIfh36ygt0d/SXInxfFd+3FwOM/s+iOjyLx5qX11M4VxlB
	SM+OVM+zy1xZGSaiho0S3pJRxiSSPLqm0mo78bRVlzZcHPpEHVreKRnIx/MN3T2YNY3Pmxa5CbT
	m0D+PN2ND7SNGcJYRlNKOlW9KvDZNzIB05jwydYlSO5hDCwxQbJ3w6ZGiVB52a6L+5ztEsSJvAB
	7Tj7EzOO9KGoLEbxU+PJMhjnweNTdJyNDPcZ9f6688LFee0be7ubQzloZ+tfJYyGli6eTjfRohZ
	k5R0dxtJbxDlWmsdXPyPhJdffth6Nj0HRfctN9/dTC7RLFDQxI5Y9QPkCC8LMxZn2BwiIsTRC8G
	fZtKMlVARk4jl0wixcdu4WvAANvhFs35qfQgiV5ceym6NEd9BNsjYodndCmN/aee7R0QopAhiBO
	JpWpeliePu6jCuPv10LKyNFXKS
X-Received: by 2002:a17:90b:53c3:b0:38d:90c1:2485 with SMTP id 98e67ed59e1d1-38e4b5d6aebmr6068293a91.5.1784399015906;
        Sat, 18 Jul 2026 11:23:35 -0700 (PDT)
Received: from Potato.localdomain ([171.76.83.76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bbda9sm19113650eec.19.2026.07.18.11.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 11:23:35 -0700 (PDT)
Message-ID: <6a5bc4a7.f1c1923d.2d2b59.05d9@mx.google.com>
Date: Sat, 18 Jul 2026 11:23:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5043740731053490976=="
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shivesh <chanelshivesh@gmail.com>
To: andy@kernel.org, gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: fix checkpatch errors in fbtft-bus.c

--===============5043740731053490976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

From 7e9684b26176644bc92c2285acc7444f3f7ddb4d Mon Sep 17 00:00:00 2001
From: Shivesh <chanelshivesh@gmail.com>
Date: Sat, 18 Jul 2026 18:08:04 +0000
Subject: [PATCH] staging: fbtft: fix checkpatch errors in fbtft-bus.c

Fix space-related checkpatch errors in macro invocations. When the
modifier argument is empty, remove the trailing comma to avoid
'space required after comma' and 'space prohibited before close
parenthesis' conflicting errors.

Signed-off-by: Shivesh <chanelshivesh@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff19e4..409770891c54 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.53.0


--===============5043740731053490976==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-staging-fbtft-fix-checkpatch-errors-in-fbtft-bus.c.patch"

RnJvbSA3ZTk2ODRiMjYxNzY2NDRiYzkyYzIyODVhY2M3NDQ0ZjNmN2RkYjRkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaGl2ZXNoIDxjaGFuZWxzaGl2ZXNoQGdtYWlsLmNvbT4KRGF0
ZTogU2F0LCAxOCBKdWwgMjAyNiAxODowODowNCArMDAwMApTdWJqZWN0OiBbUEFUQ0hdIHN0YWdp
bmc6IGZidGZ0OiBmaXggY2hlY2twYXRjaCBlcnJvcnMgaW4gZmJ0ZnQtYnVzLmMKCkZpeCBzcGFj
ZS1yZWxhdGVkIGNoZWNrcGF0Y2ggZXJyb3JzIGluIG1hY3JvIGludm9jYXRpb25zLiBXaGVuIHRo
ZQptb2RpZmllciBhcmd1bWVudCBpcyBlbXB0eSwgcmVtb3ZlIHRoZSB0cmFpbGluZyBjb21tYSB0
byBhdm9pZAonc3BhY2UgcmVxdWlyZWQgYWZ0ZXIgY29tbWEnIGFuZCAnc3BhY2UgcHJvaGliaXRl
ZCBiZWZvcmUgY2xvc2UKcGFyZW50aGVzaXMnIGNvbmZsaWN0aW5nIGVycm9ycy4KClNpZ25lZC1v
ZmYtYnk6IFNoaXZlc2ggPGNoYW5lbHNoaXZlc2hAZ21haWwuY29tPgotLS0KIGRyaXZlcnMvc3Rh
Z2luZy9mYnRmdC9mYnRmdC1idXMuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvZmJ0
ZnQvZmJ0ZnQtYnVzLmMgYi9kcml2ZXJzL3N0YWdpbmcvZmJ0ZnQvZmJ0ZnQtYnVzLmMKaW5kZXgg
MzBlNDM2ZmYxOWU0Li40MDk3NzA4OTFjNTQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc3RhZ2luZy9m
YnRmdC9mYnRmdC1idXMuYworKysgYi9kcml2ZXJzL3N0YWdpbmcvZmJ0ZnQvZmJ0ZnQtYnVzLmMK
QEAgLTYyLDkgKzYyLDkgQEAgb3V0OgkJCQkJCQkJCSAgICAgIFwKIH0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFwKIEVYUE9SVF9TWU1CT0woZnVuYyk7CiAKLWRlZmluZV9mYnRmdF93cml0ZV9yZWcoZmJ0
ZnRfd3JpdGVfcmVnOF9idXM4LCB1OCwgdTgsICkKK2RlZmluZV9mYnRmdF93cml0ZV9yZWcoZmJ0
ZnRfd3JpdGVfcmVnOF9idXM4LCB1OCwgdTgpCiBkZWZpbmVfZmJ0ZnRfd3JpdGVfcmVnKGZidGZ0
X3dyaXRlX3JlZzE2X2J1czgsIF9fYmUxNiwgdTE2LCBjcHVfdG9fYmUxNikKLWRlZmluZV9mYnRm
dF93cml0ZV9yZWcoZmJ0ZnRfd3JpdGVfcmVnMTZfYnVzMTYsIHUxNiwgdTE2LCApCitkZWZpbmVf
ZmJ0ZnRfd3JpdGVfcmVnKGZidGZ0X3dyaXRlX3JlZzE2X2J1czE2LCB1MTYsIHUxNikKIAogdm9p
ZCBmYnRmdF93cml0ZV9yZWc4X2J1czkoc3RydWN0IGZidGZ0X3BhciAqcGFyLCBpbnQgbGVuLCAu
Li4pCiB7Ci0tIAoyLjUzLjAKCg==

--===============5043740731053490976==--
