Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A081DE2A5
	for <linux-fbdev@vger.kernel.org>; Sun, 19 Jul 2026 06:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784443605; cv=none; b=iY90G02zRiOl+95GF6z+ibUsWkeE7K7e097m1yqGe0z72IzCm3OK54zLESOztz8FWzROi0x+/fSjsrJooojf5wHeev/r77dyUU+LiTaEeCgopBL8tCqfF7uqw7/JPE95IX8M8bd3/7lGtGTkzZdhf3KjZOL/aNKxWj3y3b4Ef7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784443605; c=relaxed/simple;
	bh=fnnC+vlyEjUrD9X16zPRa2oHzbXWLC7N3ScazD4URT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BbX18RzfTL3KXe9AtaTiFpPVaPwpJKX6kAjs303LzBoElQqNEDAHJs5ApFprvdTXxe8LF5FCSTBG/GcX8M6jeB/Cb78bey0M/gqEUI3DwRFtPD2C7YWFuFd7znqakhlJ+4zlch89xmFwilp7FeQM7807IV7cHS9X0bFJdCSrGuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sd7ruUKU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sd7ruUKU"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc97653887so101168405ad.1
        for <linux-fbdev@vger.kernel.org>; Sat, 18 Jul 2026 23:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784443603; x=1785048403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X9y4maNSu9c0ZLymsFbxk/rrYyHzr8mr1Czws/Zz3XA=;
        b=sd7ruUKUSkubLsvEylGVaB1WszSbP5pYrymsvTguYBZMjUirteVp82QXM4wVgiUVtR
         exHiGJaE9Q9+y1duha2CIG9ZBcEmciuFwo60QUUyqg63uiQVXRT98g3sGPkFu7jyWIBM
         DfTZ3CLGR3ksl5Rlm5HKvmgIbmM5gqeW0e7Uz2YHaHWgewvVVF23djyrQqQydG0bKoGS
         o5jMjm/Any0MxPYPyyKYXk0LkU4wVS4S9QoVoWY3jPfgd7gQeKTgmQP6qicR+xGB6fd7
         g6+dHMOKPExobE/hcF3myUVzYjFuVSGLO/sh7XLtwku8SkuzklOaDQYdM7bUnIbk+3kU
         8CCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784443603; x=1785048403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X9y4maNSu9c0ZLymsFbxk/rrYyHzr8mr1Czws/Zz3XA=;
        b=Hy92gUTxnUOUs1rLNNIBS6J3bFEAvUmqa18aGWx0A50R4IT6s3KBOiDYlNkLrGofin
         hzcMjuylvYCmQo+flBeH7Fzca3Y+udbmZf7ldCxux/R0d8jR0dLKwc+204ucrlSQOGqc
         Xb2vC2wXzz3wAMg6vkho6Az9l5xsH5w7i4PVxclKPsPXymuLzGCjN/ANkk7HxS3r4mKa
         EKTxPMROVkIF9DUAS+PG/XD+U9Hhx0iRvL/jbVscsvWuDYcnnjqQzXblgCIfPRuXy4Fv
         LvKWcIkiPVfVMNNw9Gm0dd2KPYTZZ1cdLl1b/cOyNb+DKiBxP+xeqWKrukOj9m4c4+Ej
         hqiw==
X-Gm-Message-State: AOJu0Yyu4JjLGtF9uz79vzhJXaUfAi+BM8vz8BnFF0AMsmihNZM2WvTo
	1rXO/XbYEQ5L91/woMJ53oEADAIRLImnDinlXjB16EOtzx5QRButmruJZ6nv8hnh
X-Gm-Gg: AfdE7cnE4xkIpLH0UW18Pbj8/s/ThDQvLHIeQEeQpfPqa8pMiH3LBmVXJNAUHN8lTeX
	HoUG2F09EjHwK7dLYLur6OimjCjjhU3Pw1onbdMBGacQu5AR/ItykTkEZ/TMZKb2zyBjK4dOOtN
	YSeF2qki4CkgmBfMujzmjfPKR55W5idYegfN3ZXlnmNghCU6jvdZOjN4ws/fiisWar+87kZxeXi
	MWhSI8DFnO2US0F7OELUbQcaELmu7t1affpa1dMmfYG4247/DYmCtjJgEg2IGcZHjaJi23+TDlA
	55GMaFqZI0sH3A5xnDy+DdnkwWiGfkKi+gjAItXwelZRahIV/Anblkn2ZO/V+9AFUQqgdGLLub/
	4oL8DGRH/xj2gIgq90PQyOvw0LNcx1IDB7XV8hiFmdxyu/HUOyasKprqf+54ENX5055L41hMg6X
	Kh3XoMEN5kg0+oncK3hqDNojIucQ7vgj4TWwi3ccHZgK0nBuTrvGnv6PLuTHFoyZq7+aGpggQUv
	ctCYeLA262FkbfpSlRGXgdulNVoFvM6xfhvmnYqCzAer4Vz3vsDc1zE
X-Received: by 2002:a17:903:2a8b:b0:2c2:bd0d:3cf0 with SMTP id d9443c01a7336-2cf3497f5dfmr105825405ad.25.1784443603113;
        Sat, 18 Jul 2026 23:46:43 -0700 (PDT)
Received: from localhost.localdomain (c-67-170-60-64.hsd1.wa.comcast.net. [67.170.60.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3474692asm37073735ad.70.2026.07.18.23.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 23:46:42 -0700 (PDT)
From: Gabriel Changamire <gaberashawn@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gabriel Changamire <gaberashawn@gmail.com>
Subject: [PATCH] staging: sm750fb: rename CamelCase parameters in sm750_accel.h
Date: Sun, 19 Jul 2026 06:46:01 +0000
Message-ID: <20260719064601.12223-1-gaberashawn@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The prototypes and kernel-doc comments for sm750_hw_copyarea() and
sm750_hw_imageblit() still use the old CamelCase parameter names,
while the function definitions in sm750_accel.c already use
snake_case. Rename the header parameters to match the definitions.

Fixes 10 checkpatch "Avoid CamelCase" checks. No functional change.

Signed-off-by: Gabriel Changamire <gaberashawn@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.h | 36 +++++++++++++--------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index d15a40cacb84..3d3d93d4b308 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -196,12 +196,12 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 
 /**
  * sm750_hm_copyarea
- * @sBase: Address of source: offset in frame buffer
- * @sPitch: Pitch value of source surface in BYTE
+ * @source_base: Address of source: offset in frame buffer
+ * @source_pitch: Pitch value of source surface in BYTE
  * @sx: Starting x coordinate of source surface
  * @sy: Starting y coordinate of source surface
- * @dBase: Address of destination: offset in frame buffer
- * @dPitch: Pitch value of destination surface in BYTE
+ * @dest_base: Address of destination: offset in frame buffer
+ * @dest_pitch: Pitch value of destination surface in BYTE
  * @bpp: Color depth of destination surface
  * @dx: Starting x coordinate of destination surface
  * @dy: Starting y coordinate of destination surface
@@ -210,34 +210,34 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
  * @rop2: ROP value
  */
 int sm750_hw_copyarea(struct lynx_accel *accel,
-		      unsigned int sBase, unsigned int sPitch,
+		      unsigned int source_base, unsigned int source_pitch,
 		      unsigned int sx, unsigned int sy,
-		      unsigned int dBase, unsigned int dPitch,
+		      unsigned int dest_base, unsigned int dest_pitch,
 		      unsigned int bpp, unsigned int dx, unsigned int dy,
 		      unsigned int width, unsigned int height,
 		      unsigned int rop2);
 
 /**
  * sm750_hw_imageblit
- * @pSrcbuf: pointer to start of source buffer in system memory
- * @srcDelta: Pitch value (in bytes) of the source buffer, +ive means top down
+ * @src_buf: pointer to start of source buffer in system memory
+ * @src_delta: Pitch value (in bytes) of the source buffer, +ive means top down
  *>-----      and -ive mean button up
- * @startBit: Mono data can start at any bit in a byte, this value should be
+ * @start_bit: Mono data can start at any bit in a byte, this value should be
  *>-----      0 to 7
- * @dBase: Address of destination: offset in frame buffer
- * @dPitch: Pitch value of destination surface in BYTE
- * @bytePerPixel: Color depth of destination surface
+ * @dest_base: Address of destination: offset in frame buffer
+ * @dest_pitch: Pitch value of destination surface in BYTE
+ * @byte_per_pixel: Color depth of destination surface
  * @dx: Starting x coordinate of destination surface
  * @dy: Starting y coordinate of destination surface
  * @width: width of rectangle in pixel value
  * @height: height of rectangle in pixel value
- * @fColor: Foreground color (corresponding to a 1 in the monochrome data
- * @bColor: Background color (corresponding to a 0 in the monochrome data
+ * @fg_color: Foreground color (corresponding to a 1 in the monochrome data
+ * @bg_color: Background color (corresponding to a 0 in the monochrome data
  * @rop2: ROP value
  */
-int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
-		       u32 srcDelta, u32 startBit, u32 dBase, u32 dPitch,
-		       u32 bytePerPixel, u32 dx, u32 dy, u32 width,
-		       u32 height, u32 fColor, u32 bColor, u32 rop2);
+int sm750_hw_imageblit(struct lynx_accel *accel, const char *src_buf,
+		       u32 src_delta, u32 start_bit, u32 dest_base, u32 dest_pitch,
+		       u32 byte_per_pixel, u32 dx, u32 dy, u32 width,
+		       u32 height, u32 fg_color, u32 bg_color, u32 rop2);
 
 #endif
-- 
2.47.3

