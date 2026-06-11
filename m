Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15C93CB2F6
	for <linux-fbdev@vger.kernel.org>; Thu, 11 Jun 2026 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781174293; cv=none; b=hSIibpcECb7emgjzcEI5FyVsyE8gKC/RKP+O6SHSnfD5dBL8s/edNtQVt9MpLx81CkXIh4CnRKYpVUMoIDm7L0n5+YokOzqH3us49E4GXjk9eypz+RM6KtMkQdIlLm4blgL1G8bjdMpl246viQcOx/gcZA2+QiAfU+TTMHqK4bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781174293; c=relaxed/simple;
	bh=E51J4T0xJ69/fphhlgw/2kq+lZqHpHqe+c+Vg/cpgoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hUfGE5u70KdTUZDwWNpzJpeDnTihewm6SYx0COZ690s9PF/bpWPjKzx2Wa9HZAWSKKJ16IfxUacKTlzcWFoiX4Ixj5Z54/caLFWpjncxoh16IyDBOt/sYQV+ossuR3YU3eit0GQkUEnzCRAYjV9qN0HIZKGrDgZUeZWKyRdnBos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ER7on6OX; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ER7on6OX"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36bdb11bf8bso4604303a91.0
        for <linux-fbdev@vger.kernel.org>; Thu, 11 Jun 2026 03:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781174291; x=1781779091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1RMANRuTG+F/Bx/ZEnnvybJMzkG0+xiu8ZbbDHlOBqs=;
        b=ER7on6OXnE5JKfuRs8hzR2EGQLB4b1/DF4kBvONGZ9EmEu8hx+QfljK45LZuXVYwuv
         8/CBCBC9uKZZWOXTQglTzw7FMypqxfg2ATUhr90bFvAfsv6LamUP6qXajz4efrNlRoF7
         OWuiTCgQ7cHsp4s4CDIVFjwdj9ZwiDD4vV6QvbA2dDkEcYpax8Drl2dwkmiPGp9xaWny
         PhtdHrCRyc6t4CAITV7zjwsNlrKgPZkafB0g6sDTqgIFk8RTW4YQRtZlBMkmvOisU0Ne
         cYay+4fZc8VvjzUk7cwBNX7LRvIGVUbBgHBq7cvCfPRJVQTmf1OX1/VPMpPZzw1Nj4Mf
         5B7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781174291; x=1781779091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RMANRuTG+F/Bx/ZEnnvybJMzkG0+xiu8ZbbDHlOBqs=;
        b=ORb/8+Ts1RtZnh97FJVmQEhA2l5yc7AyOLP+FpIeCbU8UQswzz+xUCsGU7XFAI5hpg
         J+OLVDW3YAAJeOlibXTJW8f+uUjX31magFl32//Arw6N/B6vXVJdKnmt6lOB+lae0ojZ
         +26HRmnyGvrZ3KfhNmW0ZE3EPSsnh1068i4/uO0firOXJwBARB4US4QLLAEXL/+gscMx
         fluRi4JUiXDMXpE95UavoenC/X/nJbu+OJwRZkxm/t1t3Nx3o7HM4Y3aKWoaI/G8WwAw
         yksX7D6MJAJKhgwRHMmMZsCliuaDJ6Cq+3/sh/mx2vCEd/6+rwkoTY6fC5ARdBO+2dgg
         X6Jg==
X-Gm-Message-State: AOJu0Yyl9WPhqmicheyi8TkI+z2Hf8kzihE66OYkkMP+WoH/XFCYJQ3j
	Gi+0I9REcVXikrUq/nGwYECtwv4CNxA9L3aHE5YJafIFhpzdbTVBY96s
X-Gm-Gg: Acq92OFqsFqvNUSAhUfa5V6M4fEpYHFnxzFgPiUnZ8aNSdrGzI9kA5keKX5M3s4rlFB
	eIFfgkjhhPWO72QowGN01SNtrBqSqjixvRwFh+6p3vuSviuRvKlzj5ERMm11NbpNxjYQIC/Sq6x
	emztI+nm6v5HmjRLXEF13yQW7asfM4+N/kz63sxM8XTK/Y3iGKAhJ/21oKHqgO+CyeUi6TamISJ
	5YqjXoS93i4N69usWCTer5sRlqS1WQS3taeJ/2QAK6c91rrJo0B3OVY+3USueGIr8A9BmyGcFHr
	Fz3rSeKgksgItXL/4hEHhvV/A9CK2OKaEORfUqHP8bTih6CC0gUiB3qeMwz+1mEJy+vBitct2xt
	cmgySi04szeSjTl21dqCTpJ6lQhxxrVFoAHba7GRaHwIzdjRRRykn0olTxWYrfzLH0CJc1hqq/9
	BjY6KTlLvtqVfybVq26H9wkXpEd51Zu7z5
X-Received: by 2002:a17:90b:4d81:b0:36d:81b3:61a1 with SMTP id 98e67ed59e1d1-3779d2d72e5mr2424749a91.7.1781174291203;
        Thu, 11 Jun 2026 03:38:11 -0700 (PDT)
Received: from 192.168.1.10 ([43.248.69.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377528719e0sm2648202a91.5.2026.06.11.03.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:38:10 -0700 (PDT)
From: Siddhesh Sable <ixebec777@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Siddhesh Sable <ixebec777@gmail.com>
Subject: [PATCH] staging: sm750fb: fix CamelCase variable name Bpp to bpp
Date: Thu, 11 Jun 2026 16:07:48 +0530
Message-ID: <20260611103748.29584-1-ixebec777@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CamelCase variable names violate the kernel coding style guidelines.
Rename all occurrences of 'Bpp' to 'bpp' to fix checkpatch warnings.

Signed-off-by: Siddhesh Sable <ixebec777@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 0f94d859e..4beabe105 100644
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
@@ -102,14 +102,14 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 
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
 
@@ -138,7 +138,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
  * @sy: Starting y coordinate of source surface
  * @dest_base: Address of destination: offset in frame buffer
  * @dest_pitch: Pitch value of destination surface in BYTE
- * @Bpp: Color depth of destination surface
+ * @bpp: Color depth of destination surface
  * @dx: Starting x coordinate of destination surface
  * @dy: Starting y coordinate of destination surface
  * @width: width of rectangle in pixel value
@@ -149,7 +149,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		      unsigned int source_base, unsigned int source_pitch,
 		      unsigned int sx, unsigned int sy,
 		      unsigned int dest_base, unsigned int dest_pitch,
-		      unsigned int Bpp, unsigned int dx, unsigned int dy,
+		      unsigned int bpp, unsigned int dx, unsigned int dy,
 		      unsigned int width, unsigned int height,
 		      unsigned int rop2)
 {
@@ -249,9 +249,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
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
@@ -259,9 +259,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	 * for a given point.
 	 */
 	write_dpr(accel, DE_WINDOW_WIDTH,
-		  ((dest_pitch / Bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
+		  ((dest_pitch / bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
 		   DE_WINDOW_WIDTH_DST_MASK) |
-		  (source_pitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
+		  (source_pitch / bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
 
 	if (accel->de_wait() != 0)
 		return -1;
-- 
2.54.0

