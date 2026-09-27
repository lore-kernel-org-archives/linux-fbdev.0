Received: from mail-lr2-f34.google.com (mail-lr2-f34.google.com [74.125.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7572DA74C
	for <linux-fbdev@vger.kernel.org>; Sun, 27 Sep 2026 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790502532; cv=pass; b=jLA5PVe6QaHdVZSmnPbge0rbD6gNAlUeZLp+KlKbQx0rH6BO83BhvpTxvDKmx9II/RVNo9aBn9i0oCFMgQfU5OMGcbgUkLKTwkRjFh+LMiYJCUS0LuWgnkKG5oQHHpcgqGP6Sf7z28khgdEaaq/ZE2Agmd1rnsmuOKpidWRXkdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790502532; c=relaxed/simple;
	bh=VbNaCBv97oG90I5mvgMS936SO9aqYeDUwCKNKwEYwwA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OHNo4EqM7XylYfrnUFeprMVP81ajCW//xSKQJD6QZRi/sXEm/KWVmoWmnCzlMLbogaG7yECtu2AcucO+8oS7RdaX+Sf2YRzeL2dBM4V2CVD3ZbujHVNSsiPygCQXsz8qDPfgOh/2b99te5jkbQlONQOyDUpZ3MIjidrXxVVRNL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hj5+aITT; arc=pass smtp.client-ip=74.125.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hj5+aITT"
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a651f928d9so13660941fa.0
        for <linux-fbdev@vger.kernel.org>; Sun, 27 Sep 2026 02:48:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790502521; cv=none;
        d=google.com; s=arc-20260327;
        b=krZW8FMfOxOqsYXqcJzztQwvp5ttn8FvHDHGSlbRlsJ8XzameX3YUG4VwJ26CpuPfY
         KWWiLDOsBgAw/1JTCCfqy2ucBPvVkQxIJZHiXFezBKWRC1NcpQrpiUTF7YKesnDg+9Tv
         PtRQ+UDL6AvXx6MSHLR3B7hre3Dmty46AIAIcsBfGdUAY/z1de9oI+o4QtfV0f1a4P/9
         HUm7b94Q5fThWDVsQugI+dzbVHbDydUTPNJQI8lbVqr5tvhY+JP+nc9gvWcysYZRE5Dv
         04YmNaGAt2Sfk5YW804iGNw1SgWP7TgO3KRA8wqgSHPwk6o/m/j/NODOKDwOd3sWf+b1
         S81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=G1OxfNq/5YdzHTbdOohSN8hvy0lgOzxPTHbFi5QdzsE=;
        fh=WXRGudabu8FU76dwSJ/SRIzB21q/t8lXsnIPoQJHN3Q=;
        b=ngkTdJmFQGt8GxYCC5j4pp2I2orbl62+nhCK7lzAjBdfKhs/2MdwftpN9GSU8CjfLe
         PY+4j54LbeidtdSRYWB7w31xqMLTZsQdugXPjGOYPMjvsh3Gzm6ki384ZcYX+pKItb3t
         +l8xiceduXTRNAWNJWDu20PsklmDYmGH2CLrxAdS7bwHI0DNJVcKeBzbnvOM+/a+6Wbx
         yjfQ7dNMvCrbcmBnCrnIs7Q4C+QLMlzAp4CweA70GNe9C3nPY2SJ3exVDp82fPalC+wq
         JHwgJhA/OnXML1PgwFj3MVgNCDivPNVdcHRS88a33sm4sfWwfNm3BIq2osQHTyQdXL5W
         SiDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790502521; x=1791107321; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G1OxfNq/5YdzHTbdOohSN8hvy0lgOzxPTHbFi5QdzsE=;
        b=hj5+aITTL5bm2S6ryzWK5C2ABDGNpvvNPgneED3F9Gn+G/ASyMD06AQcHHE9Q9QrAo
         l3Z4RJeDs5Elxpz0Z7xVWvAXlc/+oUjIQD3FZJ7ofopL7rLXgP9GAS8wSoDxwjbwvgkY
         hNzqQpfd2FFpxLuqCPRbpRQKCHHNuuKskUdWBAb6rdd+3KjkW9YVoVgEl1IpaQGL6+6+
         beQ/8qGeZ/Er5JPwGdw6oH2EEeRhrPVpix8KQukUjhXCTedkrE9GdYptTZZXbRWyuZ+Z
         NEX6kXuUHXZ4jhpeY3lRXvevbKfxs7/23hkXI7ZHzzAbUtuLYIVSwm0RXxWTdt9pbnKK
         vGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790502521; x=1791107321;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G1OxfNq/5YdzHTbdOohSN8hvy0lgOzxPTHbFi5QdzsE=;
        b=aBwKRqYiqMJBGN0E0VYweUyqpPuW2dcNYh8qafv0hWeo6DMMSN/xKnw34Gmme/VyfY
         1PnpHp38SOynLDFBRZerjJ67g7mhXYACDxlketVGCkHL/5EVT/vt2QeaqmTrA2fUqJ/K
         REqdQFcKFHLmN8jdcT8b5i/IS66DKrpGRZ1kM0ZtEyvgBh5obzlqadOPgLiXak/YNIH6
         ozf5HIoHY5brZzPuc9catMk89ab1wRFNB7awbuF9Xu8ev8cLIo6LCs6x+ANGe8txYpxm
         afWmBXuWXOtwMW8l9OPz9AsT9Zm6HuoZ+spQqKjCFeSZsp6NN3kqp20PwSU3oCrJQ/uS
         J2DA==
X-Forwarded-Encrypted: i=1; AKwUvBxvM8G6n1BqLazNRgoMAwbIrnVuZ0DxEdbD52EA+t1HB85VmJI1DKE0Oo+2Qskj8eVp+YC//YumzSWoMg==@vger.kernel.org
X-Gm-Message-State: AFq9FYL+6JWCGsjdK5auDbrOrI//6+X37v++8CvO9reWKtP+y7X5gRMF
	itlTj4P4DPb5xjmwDtz+jm+xNuCQkh9LrXFNkEQ2hiyfDpulMxcHWFaHWRghfhZPhmNbYKYsnmK
	OZ7OE8jlgMc/AUcFdNIemltGiA0URnjr8Ow==
X-Gm-Gg: AYBFou3y9eeu+UfkC2l94otP7uiznJ2PF7jc/ULVqhGwkbivSe9j53bBe4dsqZboYZr
	Ai2+WL9jjDCcAEfsCZqEwLaAAyElAJWPZojT47qN3C8YuHt2lDR6JEydOn1XfjfwAmrQv40J17I
	+spdflQqkCr2lvxnNhQ3TwM1d2HsAmnBgJDOJnLmuZ1xdi8C6xAdm2s7Q3x50X2TSu9Ub/jXxrR
	bO9jWGznemjszQ+nuFo9UgVMn0idQSUHtRA1ls06YJoUGDxnuMavJ0AljmigwnoDFsdyOGYLr/n
	77dNjTa7sqY0+mE0JPR9aaWSMhHKFWvPQ7A5TgsNXCVLsyG/xXeJv9cNni1C2dl/rgClOo+5WKh
	L6Rc/xgY3MSWA6c2QmHlNxurNK3UyHP/AWdSv8yJO60GNVxKV+LkMbws02bobz2Gm1A9qB3NIIy
	XQ
X-Received: by 2002:a2e:a812:0:b0:3a3:749e:31a1 with SMTP id
 38308e7fff4ca-3a63de5c715mr24136561fa.21.1790502520622; Sun, 27 Sep 2026
 02:48:40 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 27 Sep 2026 02:48:40 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 27 Sep 2026 02:48:40 -0700
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: krishnanand G <krishnanandgeetheswaran@gmail.com>
Date: Sun, 27 Sep 2026 02:48:40 -0700
X-Gm-Features: AclHuK8BTBfNpqz3m6BQ2iIMJxIt6xRy_BCLLwu5RAkXd_Z2NtIUajK6RkAMxFU
Message-ID: <CAG_41BL-nu7tDFjGgehz9Bf+KKPty8kR6A0RUUUfpepJu4doHQ@mail.gmail.com>
Subject: [PATCH] staging: fbtft: fix spacing in macro calls
To: andy@kernel.org
Cc: gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From 5473fd52eeda7ab1f608c414e386dad0ea40bef4 Mon Sep 17 00:00:00 2001
From: Krishnanand G <118352827+Krishnanand-G@users.noreply.github.com>
Date: Sat, 26 Sep 2026 19:41:06 +0530
Subject: [PATCH] staging: fbtft: fix spacing in macro calls

The two calls to define_fbtft_write_reg() that use the default
modifier have a space before the closing parenthesis. This triggers
two checkpatch.pl errors.

Add an inline comment for the intentionally empty modifier argument.
It satisfies the spacing check without changing the macro expansion.

Tests: scripts/checkpatch.pl --no-tree -f --terse --strict
  drivers/staging/fbtft/fbtft-bus.c
Signed-off-by: Krishnanand G <118352827+Krishnanand-G@users.noreply.github.com>
Assisted-by: LLM
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c
b/drivers/staging/fbtft/fbtft-bus.c
index 30e436f..5f320de 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);

-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, /* no modifier */)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, /* no modifier */)

 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.39.0.windows.2
