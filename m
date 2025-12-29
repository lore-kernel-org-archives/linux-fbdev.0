Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110F5194A76
	for <linux-fbdev@vger.kernel.org>; Mon, 29 Dec 2025 01:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766970561; cv=none; b=LVvn1Q89b9NvCIhutkXO2XnyqgyVI0Ra17TugWzvqvo5ec6uCn6SaaxJcC7LHIobAiiGx0QXxRCzPsPdny2BWbvT4Aw8XgxeLwZmmx+/Zm8hZEFFNKpu7Ke6VK8jYv0unPIu0DmfXcBz8FFmFaX8qyae/gHkYnyIchFiDqxruIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766970561; c=relaxed/simple;
	bh=rrpllWC8bDC5bI71gounAjuzzkVcsC0COvFxACH4G8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QmcFZhiE8dtH4TykpKhu7RacOAUlVqoaGCMSswUhygk4zOKdt4SbS/huegbobM83hYSEDPpFHVwJ68JzcTkGkcnZw4hBpUTfM5hKVOKpXJO/nsCy4J9bq2QW9u2A73LsT3UkdRbTCpEuOnfu8ggX0P5Xk7YffnnAv0bPBWHotbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wuoh88KJ; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wuoh88KJ"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso34920425e9.2
        for <linux-fbdev@vger.kernel.org>; Sun, 28 Dec 2025 17:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766970558; x=1767575358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5dW38RDm9ae1+68aq0l8C8yBQB4OMEKFfYFCgP2bm/4=;
        b=Wuoh88KJK9S0jYESmGvc5KQ4S1w6KOey24Dkdc2hpvPDGMdGCcFkAaxv9j4I8F1zuN
         s9lkfsbXRBbXPYhyAbx73r9BlT75nMTw3O4+GeQy9sRr02BAJVQdh0+8mPJ2z510dXOB
         CszyvyVFhDQP4N/qAqtg3B4FTZvxScV5a0pk4O1GNcYbfLTUDIHf4kRK4GfedzCtcP3C
         KTo7pP/Ty29vhQMgocGRMDJx+bh24y6KpaFNkyxBUtdBBpfdaTt3Hf7FBTACULKkbz/C
         z7g0bGaI1dC0Pxp263WxYRBtL9H+66pxfHFG0W4QCEF0H0SfLshvmrCrGc3gJ4SkjZku
         km0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766970558; x=1767575358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dW38RDm9ae1+68aq0l8C8yBQB4OMEKFfYFCgP2bm/4=;
        b=mM/lYkmnLnzkyGsrqjgki89azei1EqK1teGv463R23IME74Gp8aIFBAk1NvxElYpoq
         m5ghtWnP3+9rXs0Y421SZ6/LehqJ1tdnK0lVvPmt9uCtZokQYmYBk1mL7AFKbkCaDk8f
         g6dijM6Xh+KaIM19QO93OCL1mMmMNE0eEp2+xtx2dP8OHSLKpybG/wLkMLhfG4OM1b3l
         gR5GGGyts13J57E4fJZjuJ+uJU6V019h2tB2sB9fstRLxq2XNP/sD5p1dRWUnj1VilrE
         EfbQ/Gvtd2w/RYu/CSdl2Z3xYLDvt1dDwPnp0O7RZEBqUzc2uqRpZnKHxGfNJ13x0XyR
         TAPA==
X-Forwarded-Encrypted: i=1; AJvYcCV0YA1Pzg5GzqTo8eymxOhJ2tAjKzdl72NsF5yIXjNaupD7HXsOP5ayAH1m01cH3/BOscPaq/dprj/Q6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt5ZE5R3vIiTMvjR4ForqCrx/zivoyTZDdbw3ZTdVXl2K5t1ZR
	t9KsBbnnx9eF13svm1gzFEW+1jidmNCgeUHrIyg+3nl29vytpC2xylW9
X-Gm-Gg: AY/fxX4iWNauduGETCE0joUGL9ZyeSQ25B8/ULb2LZmamBVUQkQJSHDDZfwU2yYfoWL
	MRmkIMUR+YKyGwh46jhv0GE1zGxMjxfbSujWxZXMMumHQC3rvQ2lBgITzuJyko3j77i+8DzL+Tr
	Q+Zx+8wbUWMlbeGYPNATjeKd3nmDPv2QEs+TV+E2RxaTHSS74wtt6C+tT35O9iKPiKCWDZAzG+j
	DJNcqDjz6FPkq7ru2BUdW7VA86Z7j31ouppHnxJMb7OAkriwz6qvzATP0+QUXe4HAPF7Hu8+9pU
	OZdGC9/jpFHpYAabgBzTs6ZcVCKlgRd7NUruNQGkrwyf6fhnOtkXJRDUrZst+iPd80Kv6Dbng1A
	wCzvdn5wgqNpqGYE2cg3GVhgcnWJ1n1QH1ZN7QNPx+r/mSuFPpIHmVa/qAW159La4e9hqd0/I8d
	GVeKAgEo48B6XjR+6KB+SCbhQhvzekCozVc09xCsUQFa4=
X-Google-Smtp-Source: AGHT+IHV4ZJMK7bXEGIcq0XJLLZ0z9mzC37KodrTHfctPm6PYkmg1Ku66Axj7NdKa2uj5K/YYl8V6Q==
X-Received: by 2002:a05:600c:1991:b0:477:7a78:3016 with SMTP id 5b1f17b1804b1-47d1953318bmr316061175e9.8.1766970558082;
        Sun, 28 Dec 2025 17:09:18 -0800 (PST)
Received: from alex-ubuntu.. (88-127-35-143.subs.proxad.net. [88.127.35.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be2723b2bsm566557265e9.3.2025.12.28.17.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 17:09:17 -0800 (PST)
From: Alexandru Costin <spxxky.dev@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alexandru Costin <spxxky.dev@gmail.com>
Subject: [PATCH] Replace udelay() with usleep_range() in PLL initialization code. According to Documentation/timers/timers-howto.rst, usleep_range() is preferred for delays "10us - 20ms"
Date: Mon, 29 Dec 2025 02:08:14 +0100
Message-ID: <20251229010814.94255-1-spxxky.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resolves checkpatch warnings:
  WARNING: usleep_range is preferred over udelay

Signed-off-by: Alexandru Costin <spxxky.dev@gmail.com>
---
 drivers/staging/fbtft/fb_ra8875.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 0ab1de6647d0..130150b0f07f 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -210,7 +210,8 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 	}
 	len--;
 
-	udelay(100);
+	usleep_range(100, 120);
+
 
 	if (len) {
 		buf = (u8 *)par->buf;
@@ -231,7 +232,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 
 	/* restore user spi-speed */
 	par->fbtftops.write = fbtft_write_spi;
-	udelay(100);
+	usleep_range(100, 120);
 }
 
 static int write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
-- 
2.43.0

