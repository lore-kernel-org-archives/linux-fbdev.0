Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312993AD51C
	for <linux-fbdev@vger.kernel.org>; Sun, 17 May 2026 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779023984; cv=none; b=EBcycaqeBoMoDKex2dFpmX2mFFUHtviso0DscpjemLGgIeTpLitwUR+kQ5TJdTeaWv92jaOFgeGkEfp+9mP8JVXKLSm/sFXRtfS6HzTuLW21KmYcgtb+1mTi9lDZmk2HaTGVP6N6W0WroulV++pHqP/0Yg8t4WSsilwqC4VoDX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779023984; c=relaxed/simple;
	bh=jruy9C0+DAnIeXUwqu79F+yBCJJKuZ1rEfyvwUris4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nVd0ZL+wijRWpwLEhoG69t/oL3I9jATBK0uD4FxcaxpM4M7Chtomh5a7ivGNLicXlAs8sqFseoTxcoP7UfpBMzsL6kRFu/9J+vzES+olDSlIGzTSH+OL7fi41B1Iwfk5/0MXapVGELl2kmnhCmnJF8M5eeLyxKdWOH4Wk6E0Gzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFNZynXz; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFNZynXz"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a8891f0c88so892945e87.1
        for <linux-fbdev@vger.kernel.org>; Sun, 17 May 2026 06:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779023974; x=1779628774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7/dqCYjDfAnPwhsU6wCw9vMKNTZiUIqNFGfHG4kAM7s=;
        b=BFNZynXzXjoI3rFrrO/jXkVN4OJ+8i+32owClj9iaZjueUqxY7ZhMXTHCQogpMt1su
         Ycxa11OcHvq+JwCCmYPLcQEUcHIG0wy6ZuwJEwztQZHByHFvIBNOOUH7HX9praHiaqda
         RLj+Gvn0s4PEizUvmXTpojVxrHO6Sv38iPTkxIry6+VhCEf5rcVOkiaeMuZ2sZrrj/4D
         CaKrlmIoDHG3x44u27GbVkI6kli0sFM7gCZ3xTEE0lEsXR/XNXQ0PrvRJj2tfV1BTbnN
         cWTQ0+v1bHRaweK3p/s3nHxwtkWsHny6e8k9J84xZyfuO/JDXSplaAW3w0MhGPpflf+6
         gS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779023974; x=1779628774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/dqCYjDfAnPwhsU6wCw9vMKNTZiUIqNFGfHG4kAM7s=;
        b=Xm/Bq8qpn+VpE05INkofosEw2/VhMEzfWGFk7/2UTytBXLpCdKvSCM00ptbg5Nbdii
         onQtv/SxlWZRER37xl0GkILn5oKRGuqjivqbd6mfxNfNG2rVSDoAzH2RlWHypQQjt+L2
         Kv8odq05dMjWuMfIYYxkNKXRfR130PNAbB2SZp+iuvOXPcq3H4bMEE5qKA4Apv8seql0
         1MXX8tKlUv+xD1Z3bFHETH6CGphH9ojqu8I70K9g0nyvJRa6NQEzWQnIdjYQagMLOW2L
         Jfoum359c2sK7ZzUgDddpdanZrfuC961Z5FIgH9aNmdZ6a6TmZBQ7neOQ3pEI6izFU6i
         QgVA==
X-Forwarded-Encrypted: i=1; AFNElJ/hcejpoVRgF0mNTZUHKHrhJ8QVPWu87jgUi5msCn7aTviT2y++MR1Nv53sAbsQl9hf9OEvvBZ0q5aciQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw14sty5HfAV+6yQM5t2Bqm53FVG6lVph0kq5bCMl8UIXDXSpia
	HtY3REDfFgE48q1YRLIBitHo5xoT8gr4uoWPBqpp3SB3NUGJDba4xO1t
X-Gm-Gg: Acq92OE0hvGdgaa2QoEreqldPlFb7kfypUuCpMWqP2L+v/xBEVaXFAUbml3SDsP4tpz
	Vp3Kps4XUfqxuTaFC608owwOJotj5YaMWHo9gn/qEz/XIMknrvjf57SBcUSW1hO/svcZM1FX6YM
	D9wE2tMUhczn00KaEyYSMPPsRwZzDvalNxSr5lT04D2eeR/Ff/4np5LjFf5/nW20VBwWNmntWB+
	EHDYhswIknn4O+YzuPnDnz5ZFE0qzybSU4dNxfYaWJjOi2A/B7b57py/+sEGXagSZy9z5SfyzrA
	5pNtPuefAfS+XWRw1R1PYRZZRYjGDeI2PJzuf7FoaKq23YTYsVQAA8GKVZVHsHu8bourIN6UFzB
	GMI32ZU3/uAcsPJoKBnZNXSAQRt8rp0/lukM0duBGHwGAq+GdKMP2dJdEir3BAg+sebbo2SUm7M
	MYCVv6Wmu1SuXxhGkM4hWsAt670JjwzkeJ3l6zq2PDIbJp4Vn/YS0YgOz5q20My12y9tauQ2A76
	67glVY+zl2Wo7wwanIIl+kbaroAPSsfnA==
X-Received: by 2002:a05:6512:1321:b0:5a4:1a2:1d39 with SMTP id 2adb3069b0e04-5aa0e5ffab1mr2864465e87.6.1779023973716;
        Sun, 17 May 2026 06:19:33 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164bc440sm2686166e87.51.2026.05.17.06.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 06:19:32 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: gregkh@linuxfoundation.org
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH] staging: sm750: rename CamelCase variable Bpp to bpp
Date: Sun, 17 May 2026 16:19:18 +0300
Message-ID: <20260517131918.197943-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the CamelCase variable 'Bpp' to 'bpp' in both the header
and implementation files to comply with Linux kernel coding style.

Issue found by checkpatch.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 22 +++++++++++-----------
 drivers/staging/sm750fb/sm750_accel.h |  6 +++---
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index ec2f0a6aa57d..59449a84728a 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -85,7 +85,7 @@ void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt)
 }
 
 int sm750_hw_fillrect(struct lynx_accel *accel,
-		      u32 base, u32 pitch, u32 Bpp,
+		      u32 base, u32 pitch, u32 bpp,
 		      u32 x, u32 y, u32 width, u32 height,
 		      u32 color, u32 rop)
 {
@@ -103,14 +103,14 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 
 	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, base); /* dpr40 */
 	write_dpr(accel, DE_PITCH,
-		  ((pitch / Bpp << DE_PITCH_DESTINATION_SHIFT) &
+		  ((pitch / bpp << DE_PITCH_DESTINATION_SHIFT) &
 		   DE_PITCH_DESTINATION_MASK) |
-		  (pitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
+		  (pitch / bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
 
 	write_dpr(accel, DE_WINDOW_WIDTH,
-		  ((pitch / Bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
+		  ((pitch / bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
 		   DE_WINDOW_WIDTH_DST_MASK) |
-		   (pitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr44 */
+		   (pitch / bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr44 */
 
 	write_dpr(accel, DE_FOREGROUND, color); /* DPR14 */
 
@@ -139,7 +139,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
  * @sy: Starting y coordinate of source surface
  * @dest_base: Address of destination: offset in frame buffer
  * @dest_pitch: Pitch value of destination surface in BYTE
- * @Bpp: Color depth of destination surface
+ * @bpp: Color depth of destination surface
  * @dx: Starting x coordinate of destination surface
  * @dy: Starting y coordinate of destination surface
  * @width: width of rectangle in pixel value
@@ -150,7 +150,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		      unsigned int source_base, unsigned int source_pitch,
 		      unsigned int sx, unsigned int sy,
 		      unsigned int dest_base, unsigned int dest_pitch,
-		      unsigned int Bpp, unsigned int dx, unsigned int dy,
+		      unsigned int bpp, unsigned int dx, unsigned int dy,
 		      unsigned int width, unsigned int height,
 		      unsigned int rop2)
 {
@@ -251,9 +251,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	 * pixel values. Need Byte to pixel conversion.
 	 */
 	write_dpr(accel, DE_PITCH,
-		  ((dest_pitch / Bpp << DE_PITCH_DESTINATION_SHIFT) &
+		  ((dest_pitch / bpp << DE_PITCH_DESTINATION_SHIFT) &
 		   DE_PITCH_DESTINATION_MASK) |
-		  (source_pitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
+		  (source_pitch / bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
 
 	/*
 	 * Screen Window width in Pixels.
@@ -261,9 +261,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	 * for a given point.
 	 */
 	write_dpr(accel, DE_WINDOW_WIDTH,
-		  ((dest_pitch / Bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
+		  ((dest_pitch / bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
 		   DE_WINDOW_WIDTH_DST_MASK) |
-		  (source_pitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
+		  (source_pitch / bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
 
 	ret = accel->de_wait();
 	if (ret)
diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index 2c79cb730a0a..d15a40cacb84 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -190,7 +190,7 @@ void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt);
 void sm750_hw_de_init(struct lynx_accel *accel);
 
 int sm750_hw_fillrect(struct lynx_accel *accel,
-		      u32 base, u32 pitch, u32 Bpp,
+		      u32 base, u32 pitch, u32 bpp,
 		      u32 x, u32 y, u32 width, u32 height,
 		      u32 color, u32 rop);
 
@@ -202,7 +202,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
  * @sy: Starting y coordinate of source surface
  * @dBase: Address of destination: offset in frame buffer
  * @dPitch: Pitch value of destination surface in BYTE
- * @Bpp: Color depth of destination surface
+ * @bpp: Color depth of destination surface
  * @dx: Starting x coordinate of destination surface
  * @dy: Starting y coordinate of destination surface
  * @width: width of rectangle in pixel value
@@ -213,7 +213,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		      unsigned int sBase, unsigned int sPitch,
 		      unsigned int sx, unsigned int sy,
 		      unsigned int dBase, unsigned int dPitch,
-		      unsigned int Bpp, unsigned int dx, unsigned int dy,
+		      unsigned int bpp, unsigned int dx, unsigned int dy,
 		      unsigned int width, unsigned int height,
 		      unsigned int rop2);
 
-- 
2.43.0

