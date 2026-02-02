Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6BF37419D
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Feb 2026 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051448; cv=none; b=MwZ/TTBgZIOkrNP1Elclz40YThjvJL/4Ov+RxSGSBmllFnSC0XheMU8ZDHZk/5khJR6yzVgZ5n3n+nG28Q0DoPZWrKHpsJ27/IakvJNTUnuWsB1fblBwGAZs7KlI36PViNv7e8cUH1LpmaY0AEdSkOdU0yqbjb3r8qiwS5aKhZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051448; c=relaxed/simple;
	bh=uZupMsY12grTXtbViH2uDs9GyHCl34p6SlRSawPH9Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irqbQMwj97x+S1jujC4vAoVG1psOYKLhmbik43Af5uckawCvZH65srWkRbTAMPR4VVaS9nn0mhmcC3gXzIlWT2GU7QH59zWaCNkB5LM1IH/ZVvi7Q9g1CzHb6LWQq3gzX5qGIPCCwtr/UihcNWQTgOPFmEAOSRF2BvVAnahj9Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fx7dSiDh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fx7dSiDh"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-482f2599980so18664105e9.0
        for <linux-fbdev@vger.kernel.org>; Mon, 02 Feb 2026 08:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770051445; x=1770656245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INIFCBCUJTQI/9LdXmCI4Y+qu/4cGnWjRRdFLeUHGsM=;
        b=fx7dSiDhUHqV1SIlxrIDFnOhE2pnPgXNVt2eCe5L70QGO5slKYCuu4Jfs0NObQgj20
         bsL/6C5Lq48HlBjpj2ssj+y4sYHaRCkESx6x9qPNXTdDgcp8+Ez5AGWvz53pZNx5DVdv
         qoaECyxR34XYCgz7nylT8uZO0HU9RAnvEtjPvZmBaFt24ipC5JEOuUVqZUDult+KOTTK
         4JjAp+Dn677bIxjk4KRc6BIZ8pIOKRKMghStsuJsIVfV9ZcePQUffbg8NOMXNGML5MOc
         E4fWwxSzZBC9GxftrfWeoCm5MtLyrT/bE1/waUDPAnvoDf+sGM9WWG2nVKPw5XlXH5Dw
         4y4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770051445; x=1770656245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=INIFCBCUJTQI/9LdXmCI4Y+qu/4cGnWjRRdFLeUHGsM=;
        b=Z6UC7/tWahgEQDoRVWGJYymQKvWIBKXKA1FLWkmKYh7tYSo3OtHOAaeViDN9VDIlgC
         UESWuz7cxmFYKFujrqWT+ATGgc3K0i4FbODT59WtmdJXGHVTVq7RWMGBh9DPYFgoMZbh
         BsXrpzBTC4ucLxRv86DY+l5QcYRsHiyGtQ/R22sT9oeQdiD/XQKUV61OHvpCnfoLKXdG
         WTEnSgE8kpcqBI5F2iy10NsvkNcsFeQue6bYOFhPackrhjtSLhX46o+8kPKaJ7FiVdcV
         sMKVvzfKP148m9SzMEIaUXNSbSLDyy7mCmQyz78tZs07N7rOoc4T6nr2i+rxkhjr+egV
         ZMrQ==
X-Gm-Message-State: AOJu0YwTvBIX8JUQwPywcMkpDkLDV7CNQY075jFLRAO45mNqApMc9Tno
	c9a4qmV2hfC0UV5i6gXcw/XYtdWGN7c6fdtMrjlXs+KCuDFrUBTTV3O7
X-Gm-Gg: AZuq6aLxjdpcY2wSySVjcxUlgw0+tSy5CVoaItxqTE+eDpQrdIhS/VMxuk2ERs3DiQF
	mgXnNCN8C4cn4P3SFj74Je/gTVVZaeJbzZSVfekRx5f5oNBd2Hf60lTpwqPrgfo0xNgdvjr03Cg
	+FlTdIDLrO+Smiyu+kjuGTvq6hnZG8jraOhHZlXjVJTJHMBDTHf/RbXVMt78u+Xe248xP16KyFx
	eIglgsfRMhwORtV65tlQsRR8h/xI7TbzdXuvTExyuK9uy5XDTPpvqI1/xB/UojA8AKfxMVlBJeP
	vO2mFrWmgpM1/FM0kvv1HMgv18IBOk3HhG/bh+9omVDqk0XqFY+IwXsE+twrxOUhknhxHMvW0B/
	jlgCH4L20/cuyc/8dMSYuuqmWkg7IOCSXtgX0z9fJxloEiDukSgzvKM5HddyKxdNzLJ6GudK9zH
	nHdrmLiDfzs9NSjGy1zbEAOEv/xhJKqqxJ3ydLoGB9lHUN6EIMWNk=
X-Received: by 2002:a05:600c:354c:b0:47d:5d27:2a7f with SMTP id 5b1f17b1804b1-482db49590bmr155556105e9.26.1770051444643;
        Mon, 02 Feb 2026 08:57:24 -0800 (PST)
Received: from yehudis-VirtualBox.. ([195.60.235.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830511bfc6sm4121875e9.2.2026.02.02.08.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 08:57:24 -0800 (PST)
From: yehudis9982 <y0533159982@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	yehudis9982 <y0533159982@gmail.com>
Subject: [PATCH v2] staging: sm750fb: rename Bpp to bytes_per_pixel
Date: Mon,  2 Feb 2026 18:57:18 +0200
Message-ID: <20260202165719.133879-1-y0533159982@gmail.com>
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

