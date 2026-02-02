Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DB13806CC
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Feb 2026 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770052373; cv=none; b=FlAF4ZcYxw3Na1tg3BJiggC75zCl5ZAtNwRGviijnz9xoinlGArxxnTzv/iEyQw6AAjJpKLh0XgqFhRdU0hTJnLRz4tLFoSqg3M1FqGbXL5o0vsjeysCBsN66n0ZexWm9TK9//YQSBfwJC1Rv1Xs2PGz/MDm/u9dnO+epTg7XeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770052373; c=relaxed/simple;
	bh=uZupMsY12grTXtbViH2uDs9GyHCl34p6SlRSawPH9Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJEC0zM8bYieY4+EzAXuYgE2l9fvbsADHs4Fybw/JD8pRSOIvqJaaLY/d+E9rhdeSctR0gMsEYnmsBnRUmX8DQ1+mD+rOQHCz3W77zMWcsezl9O7y9uVo7NgtZP2LK3E2AO/6109IQmd2B31ExthUqdvE/op0sxbnHo5Tj/MVIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpEhW3s3; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpEhW3s3"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fb6ce71c7so3871679f8f.1
        for <linux-fbdev@vger.kernel.org>; Mon, 02 Feb 2026 09:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770052370; x=1770657170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INIFCBCUJTQI/9LdXmCI4Y+qu/4cGnWjRRdFLeUHGsM=;
        b=VpEhW3s3q8CXQ1MdnVz7KOHVc/ly5M4bBlKlRCrnhtrYIM+lof/KYvrRie0RqDEnvv
         lPmWZ3au/rUn164f/xJ9QWSZJUvjTRWb6t09qHf7Dmwq9cFPN9xMTT7TGKXp5O89MTew
         HU8BmzKZXgHcyqgVWaltVoui2WC33fVlAaz4OtzXVWew1NTkwEfucXoutID7OPlYZUnu
         6ymwak7clDoJ0jQrrtj+pHVOCf1PyWJ0cdSkGAZoJY79MYJ9+WFMgpKLQ8M89P/XrbrG
         CCKxC3sYSsVLZ/jlCaE3PjZKxJ6X0DRs0Vt1h9Ptpy5yULWeIBSCkxaDYQQXfNDGGvwX
         hxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770052370; x=1770657170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=INIFCBCUJTQI/9LdXmCI4Y+qu/4cGnWjRRdFLeUHGsM=;
        b=YvUWtd6kR5Ug3FjjtkWnp0LTwFJC4vRktsHsor/T8GWel4hspHg1+6Hzo2wb4vuSUH
         4eF2rbpjvJuV2GA8jbx1iy0BuBMpZSQ4cqWUYZ2TFTiFjnsbHOTpbJE5GG6JOUa7mEvA
         C0Eitbsg2+NJ86a2gZRejeRoQusM7NHhdyM1QuHoQWU8fbnQrmbvEA43L2lUndNm7uhb
         gN0XZ3jqVEM+6TE19REIPiZJW44VvB5c4qJbDlF4IAR/cdUUgw7xxrwBo1If25+hkds4
         ttWcJle6Rf92VC5EyCj3vAkmIw29AgVGaczttXKyS5mORtg0qhZsT+NJ+2e5AFVDyXX9
         Fdog==
X-Gm-Message-State: AOJu0Yy1IckEOj/JecbfniNo9xGVbNe3Gp3pFRBRnAlH8F0DW/9bLSHk
	KCaoPNA9B6sdCDPIquAQnKwlwh/zFDCyvavFdVs3xQXDMD5yXUFlmldk
X-Gm-Gg: AZuq6aI2XY1HDCGxMKoKZYtmAoGZoJoDrI/KjwzlAq0D3OuCVbig0V43Rs+g/paL+ev
	grUKAULY2F4isxwS/BngMW+g3ATtRNc9cVcTGd26NcZkDbstVXhFUvA/KymavXXvpx91LTiqdK6
	oZoUOrcTvtNGQ6GUfrxxNb53WzLRsTFYA9kL5416SvJpHkOU2DvMTbecZKso1vWuy6uRhwTa/rW
	pao/J6/i7N6FWK64rsG2yL3yaE2mzNnmlg8Nt3B0JNN7JsY5xUw54r8B7X76qvkg98L9Mc41PMn
	cuK6eXR+EalZl6s4K4Ve8WPqoIdyaOLVyLOvyoy0shbltw2a4BZtjkWghhv7QRTYyRPg+zMohVd
	ndpJ65x/nj9QIGdiTeGla9aPGEflkYo2m05g2juUVL+9hCciySGW6sNre5dyx+0jBN9eWq4BLoy
	eY4vmDAiUv36R8O6VenVnnnyicDupcGGMSaCwOgcAoik2vzxXWoVQ=
X-Received: by 2002:a5d:64c7:0:b0:431:62:d946 with SMTP id ffacd0b85a97d-435f3a7bafdmr16924187f8f.23.1770052369703;
        Mon, 02 Feb 2026 09:12:49 -0800 (PST)
Received: from yehudis-VirtualBox.. ([195.60.235.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131cefdsm46308792f8f.23.2026.02.02.09.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 09:12:49 -0800 (PST)
From: yehudis9982 <y0533159982@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	yehudis9982 <y0533159982@gmail.com>
Subject: [PATCH v2] staging: sm750fb: rename Bpp to bytes_per_pixel
Date: Mon,  2 Feb 2026 19:12:43 +0200
Message-ID: <20260202171243.133935-1-y0533159982@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026020201-monogamy-sash-4866@gregkh>
References: <2026020201-monogamy-sash-4866@gregkh>
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

