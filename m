Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB26232F763
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Feb 2026 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770050815; cv=none; b=X+GvYX9Bfdi47bWXj4A/83pyvUElCj5WhCF0mHjkxhyV2WH/Wyh62OfUXPQq/8fR9g0wEEB79sO63L12FhEb975YOX3ZJjse1z7Ux1HRf/y8KjyMk8i+P9GLbyuJO6dd/nusYNYgLTct/tcT99hddYMhmZD6B6eK01vf3cwB/ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770050815; c=relaxed/simple;
	bh=uZupMsY12grTXtbViH2uDs9GyHCl34p6SlRSawPH9Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TodFfcLsFX7n6737YU3l5DYHuPAg5qJEkD2UtIs527Cm/oECIsLS39OJc9Fu+wCKZsfdc/aPN/JDa1484MCEEt1kccMlcQ8lmFy2o6/sw/mFU0Q2lDTQ4HYDRDybxIhZ+iitmxWMVHqos0NkmlYi3Ra7fFKb2q4k1ZMesFndTRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhAuOV3R; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhAuOV3R"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4327790c4e9so3004503f8f.2
        for <linux-fbdev@vger.kernel.org>; Mon, 02 Feb 2026 08:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770050812; x=1770655612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INIFCBCUJTQI/9LdXmCI4Y+qu/4cGnWjRRdFLeUHGsM=;
        b=PhAuOV3Rfj02H0JgXBCDguOv4oa+Lsv6QRHSt17L48d+Wtxxx+HA6fYH5Pob43HBD3
         ml4IjPHMFqMXIF961myF3BTVm44QftEUvmojUTTxXH9GZcCAI+GQyib4Vp8m/fHtpOzb
         Du4JHs7jUB0gsPNgpYV/aieU2OIpabjK/BQYXsmDu4zdtDyAEMFBtyLVj8PZA+5jJdLA
         MCoxgZ470r+EoXIQ2rxDnefT5FdhMLZwGmT13KLFAvgdqpI0j47HRydNMf/0S4HMR8hQ
         EnIn4cv0dVVegXxVesGOeHr1/57zhyeVFM+1Q1dqd7b/DqG66DZC0NTStHOby82lPIjI
         4vdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770050812; x=1770655612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=INIFCBCUJTQI/9LdXmCI4Y+qu/4cGnWjRRdFLeUHGsM=;
        b=cun8bxPAV8FwN3i6eujbeO1ATyxlWbw4kc1pbtf9sPJxwoOJYxd/VtTOEVK8INFYXC
         cIKcFXSTrfRpSuejQiSlucZl38NFFgNs5l74MG7AU6XwKke8TisYHd/3TuZIja2g8aDm
         MpeP2E8rZPibQ55sbrBDKBZA5gGZNtuaCT1MxhDm7bpnlkP3128Gqr1gogIEEAO9azbk
         Q9sYQLzg80PXihVmHtfsubOJ6occsQg813plOkGiSfwXh6Tfe1VyOccKHN47dDhm2G1u
         7mhLWNIMMzzL9nEoiGNCDhFgSOloRli/F6jcjUPYbLJoPJjAFQXVZvnBEe6ZvomNLEkc
         ChrA==
X-Gm-Message-State: AOJu0YycapGxHXOHIjCIwzkUA93Yw0NagEQWoyREOLKBnyXgryrW99F4
	NSd9UJBiYm6rZJxBECwwGG4X12robHyN04nMXODdc0YHfk7rNviyJQg2/F/JsIsm
X-Gm-Gg: AZuq6aKKaAFZWahIOROI3Z7M4SdUX5eSXX/ELk+2VbRe0D1mIVjKC1Y9MnZzId48JPR
	T3wVHgX2V4HKzxUxybuJt3NArupXvXvhGa/7ZX0sNjVyKNKs/pmN/jEwNp/7a/NZE8RUWmiKnnh
	fnxRhKXVmuqDdktVhaocEzUyOVUPqhWr5k/6eZBTyzqnwfYv3JjRK4T2+pq8l1O27w7jU63/9Ez
	NM/sJMr8ore9Le2biU/CsNA/8dDI9F1ZFKIYAgvL/wdNTmrGF/KHSB4fh2OkShv1rlOMOdeqnqu
	ihJCMqwsht9IHT9sgUTnnJ9PXz+/e82fZA/E6Hg0gsSMW959BKhifMvtmVJv8/ZLb1SI3ysr6GU
	+Nl2x0mnxJjE5sTgbFvhLu9XEyiArrxyYJJEkEbvs5nfIYuOndD5PQ01GYdVsW9cTMosRs3nRcS
	jyO37l+KU0i4lE9uho6VqH2VZHAXSrntPMo46hNQPylJciMgTDszY=
X-Received: by 2002:a05:6000:400e:b0:435:98c6:7f06 with SMTP id ffacd0b85a97d-435f3a6f562mr16178743f8f.6.1770050812146;
        Mon, 02 Feb 2026 08:46:52 -0800 (PST)
Received: from yehudis-VirtualBox.. ([195.60.235.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10ee078sm45122422f8f.16.2026.02.02.08.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 08:46:51 -0800 (PST)
From: yehudis9982 <y0533159982@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	yehudis9982 <y0533159982@gmail.com>
Subject: [PATCH v2] staging: sm750fb: rename Bpp to bytes_per_pixel
Date: Mon,  2 Feb 2026 18:46:45 +0200
Message-ID: <20260202164645.133806-1-y0533159982@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202145413.132435-1-y0533159982@gmail.com>
References: <20260202145413.132435-1-y0533159982@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the Bpp parameter to bytes_per_pixel for clarity and to avoid CamelCase, as reported by checkpatch.pl.

Signed-off-by: yehudis9982 <y0533159982@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 046b9282b..3fe9429e1 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -48,7 +48,7 @@ void sm750_hw_de_init(struct lynx_accel *accel)
 	      DE_STRETCH_FORMAT_ADDRESSING_MASK |
 	      DE_STRETCH_FORMAT_SOURCE_HEIGHT_MASK;
 
-	/* DE_STRETCH bpp format need be initialized in setMode routine */
+	/* DE_STRETCH bytes_per_pixel format need be initialized in setMode routine */
 	write_dpr(accel, DE_STRETCH_FORMAT,
 		  (read_dpr(accel, DE_STRETCH_FORMAT) & ~clr) | reg);
 
@@ -76,7 +76,7 @@ void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt)
 {
 	u32 reg;
 
-	/* fmt=0,1,2 for 8,16,32,bpp on sm718/750/502 */
+	/* fmt=0,1,2 for 8,16,32,bytes_per_pixel on sm718/750/502 */
 	reg = read_dpr(accel, DE_STRETCH_FORMAT);
 	reg &= ~DE_STRETCH_FORMAT_PIXEL_FORMAT_MASK;
 	reg |= ((fmt << DE_STRETCH_FORMAT_PIXEL_FORMAT_SHIFT) &
@@ -85,7 +85,7 @@ void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt)
 }
 
 int sm750_hw_fillrect(struct lynx_accel *accel,
-		      u32 base, u32 pitch, u32 Bpp,
+		      u32 base, u32 pitch, u32 bytes_per_pixel,
 		      u32 x, u32 y, u32 width, u32 height,
 		      u32 color, u32 rop)
 {
@@ -102,14 +102,14 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 
 	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, base); /* dpr40 */
 	write_dpr(accel, DE_PITCH,
-		  ((pitch / Bpp << DE_PITCH_DESTINATION_SHIFT) &
+		  ((pitch / bytes_per_pixel << DE_PITCH_DESTINATION_SHIFT) &
 		   DE_PITCH_DESTINATION_MASK) |
-		  (pitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
+		  (pitch / bytes_per_pixel & DE_PITCH_SOURCE_MASK)); /* dpr10 */
 
 	write_dpr(accel, DE_WINDOW_WIDTH,
-		  ((pitch / Bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
+		  ((pitch / bytes_per_pixel << DE_WINDOW_WIDTH_DST_SHIFT) &
 		   DE_WINDOW_WIDTH_DST_MASK) |
-		   (pitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr44 */
+		   (pitch / bytes_per_pixel & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr44 */
 
 	write_dpr(accel, DE_FOREGROUND, color); /* DPR14 */
 
@@ -138,7 +138,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
  * @sy: Starting y coordinate of source surface
  * @dBase: Address of destination: offset in frame buffer
  * @dPitch: Pitch value of destination surface in BYTE
- * @Bpp: Color depth of destination surface
+ * @bytes_per_pixel: Bytes per pixel (color depth / 8) of destination surface
  * @dx: Starting x coordinate of destination surface
  * @dy: Starting y coordinate of destination surface
  * @width: width of rectangle in pixel value
@@ -149,7 +149,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		      unsigned int sBase, unsigned int sPitch,
 		      unsigned int sx, unsigned int sy,
 		      unsigned int dBase, unsigned int dPitch,
-		      unsigned int Bpp, unsigned int dx, unsigned int dy,
+		      unsigned int bytes_per_pixel, unsigned int dx, unsigned int dy,
 		      unsigned int width, unsigned int height,
 		      unsigned int rop2)
 {
@@ -249,9 +249,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	 * pixel values. Need Byte to pixel conversion.
 	 */
 	write_dpr(accel, DE_PITCH,
-		  ((dPitch / Bpp << DE_PITCH_DESTINATION_SHIFT) &
+		  ((dPitch / bytes_per_pixel << DE_PITCH_DESTINATION_SHIFT) &
 		   DE_PITCH_DESTINATION_MASK) |
-		  (sPitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
+		  (sPitch / bytes_per_pixel & DE_PITCH_SOURCE_MASK)); /* dpr10 */
 
 	/*
 	 * Screen Window width in Pixels.
@@ -259,9 +259,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	 * for a given point.
 	 */
 	write_dpr(accel, DE_WINDOW_WIDTH,
-		  ((dPitch / Bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
+		  ((dPitch / bytes_per_pixel << DE_WINDOW_WIDTH_DST_SHIFT) &
 		   DE_WINDOW_WIDTH_DST_MASK) |
-		  (sPitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
+		  (sPitch / bytes_per_pixel & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
 
 	if (accel->de_wait() != 0)
 		return -1;
-- 
2.43.0

