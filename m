Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBFF3C9EEF
	for <linux-fbdev@vger.kernel.org>; Thu, 11 Jun 2026 10:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781173487; cv=none; b=Q+xNSY2+Z+rCnufHGr8y/8EtdHILPgcxDnhNUxC+kl6xXQZwQlr58mAdGrvYWnpCeouKNYpx6IMdxvi0KXqu8NUNl6M/QBjxVgucLCNMrdpUH2ZZKYKg8bHt7sWX+v6x7lfVq0wp87TR+KZ+xi2Tcdb3qmBwlK5kNyzb9owKoWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781173487; c=relaxed/simple;
	bh=hlfMl8YRaJvwDqi/+iqxrs0r1tbx3KXyGipQCqVE0hg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NMQ83PMn/i621P1a3EDOAJJfBRUdwU9aGK+lPhZODvNQtzpzW+IE5UMsZX3MLwAusVYoXa7qRRVcMhGkpFsAryq914EngwQT2WhQ6rzJBM90uOQQnwtPWSzmhS5Sm5fWhJH6z34htGW5LJDH9IKwkqYkbrE82kiEgX22w1y8Kko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQq+rGIQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQq+rGIQ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c168baac83so37095525ad.2
        for <linux-fbdev@vger.kernel.org>; Thu, 11 Jun 2026 03:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781173486; x=1781778286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ouPpwQMT501sab37XIOkk8CD2y0PoAbrmxd6qozXfMQ=;
        b=UQq+rGIQM/zuhZjb1KqhheEcrIeOWtPlhxRQ3FIIYC5ZxmO7KPWwqZLViZbEQIvkvH
         VIit9u0F9pPy+lXnfp8Bsc5yKY2HG/C5A3G1hiY23mtmHYtA1vBkfJhn53waw/q2gsAS
         MvaIqiznp2AY77c6LBaJvk8MB5oGvKMbskd/Ayg+Oqr7MQFt1MCyY47AdJLDP/XgcTpj
         8Ncyh5yJ5It2kFdJ54F5JMflBNZCwTLBEJ6g8ESkHcroVg+Fm5L65zfMeHqtLhHPLBgf
         I9HL6yo+2MxQoRAI8AzhtQKcuxneHtl1h2QHlJZyTVIpuWxjJ9hQZtCKUhf7ikIHNAHB
         7cLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781173486; x=1781778286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouPpwQMT501sab37XIOkk8CD2y0PoAbrmxd6qozXfMQ=;
        b=fe83giq86Ot3VnSCaxbYUwH3usvr8Kdyyks3MjSuMOS0D3AghoJCaFwbJFLZVZCczx
         n4cYOZ8UIflDZl2o4YPl6YMezgel3n7CzpZliwtbxu579DbWp1gq0U3tQUXH3/WQS76R
         RXbsFrW4wiuN/mywJZu1JthYrSPvIfbrox+raPTo+mXqTHHFOh0LBj7e3xgYhgQgiB5A
         DVsUuy8s7JdQPcC7mOw8ugGOSrdU0GzJCDMfK+Cc4asHTE2nC4uxvCecjufuvO8spFnD
         sh4gjOS2CXDKurX5d0LTWZFO4q3lG7dqNStRsaOqSlRm1eNlJ//FLreMdGVtgJZq8qFq
         TYng==
X-Gm-Message-State: AOJu0YzZNEB7gHPTnvH5ikCLSX4a7dWehtnYAYveeZxVIz2kTGb9mcZH
	H5pbH0gK2ZrZsZmyAF9KeNPiG4iSB4fyPzHa38sT/ADFcLkDFodgSeKW
X-Gm-Gg: Acq92OFIKIqRR0OgRQVN5oh72vMXsc1Opmi2/NJ5aH/OWjx9PXiQsTE9PFvbmKzo+6b
	zphwF0DPhPvYOgUw/FqB+xNRDwjRwE45nyEw871KnI/vKs3AwZDjv0X8rDe7PpK6ld10zw2dMcf
	2ar2L2QomjchBlJY3bi5bz4sF9gGQaAqSHllQXmrSnGF1UTMcy4GJNADCNzkR/UN+ZuujYHnK3e
	jMdtxD5WZXGrZQS4Fr5lahnuW95HrRJswb1NIAIvG7P2bufPgPY+dsBl1F5tKN6CdNK/ZF0asD1
	u4mlGty01OVlqqQL3TQ4Lu576BmQkiQZAL+7PVWN0PArqo1D+9pFyQYSp/SrfZr9kDX1B6VOgs/
	WPGwo/uf5pbPZ4o+NLqb4rz+gIOVOxPJ0xEnGQJzTVdLazaL5VkS3Obg0v9N5F7m1EXG89vipPC
	03Rvn5bbrJO8t+QnTIRiqRRcvBrGLRizjk
X-Received: by 2002:a17:903:3b8b:b0:2be:e3bc:e8e4 with SMTP id d9443c01a7336-2c2f2a77e4fmr24126845ad.18.1781173485714;
        Thu, 11 Jun 2026 03:24:45 -0700 (PDT)
Received: from 192.168.1.10 ([43.248.69.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d55esm279641675ad.63.2026.06.11.03.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:24:45 -0700 (PDT)
From: Xebec77 <ixebec777@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xebec77 <ixebec777@gmail.com>
Subject: [PATCH] staging: sm750fb: fix CamelCase variable name Bpp to bpp
Date: Thu, 11 Jun 2026 15:50:27 +0530
Message-ID: <20260611102027.28137-1-ixebec777@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Xebec77 <ixebec777@gmail.com>
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

