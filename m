Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18EE33A9F9
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Jan 2026 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768466429; cv=none; b=j5k+939FYX1H8l0DEMLsNqtCPDOlxcmB5I3kpS6jcuyL9UBZ0NKmsvAX0ZP6i+MZNzN77+R7ky7qgEh3PgHXMCSkJO1WwQyhsUiCBe/F9mBHZE5xSbReQwEx5cnoJH0rAuLN3gB1jvKZG9sCpMtXNfNzTr1TH4pXO7BgxKBx9XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768466429; c=relaxed/simple;
	bh=0EgDX+r5PytoX9rVJtv3VrAnml+PdC7UzVBE2aqT0mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T/HAzXOrINakqtmift8EVR04jHVBhEO6FdYUU5rdG3wSHtOZ5ovEjwZwEe7jiU7HJckrjksSChFr0PQT6jM4iV/G1YxzbsBHXTCSH4F0uYn2oGB3nMfMh4GXceXmcwEexyQb4SKN9RvP5hjs1QPif44mZ7cj8JLYMxU4MYjb0Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kz+kroUJ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kz+kroUJ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29f1bc40b35so7215965ad.2
        for <linux-fbdev@vger.kernel.org>; Thu, 15 Jan 2026 00:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768466427; x=1769071227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ipcJNOqF/EGIzTmaYen1uoPiKEHplQV3qlrZeOj+LXI=;
        b=kz+kroUJ74A2tpGcJGkus6ZLQ+NQZOf/Tfd+Nrum2iSP06IjiEG02isH1usHs2/jjP
         GB/r4RqXXOEAytqJGfduXsg2ri1Gnli+hvkiCr3yM9Ev94xFqPjk87c91WZ40c1Tya2S
         tw4v68yR9DvG1ZnkNZyBeWKAQYVtOuefqZI3SgUwPoDYDbj9MFd+pVoIJCnlS2Sktp47
         Tq3Xua5PC0f8MuWnkeXm/VaU5Ny6Fl8Bsr1scgOogWZO8oE46d5ClcN1cE1ixpaDWBMd
         N6HqjW7qvY0Y+tAllfHdQ7Mry2zskjyrI6cHKcn7LZt7DR4dDcDiZ5cHN4BVxpwAFT3R
         buiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466427; x=1769071227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipcJNOqF/EGIzTmaYen1uoPiKEHplQV3qlrZeOj+LXI=;
        b=ZO/iteZeD8PyfH478oTfx6zTRRjY/VYWZYvF2pskgpIPqfptuu9lyitPWYY1T8gWrY
         ZY9pyDVLk4B4c/cJysrFs7DnnzdnTCG3OFpNttnZEdodzhLTkIfTrYtRq9QyO1P9KV+V
         upL/IZX+hk/XK6E6C3P+5sZLG1xqtINoRfUZM6CosyFej5Te0gTC1m5Iv8kkFnqEKzJA
         GiPFwmV+mQuAy6984cCKZ8+aVUfL7HRf5MbBMYN6zOXIW2DShZfV3osrsyzJDAlZxsnL
         9BE8VpjlbcO3fsY+uvvU1bkrSh54rDiMzF4sb4Oj30gQ2rNUooDtcEqQ1SoryoQUuAZX
         uRyA==
X-Forwarded-Encrypted: i=1; AJvYcCVGQNEQGLvvNHmm1VXr4kia4g9c7JOfViJg7VUk/K5sQSFKvLyTOOguG5XWxqiuM9FQM6yQhS6C9IFwWg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0WeQygERXO4ktEVgRsuYHWq7MyE7ki0tZrcY0Pg24dyJ3+opv
	VfiP8iQmrZcdBQFHVdXHxw6cziXKBaf95mBz6L3dk19UXcpITL+kzswN
X-Gm-Gg: AY/fxX72X6rzKaC3Z1BS20ypbS+hx2yILRvz6IvM3DRGN9aocsCCg+YXKO+/pE8sI+K
	dsI1Gl6SpKb/LWG5Pq25k4KvWn0pAZ5uSGH5G2cO+nxz4KLynK1CkTrTIffG+RhSwcCDDolWjMs
	zVZPSW1kG30gNwASdiHW5LUtOTqqY31TRjMBOeG7+kAmo4XQhKHjWnjCYyf+hzxg/cjiB2o9b6b
	O65ymMtWzjq55WPUaMRXpODcj2B2s2jzR46+Buh/o0HU4ROj3WIMTg2FF/prM3jXl7ri3ifLoK3
	N1H6pnaflJCiZy8soCajGKVhiQxz8AN3dpHNR01JvQKCGyUDq/hzSg/hdaK3KuoVovX44yvPQnf
	SAXaf7145tTYFoZbm27UolbqfSClGJ2Fdky5Eaqsx0wFNBkk62LAwfMH7MfV9jyUE+1UvBxDxoJ
	9+s9rZLaQOF2W8QzgD/FuoCsQEZTAj2+OWoBBNGk5Lo4af4A+zog==
X-Received: by 2002:a17:902:ef44:b0:2a0:9ecc:694a with SMTP id d9443c01a7336-2a599e34930mr57586385ad.37.1768466426977;
        Thu, 15 Jan 2026 00:40:26 -0800 (PST)
Received: from jeonwooyoung-HP-Laptop-15-fc0xxx.. ([121.125.189.206])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c48be5sm248390095ad.30.2026.01.15.00.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:40:26 -0800 (PST)
From: WooYoung Jeon <chococookieman1@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	WooYoung Jeon <chococookieman1@gmail.com>
Subject: [PATCH] staging: fbtft: replace udelay with usleep_range
Date: Thu, 15 Jan 2026 17:40:19 +0900
Message-ID: <20260115084019.28574-1-chococookieman1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the fb_ra8875 driver, udelay(100) is used for delay which
causes busy-waiting. Replacing it with usleep_range(100, 120)
allows the CPU to sleep during the delay, improving system
resource efficiency.

This change was suggested by checkpatch.pl.

Signed-off-by: WooYoung Jeon <chococookieman1@gmail.com>
---
 drivers/staging/fbtft/fb_ra8875.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 0ab1de664..92c9e4e03 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -210,7 +210,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 	}
 	len--;
 
-	udelay(100);
+	usleep_range(100, 120);
 
 	if (len) {
 		buf = (u8 *)par->buf;
-- 
2.43.0

