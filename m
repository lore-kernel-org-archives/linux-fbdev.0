Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB18376BE2
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Feb 2026 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044064; cv=none; b=WcoD7QHOuLnDFk5J0Lx6GeK3UKKdkpZe2Sba5KFNDiMjyiGrgbbZnzQegKpcoR+RxAlgfFH2wNFNVixe+0xGQ1iTnRU64YrC/4bn88zBgEcmphi4wCnhFOjzO/h7GuML/CgaYzgcovmTC01pUQ9u7dyhpBizoAWPtBC2R/An3k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044064; c=relaxed/simple;
	bh=HlzZDm3wDGEDRIiUNHMPI3nIr6vadV093jni4DOqn4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b1JHUF2mTuTFVc7KuDeTcm0pb4VicnAVQjkDfK8umpXLEZzBX8vZ+mAc7unpvwbi5QdWuHU5BRArtiFiImJusV8+lIx64yXQEyLNbuEt+RqZibnU0ySRsGB4u4/E5SP9JVoQG5n2Ksp43XHClayU9hIX67A1EKNDiOqTT+d70yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qzb79sM6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qzb79sM6"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so60636755e9.0
        for <linux-fbdev@vger.kernel.org>; Mon, 02 Feb 2026 06:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770044061; x=1770648861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vEn4ZKSSYDbmHCenGK9C31Qr9OkytxiWm0OV7IJoy3M=;
        b=Qzb79sM6T6WqcLqoluR1TuQxmD8kGsCmZ9EMgyLLgs9BQf4UsERoYepflQ4FqzNRUd
         5rU83mwRmDRDsNquHOiCRT/xuffTFgI32INejUbITjv+AYZojRh0H89xKaiVpjU8VuAy
         M4CAWzpA36Uo4zaMIlwQ2Md7jLjMIx+7hhm37RXBVUfLnxPm924lS4D3JHhltqu8qlGu
         nowRTpp1MI9iRO6GY1V41QoIcuRqFebNHn+DUmGrjodF2AYH5gWUREg95A8D4EiL5oyc
         erTlO6HkZwDl49qJKJHNerQB3ZpEKWdbiX9Y0bOp/RcHkg5glHBVOWOV2z5B/XynKXJ+
         MuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770044061; x=1770648861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEn4ZKSSYDbmHCenGK9C31Qr9OkytxiWm0OV7IJoy3M=;
        b=RLzgEb8Ao4g7QgayMVWurZk8cqcbJZD7Kdc6pI31XNxZFx9X5XAzJbp6SqiiXkxWpJ
         r8tbnFBqN5GA/tE5pked9k5xTxFBWsswff6017l2jrUqGgWeAA7VtrRYEamM+wQ468tB
         jIxkS2mgRGKyJ5X3k3o0Z34I8b+sS07KcDAdajRsU3wJyBlIuyWYkdfzaqjBp03+tBP+
         Kv9of+XoyYfai9Frl2YZ+pMwW4T7d79KrMf4Osxc364JlRs9Euldx0zSQyrpCNEDJODy
         fdLtf1Fa+b71HeqT5CzKuuy6ea2tThdW3aAQQvzFYcQ0cD5aDGuK2chDAjj1NGPbdqdh
         /f4g==
X-Gm-Message-State: AOJu0Yy9AvzojsAw050fuI3mhXHObx+/NyafA7r7RPZu0qestq3YD3T5
	4VeltEOf3TeKRmX3bNTpH4WaQStsFhOOdClLHsOgXZTEdo5z1Z/PpL9YMoM87eBm
X-Gm-Gg: AZuq6aK0vKv/uFMG/EVDz0DLT+eakBXZ+zIlVjMljYFkSKjYGBUd4WYP3K152jWkMll
	eufoB5hACNigBQTT1zDqAXCfNTD9Sf+6RnmSDIYpwGlc/aMCdkLeDKdOviuZv6oxkkWYG77kE4Y
	Bi9TVqzFlztGKP5Rux7rGRExET9bap8hYd/D56EvIBYaJjOYs0OSKNR0L1xnP8VLWsD5q8Kp9lK
	BHgHO+DuEbt0qoS+SnwYGMSw4uNEG/eFk9GLzDbBBmQKY5RqZ9zOsKs6a7xTmItokn0uOu7+KfB
	BXhLR8MxG4LvSrf6/7Y1i51EBhMmOioeFKC3EJ0O/Bk1VUWd0AzYKI2DXzK7uR6GTOG2AwRK8s0
	pTMc1UbuQefelNm3Um4G3qf74grOcahq587VaaOQI6EAyw3Z2MiEwbBy3Dtw8S0wlxVHiiRJ8DU
	yI6qSOp1/WUiCXeTmc1g3b1OFyalAeaw2TNGYSQ2lRXQCNanvSlj8=
X-Received: by 2002:a05:600c:8b0a:b0:477:af8d:203a with SMTP id 5b1f17b1804b1-482db49993bmr153461055e9.27.1770044061016;
        Mon, 02 Feb 2026 06:54:21 -0800 (PST)
Received: from yehudis-VirtualBox.. ([195.60.235.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e2973d57sm91081965e9.18.2026.02.02.06.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 06:54:20 -0800 (PST)
From: yehudis9982 <y0533159982@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	yehudis9982 <y0533159982@gmail.com>
Subject: [PATCH] staging: sm750fb: rename Bpp to bpp
Date: Mon,  2 Feb 2026 16:54:13 +0200
Message-ID: <20260202145413.132435-1-y0533159982@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the Bpp parameter to bpp to avoid CamelCase, as reported by
checkpatch.pl.

Signed-off-by: yehudis9982 <y0533159982@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 046b9282b..866b12c2a 100644
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
  * @dBase: Address of destination: offset in frame buffer
  * @dPitch: Pitch value of destination surface in BYTE
- * @Bpp: Color depth of destination surface
+ * @bpp: Color depth of destination surface
  * @dx: Starting x coordinate of destination surface
  * @dy: Starting y coordinate of destination surface
  * @width: width of rectangle in pixel value
@@ -149,7 +149,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		      unsigned int sBase, unsigned int sPitch,
 		      unsigned int sx, unsigned int sy,
 		      unsigned int dBase, unsigned int dPitch,
-		      unsigned int Bpp, unsigned int dx, unsigned int dy,
+		      unsigned int bpp, unsigned int dx, unsigned int dy,
 		      unsigned int width, unsigned int height,
 		      unsigned int rop2)
 {
@@ -249,9 +249,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	 * pixel values. Need Byte to pixel conversion.
 	 */
 	write_dpr(accel, DE_PITCH,
-		  ((dPitch / Bpp << DE_PITCH_DESTINATION_SHIFT) &
+		  ((dPitch / bpp << DE_PITCH_DESTINATION_SHIFT) &
 		   DE_PITCH_DESTINATION_MASK) |
-		  (sPitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
+		  (sPitch / bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
 
 	/*
 	 * Screen Window width in Pixels.
@@ -259,9 +259,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	 * for a given point.
 	 */
 	write_dpr(accel, DE_WINDOW_WIDTH,
-		  ((dPitch / Bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
+		  ((dPitch / bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
 		   DE_WINDOW_WIDTH_DST_MASK) |
-		  (sPitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
+		  (sPitch / bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
 
 	if (accel->de_wait() != 0)
 		return -1;
-- 
2.43.0

