Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF06917108E
	for <linux-fbdev@vger.kernel.org>; Fri,  5 Apr 2024 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336286; cv=none; b=JzwwJx/9piea0/vRXq2irkn41gVNUY4hlPgZu9EwCCbBp0MkRivV/3ecBjrlz7picsqEf3TkBXXBGbb6e0LEs0myKt+y/pvoIvi3hd0e3ViYaKCMjd+lEKXXEZr2X9retyP+vFHu8Na2qu7hHZCiaOADam7YqFN0AHTLvANGP0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336286; c=relaxed/simple;
	bh=5AW1eKgNf7MUu4dM7zRPWY+xw2bFTvlrZtGPjFMFryk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wq/QIOCKU5fr/+KMW3UTFCzZwjEcUfTdRIRsRUY32Sa8fzWvmGNpqGqrT9hbRCxcPESpWUXiTaET91LRLHKl3eQC6ySybEJ3a5TUNQ7HGrxaUuIVNR8eiQGkcjawHyBNkklDW5lbsuylie2ZpSeeUuNl3geMXoi7JgPGl1b9nSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdGD97Az; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdGD97Az"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ecf406551aso1566925b3a.2
        for <linux-fbdev@vger.kernel.org>; Fri, 05 Apr 2024 09:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712336284; x=1712941084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VxOrpUcgWV1BIbN70ZBNYzAG96ZmcBy16Bx9JpTxO+Y=;
        b=ZdGD97AzgpYGmeDMhyvJLmYFU81/b5Esk7PtWUCXapuQp4NHZywdE6hF5EjuLPVQ3+
         kF/JJjC0MkZ43sbv7UUtxeo03i/zCK68iW0OQDiZgmPmDLY8S7HPOi/lIxYvu4EFokub
         PXRilZyikkA7gfJGWDN1+uC9QL1sabQz+Wjv0ak8taECpSdjZcVVBn/5nMMrutGJ0Tjo
         2HZqVRVFEeDeaE2Q9fbWDxgF618E7BD7nWOPAAZLqKTmdkSVmrFf2mK+TYWmVLcdOtcp
         KHuotfO3O6tVzO1f0XMzP5FSRGmPw4ZB0WImnfB5Y/y8zw0eLTUIDvtDVoWsouWyc8Xx
         xzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712336284; x=1712941084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VxOrpUcgWV1BIbN70ZBNYzAG96ZmcBy16Bx9JpTxO+Y=;
        b=dpTwQbUC1tO+bHGyuF8g74qFzeFT2TJ2Gi9Cfk5BXVlRJsyPM6eteva0HJIKrVoaMk
         wwTHLfDKQ6AVSnuGX6IZSC+FTJquPjVU6ycxvlIXp1WHIdt5vnKEbXmBvaNSSGTFVTe9
         0uZ2uvmU+XtWF3OuYoad6cEFJsJgyaUK9E/eAQ7fjF5cUkWocArx2mb9+G3p7imZlYmS
         iW7JHRbzCtVQiQqWXbDxH0JGQ55CnoSkS8A6qcKBwW/EBR2E3qwBAbW//ES894IuaD3x
         e+X112Hmjsvxw6EE1wtPY5DuUbLGu/FkvzA0Z5D1aegxDG8ybVQrLag7PuAZyOZjBIun
         3IuQ==
X-Gm-Message-State: AOJu0YzWOEJxIaPeqwKxZkGbqdMrvtN7wNITBBXZgTT3aTlhX3JLlijd
	aEDdr6AgMytvhDNw850K63K2AMwutQ+xGJzGN9UVLgUz1A3pvKwOa9Ud2ENDdyST5kI95Us=
X-Google-Smtp-Source: AGHT+IF8+QcgSzXuJgKfFeVtRFmbVoLvx0pIjuAHQZQ5xpIO1ad1rxcl4fMvBNa0DNG870OGXhAphg==
X-Received: by 2002:a05:6a00:6508:b0:6ec:d950:fd59 with SMTP id hc8-20020a056a00650800b006ecd950fd59mr1796570pfb.29.1712336283914;
        Fri, 05 Apr 2024 09:58:03 -0700 (PDT)
Received: from localhost.localdomain ([168.138.41.106])
        by smtp.gmail.com with ESMTPSA id c17-20020aa78c11000000b006ed0199bd57sm1447393pfd.177.2024.04.05.09.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 09:58:03 -0700 (PDT)
From: purofle <purofle@gmail.com>
To: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-staging@lists.linux.dev,
	gregkh@linuxfoundation.org,
	purofle <purofle@gmail.com>
Subject: [PATCH] staging: fbtft: fb_st7789v: support setting offset
Date: Sat,  6 Apr 2024 00:57:47 +0800
Message-ID: <20240405165747.93377-1-purofle@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some screen sizes using st7789v chips are different from 240x320,
and offsets need to be set to display all images properly.

Signed-off-by: purofle <purofle@gmail.com>
---
 drivers/staging/fbtft/fb_st7789v.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
index 861a15414..d47ab4262 100644
--- a/drivers/staging/fbtft/fb_st7789v.c
+++ b/drivers/staging/fbtft/fb_st7789v.c
@@ -30,6 +30,12 @@
 
 #define HSD20_IPS 1
 
+#define WIDTH 240
+#define HEIGHT 320
+
+#define LEFT_OFFSET 0
+#define TOP_OFFSET 0
+
 /**
  * enum st7789v_command - ST7789V display controller commands
  *
@@ -349,6 +355,21 @@ static int set_gamma(struct fbtft_par *par, u32 *curves)
 	return 0;
 }
 
+static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, int ye)
+{
+	unsigned int x = xs + TOP_OFFSET, y = xe + TOP_OFFSET;
+
+	write_reg(par, MIPI_DCS_SET_COLUMN_ADDRESS, (x >> 8) & 0xFF, xs & 0xFF,
+		  (y >> 8) & 0xFF, xe & 0xFF);
+
+	x = ys + LEFT_OFFSET, y = ye + LEFT_OFFSET;
+
+	write_reg(par, MIPI_DCS_SET_PAGE_ADDRESS, (x >> 8) & 0xFF, ys & 0xFF,
+		  (y >> 8) & 0xFF, ye & 0xFF);
+
+	write_reg(par, MIPI_DCS_WRITE_MEMORY_START);
+}
+
 /**
  * blank() - blank the display
  *
@@ -379,6 +400,7 @@ static struct fbtft_display display = {
 		.set_var = set_var,
 		.set_gamma = set_gamma,
 		.blank = blank,
+		.set_addr_win = set_addr_win,
 	},
 };
 
-- 
2.44.0

