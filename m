Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927832F7AB0
	for <linux-fbdev@vger.kernel.org>; Sun,  8 Feb 2026 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574538; cv=none; b=RZXHzbEd4B9OQR4gdfwjFvundmkkSZ3aoyWjwcCh/KFM1a5z3fW9h1Rx5j96q1kt0DInDgymAjFu0ksQ7IMp8NNcqSqEmNgNYblNsbOI+mkojA3GxWClDYPmJpEBDF5z3f23lKUUpn0DDgM7x5wwUg9aLgUh2mc4xGtQa3xfe2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574538; c=relaxed/simple;
	bh=FMHtNoOYQycifqi7oWmuu+uY6Lnyzoza1upG7S169js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZX51f01b0KFQbx/A4OFIWGZiZ9YAuu6Y/hFSkWjMioQYSw740vP0w0S+4PrD22ucE64VPdpz9lL/o8qVBgq2/qI33v9K5OIeWyHvvCBkjNEw4PwHvALXnUhJcnOkntYFFVXk5B/z3lzKEtatK4Q89W6KZMQYcJPZJYTlsJy2a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEyojg93; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEyojg93"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b86d3c909dso641260eec.1
        for <linux-fbdev@vger.kernel.org>; Sun, 08 Feb 2026 10:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770574538; x=1771179338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Qb+i/mnLkhYX8n1G5f6iKlMwwPfc6RA0m7NQxeSMqM=;
        b=eEyojg93g6M+56gPbzCoEJwbDDznW4fu7pCrtz91U26fwfWP/8Qoq0DFfjBCUO0IV8
         sGJ/MImVAUEyVo6skuJuYqhuCgVtvbL2/MA9Ke1vrPnkUsjGVRO2vFgsEKdO0GIotpV9
         Rqq5ct/6jO1f909fLJqwT1O/nPlznYARCHLmwF3G/kKcwpyxRC+WY/rS4LEqXGmwfc1L
         3uyxN89BvE3yn6txd0k91VYdhFJV1gqaE3MavKXykcq7R9iVyMXwiOjxqkIu7d2gNf6w
         4fkMfZh6Zlql+GagJX7PYePUsqEEm8qfaZNUByBQ07crRI+RZtWnCMdjjuf26ON1iEAK
         Xklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770574538; x=1771179338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Qb+i/mnLkhYX8n1G5f6iKlMwwPfc6RA0m7NQxeSMqM=;
        b=OQqKoYLeYZ1YKun2r7xFla0mE6e8NnNOQEJJslx4Y7DGIGzrTebYVEdwBOPoa++eCj
         G3++wqnqPJNMvjaT+W5yBrXaTseeWAXx7q88uF3Z6tJy1bAcduASkmZM8yGtRSmb3s2H
         mEd/vJEowpOPCn2NkKORro3oEJShFii4oNTHn8subSY/rNbAGpeCmeGg8pBt8fiDBy5d
         fE8T7ElxeZWvWdmKmcizd5pcoRx4o/41+gsnemZpq/dsEXEZlfvl0leO/r+vhm+htguS
         cDdRVDVmdPxd195qgqxva92m4qt/TynprjCoZIiVDrm8oIp3rS565ipgyX7XuVjcMUXJ
         JWQQ==
X-Gm-Message-State: AOJu0YyF5mCIO/qUm99sr9md1vm1lij+OTkA9cJYxo07ghn6B3T1AJA2
	OtBAJEOA5AASy30L6OtaBjRdaOcVrfoJrTR+eQoPXDLA4ekMdl0ov3k=
X-Gm-Gg: AZuq6aLY7nCaPit0GQuqXFszc/ypX1vnopSMNq4MZIZyysxrz/tqdgWXw4IhrZOcabs
	5US+OwLV8oAvmXPTQjQJW8hZyTWIQdtSM1Q0eflzGekEEjo7S80aOjaGgduuZR7IgqXkvbFh1X3
	HTMVnagcZV+ECaN8saZWe7+uKc7YeSYhRJdZ2/DC88LvqX874i2xWLNxz+wR9uRBSvsdb9iNi8C
	4n+QnEUxfGzm75V7kP3PcGlYELFRHwUfJxvuVfYfHJjgERp5h5roQ8pBKHF/i2D9XW5aQBOceoY
	RPW08ddp4jqeM3CKplB8uckaPn6dSd+hsRMEZZu7whWIxfuG4S/fqEOiNUV7k2/j+IFy3mSyfu3
	LmBmDRXKfYbPJM1YBf3ZX4tSMxeTf/2iE3cEND5tWQj5a9HdUSCxJidiwWxqfFurSlpj4u7oiKD
	/zfKKrYLptAE3C3Eq/q7pAwzY=
X-Received: by 2002:a05:7022:31a:b0:124:9fd8:4ba2 with SMTP id a92af1059eb24-12703f3c85bmr4156509c88.9.1770574537541;
        Sun, 08 Feb 2026 10:15:37 -0800 (PST)
Received: from arch ([2601:647:6980:8130::7378])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1270c9ff2bcsm6185521c88.1.2026.02.08.10.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 10:15:36 -0800 (PST)
From: Shreyas Ravi <shreyasravi320@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shreyas Ravi <shreyasravi320@gmail.com>
Subject: [PATCH v3 2/2] staging: sm750fb: remove Hungarian notation prefixes
Date: Sun,  8 Feb 2026 10:15:31 -0800
Message-ID: <20260208181531.157553-2-shreyasravi320@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260208181531.157553-1-shreyasravi320@gmail.com>
References: <2026020842-litigator-flatworm-65d0@gregkh>
 <20260208181531.157553-1-shreyasravi320@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove Hungarian notation prefixes from variable names to comply
with kernel coding style.

No functional changes.

Signed-off-by: Shreyas Ravi <shreyasravi320@gmail.com>
---
Changes in v3:
- Added changelog (was missing in v2)
- Split original patch into two patches per Greg's feedback
- This patch addresses Hungarian prefix removal
---
 drivers/staging/sm750fb/sm750.c       | 22 +++----
 drivers/staging/sm750fb/sm750.h       |  6 +-
 drivers/staging/sm750fb/sm750_accel.c | 82 +++++++++++++--------------
 drivers/staging/sm750fb/sm750_accel.h |  2 +-
 drivers/staging/sm750fb/sm750_hw.c    | 20 +++----
 5 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 1ed7ff57c142..afcfc9e6c207 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -624,27 +624,27 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_primary;
 		crtc->o_screen = 0;
-		crtc->v_screen = sm750_dev->p_v_mem;
+		crtc->v_screen = sm750_dev->v_mem;
 		pr_info("use simul primary mode\n");
 		break;
 	case sm750_simul_sec:
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_secondary;
 		crtc->o_screen = 0;
-		crtc->v_screen = sm750_dev->p_v_mem;
+		crtc->v_screen = sm750_dev->v_mem;
 		break;
 	case sm750_dual_normal:
 		if (par->index == 0) {
 			output->paths = sm750_panel;
 			crtc->channel = sm750_primary;
 			crtc->o_screen = 0;
-			crtc->v_screen = sm750_dev->p_v_mem;
+			crtc->v_screen = sm750_dev->v_mem;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_secondary;
 			/* not consider of padding stuffs for o_screen,need fix */
 			crtc->o_screen = sm750_dev->vidmem_size >> 1;
-			crtc->v_screen = sm750_dev->p_v_mem + crtc->o_screen;
+			crtc->v_screen = sm750_dev->v_mem + crtc->o_screen;
 		}
 		break;
 	case sm750_dual_swap:
@@ -652,7 +652,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 			output->paths = sm750_panel;
 			crtc->channel = sm750_secondary;
 			crtc->o_screen = 0;
-			crtc->v_screen = sm750_dev->p_v_mem;
+			crtc->v_screen = sm750_dev->v_mem;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_primary;
@@ -660,7 +660,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 			 * need fix
 			 */
 			crtc->o_screen = sm750_dev->vidmem_size >> 1;
-			crtc->v_screen = sm750_dev->p_v_mem + crtc->o_screen;
+			crtc->v_screen = sm750_dev->v_mem + crtc->o_screen;
 		}
 		break;
 	default:
@@ -764,14 +764,14 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	 * must be set after crtc member initialized
 	 */
 	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
-	crtc->cursor.mmio = sm750_dev->p_v_reg +
+	crtc->cursor.mmio = sm750_dev->v_reg +
 		0x800f0 + (int)crtc->channel * 0x140;
 
 	pr_info("crtc->cursor.mmio = %p\n", crtc->cursor.mmio);
 	crtc->cursor.max_h = 64;
 	crtc->cursor.max_w = 64;
 	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
-	crtc->cursor.vstart = sm750_dev->p_v_mem + crtc->cursor.offset;
+	crtc->cursor.vstart = sm750_dev->v_mem + crtc->cursor.offset;
 
 	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
 	if (!g_hwcursor)
@@ -1090,7 +1090,7 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 		sm750_dev->mtrr.vram = arch_phys_wc_add(sm750_dev->vidmem_start,
 							sm750_dev->vidmem_size);
 
-	memset_io(sm750_dev->p_v_mem, 0, sm750_dev->vidmem_size);
+	memset_io(sm750_dev->v_mem, 0, sm750_dev->vidmem_size);
 
 	pci_set_drvdata(pdev, sm750_dev);
 
@@ -1121,8 +1121,8 @@ static void lynxfb_pci_remove(struct pci_dev *pdev)
 	sm750fb_framebuffer_release(sm750_dev);
 	arch_phys_wc_del(sm750_dev->mtrr.vram);
 
-	iounmap(sm750_dev->p_v_reg);
-	iounmap(sm750_dev->p_v_mem);
+	iounmap(sm750_dev->v_reg);
+	iounmap(sm750_dev->v_mem);
 	kfree(g_settings);
 }
 
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 14e0e7d75f7e..077dde6d6113 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -72,7 +72,7 @@ struct lynx_accel {
 			   u32 width, u32 height,
 			   u32 rop2);
 
-	int (*de_imageblit)(struct lynx_accel *accel, const char *p_srcbuf,
+	int (*de_imageblit)(struct lynx_accel *accel, const char *srcbuf,
 			    u32 src_delta, u32 start_bit, u32 d_base, u32 d_pitch,
 			    u32 byte_per_pixel, u32 dx, u32 dy, u32 width,
 			    u32 height, u32 f_color, u32 b_color, u32 rop2);
@@ -97,8 +97,8 @@ struct sm750_dev {
 	unsigned long vidreg_start;
 	__u32 vidmem_size;
 	__u32 vidreg_size;
-	void __iomem *p_v_reg;
-	unsigned char __iomem *p_v_mem;
+	void __iomem *v_reg;
+	unsigned char __iomem *v_mem;
 	/* locks*/
 	spinlock_t slock;
 
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 4dd9b910af13..dbc1c266cf4a 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -134,22 +134,22 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
  * @accel: Acceleration device data
  * @source_base: Address of source: offset in frame buffer
  * @source_pitch: Pitch value of source surface in BYTE
- * @sx: Starting x coordinate of source surface
- * @sy: Starting y coordinate of source surface
+ * @source_x: Starting x coordinate of source surface
+ * @source_y: Starting y coordinate of source surface
  * @dest_base: Address of destination: offset in frame buffer
  * @dest_pitch: Pitch value of destination surface in BYTE
  * @bytes_per_pixel: Color depth of destination surface
- * @dx: Starting x coordinate of destination surface
- * @dy: Starting y coordinate of destination surface
+ * @dest_x: Starting x coordinate of destination surface
+ * @dest_y: Starting y coordinate of destination surface
  * @width: width of rectangle in pixel value
  * @height: height of rectangle in pixel value
  * @rop2: ROP value
  */
 int sm750_hw_copyarea(struct lynx_accel *accel,
 		      unsigned int source_base, unsigned int source_pitch,
-		      unsigned int sx, unsigned int sy,
+		      unsigned int source_x, unsigned int source_y,
 		      unsigned int dest_base, unsigned int dest_pitch,
-		      unsigned int bytes_per_pixel, unsigned int dx, unsigned int dy,
+		      unsigned int bytes_per_pixel, unsigned int dest_x, unsigned int dest_y,
 		      unsigned int width, unsigned int height,
 		      unsigned int rop2)
 {
@@ -162,7 +162,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	/* If source and destination are the same surface, need to check for overlay cases */
 	if (source_base == dest_base && source_pitch == dest_pitch) {
 		/* Determine direction of operation */
-		if (sy < dy) {
+		if (source_y < dest_y) {
 			/*  +----------+
 			 *  |S         |
 			 *  |   +----------+
@@ -174,7 +174,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 			 */
 
 			n_direction = BOTTOM_TO_TOP;
-		} else if (sy > dy) {
+		} else if (source_y > dest_y) {
 			/*  +----------+
 			 *  |D         |
 			 *  |   +----------+
@@ -189,7 +189,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		} else {
 			/* sy == dy */
 
-			if (sx <= dx) {
+			if (source_x <= dest_x) {
 				/* +------+---+------+
 				 * |S     |   |     D|
 				 * |      |   |      |
@@ -200,7 +200,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 
 				n_direction = RIGHT_TO_LEFT;
 			} else {
-			/* sx > dx */
+			/* source_x > dest_x */
 
 				/* +------+---+------+
 				 * |D     |   |     S|
@@ -216,10 +216,10 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	}
 
 	if ((n_direction == BOTTOM_TO_TOP) || (n_direction == RIGHT_TO_LEFT)) {
-		sx += width - 1;
-		sy += height - 1;
-		dx += width - 1;
-		dy += height - 1;
+		source_x += width - 1;
+		source_y += height - 1;
+		dest_x += width - 1;
+		dest_y += height - 1;
 	}
 
 	/*
@@ -267,11 +267,11 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		return -1;
 
 	write_dpr(accel, DE_SOURCE,
-		  ((sx << DE_SOURCE_X_K1_SHIFT) & DE_SOURCE_X_K1_MASK) |
-		  (sy & DE_SOURCE_Y_K2_MASK)); /* dpr0 */
+		  ((source_x << DE_SOURCE_X_K1_SHIFT) & DE_SOURCE_X_K1_MASK) |
+		  (source_y & DE_SOURCE_Y_K2_MASK)); /* dpr0 */
 	write_dpr(accel, DE_DESTINATION,
-		  ((dx << DE_DESTINATION_X_SHIFT) & DE_DESTINATION_X_MASK) |
-		  (dy & DE_DESTINATION_Y_MASK)); /* dpr04 */
+		  ((dest_x << DE_DESTINATION_X_SHIFT) & DE_DESTINATION_X_MASK) |
+		  (dest_y & DE_DESTINATION_Y_MASK)); /* dpr04 */
 	write_dpr(accel, DE_DIMENSION,
 		  ((width << DE_DIMENSION_X_SHIFT) & DE_DIMENSION_X_MASK) |
 		  (height & DE_DIMENSION_Y_ET_MASK)); /* dpr08 */
@@ -299,38 +299,38 @@ static unsigned int de_get_transparency(struct lynx_accel *accel)
 /**
  * sm750_hw_imageblit
  * @accel: Acceleration device data
- * @p_srcbuf: pointer to start of source buffer in system memory
- * @src_delta: Pitch value (in bytes) of the source buffer, +ive means top down
- *	      and -ive mean button up
+ * @srcbuf: pointer to start of source buffer in system memory
+ * @src_delta: Pitch value (in bytes) of the source buffer, positive means top down
+ *	      and negative mean bottom up
  * @start_bit: Mono data can start at any bit in a byte, this value should be
  *	      0 to 7
  * @dest_base: Address of destination: offset in frame buffer
  * @dest_pitch: Pitch value of destination surface in BYTE
  * @byte_per_pixel: Color depth of destination surface
- * @dx: Starting x coordinate of destination surface
- * @dy: Starting y coordinate of destination surface
+ * @dest_x: Starting x coordinate of destination surface
+ * @dest_y: Starting y coordinate of destination surface
  * @width: width of rectangle in pixel value
  * @height: height of rectangle in pixel value
  * @fg_color: Foreground color (corresponding to a 1 in the monochrome data
  * @bg_color: Background color (corresponding to a 0 in the monochrome data
  * @rop2: ROP value
  */
-int sm750_hw_imageblit(struct lynx_accel *accel, const char *p_srcbuf,
+int sm750_hw_imageblit(struct lynx_accel *accel, const char *srcbuf,
 		       u32 src_delta, u32 start_bit, u32 dest_base, u32 dest_pitch,
-		       u32 byte_per_pixel, u32 dx, u32 dy, u32 width,
+		       u32 byte_per_pixel, u32 dest_x, u32 dest_y, u32 width,
 		       u32 height, u32 fg_color, u32 bg_color, u32 rop2)
 {
-	unsigned int ul_bytes_per_scan;
-	unsigned int ul_4_bytes_per_scan;
-	unsigned int ul_bytes_remain;
+	unsigned int bytes_per_scan;
+	unsigned int four_bytes_per_scan;
+	unsigned int bytes_remain;
 	unsigned int de_ctrl = 0;
-	unsigned char aj_remain[4];
+	unsigned char remaining_bytes[4];
 	int i, j;
 
 	start_bit &= 7; /* Just make sure the start bit is within legal range */
-	ul_bytes_per_scan = (width + start_bit + 7) / 8;
-	ul_4_bytes_per_scan = ul_bytes_per_scan & ~3;
-	ul_bytes_remain = ul_bytes_per_scan & 3;
+	bytes_per_scan = (width + start_bit + 7) / 8;
+	four_bytes_per_scan = bytes_per_scan & ~3;
+	bytes_remain = bytes_per_scan & 3;
 
 	if (accel->de_wait() != 0)
 		return -1;
@@ -377,8 +377,8 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *p_srcbuf,
 		  DE_SOURCE_X_K1_MONO_MASK); /* dpr00 */
 
 	write_dpr(accel, DE_DESTINATION,
-		  ((dx << DE_DESTINATION_X_SHIFT) & DE_DESTINATION_X_MASK) |
-		  (dy & DE_DESTINATION_Y_MASK)); /* dpr04 */
+		  ((dest_x << DE_DESTINATION_X_SHIFT) & DE_DESTINATION_X_MASK) |
+		  (dest_y & DE_DESTINATION_Y_MASK)); /* dpr04 */
 
 	write_dpr(accel, DE_DIMENSION,
 		  ((width << DE_DIMENSION_X_SHIFT) & DE_DIMENSION_X_MASK) |
@@ -396,16 +396,16 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *p_srcbuf,
 	/* Write MONO data (line by line) to 2D Engine data port */
 	for (i = 0; i < height; i++) {
 		/* For each line, send the data in chunks of 4 bytes */
-		for (j = 0; j < (ul_4_bytes_per_scan / 4); j++)
-			write_dp_port(accel, *(unsigned int *)(p_srcbuf + (j * 4)));
+		for (j = 0; j < (four_bytes_per_scan / 4); j++)
+			write_dp_port(accel, *(unsigned int *)(srcbuf + (j * 4)));
 
-		if (ul_bytes_remain) {
-			memcpy(aj_remain, p_srcbuf + ul_4_bytes_per_scan,
-			       ul_bytes_remain);
-			write_dp_port(accel, *(unsigned int *)aj_remain);
+		if (bytes_remain) {
+			memcpy(remaining_bytes, srcbuf + four_bytes_per_scan,
+			       bytes_remain);
+			write_dp_port(accel, *(unsigned int *)remaining_bytes);
 		}
 
-		p_srcbuf += src_delta;
+		srcbuf += src_delta;
 	}
 
 	return 0;
diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index 59e679961e96..00a6a022e17e 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -235,7 +235,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
  * @bg_color: Background color (corresponding to a 0 in the monochrome data
  * @rop2: ROP value
  */
-int sm750_hw_imageblit(struct lynx_accel *accel, const char *p_srcbuf,
+int sm750_hw_imageblit(struct lynx_accel *accel, const char *srcbuf,
 		       u32 src_delta, u32 start_bit, u32 dest_base, u32 dest_pitch,
 		       u32 byte_per_pixel, u32 dx, u32 dy, u32 width,
 		       u32 height, u32 fg_color, u32 bg_color, u32 rop2);
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 4e2ca7263254..b8bc55ba3c54 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -49,19 +49,19 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	}
 
 	/* now map mmio and vidmem */
-	sm750_dev->p_v_reg =
+	sm750_dev->v_reg =
 		ioremap(sm750_dev->vidreg_start, sm750_dev->vidreg_size);
-	if (!sm750_dev->p_v_reg) {
+	if (!sm750_dev->v_reg) {
 		pr_err("mmio failed\n");
 		ret = -EFAULT;
 		goto exit;
 	}
-	pr_info("mmio virtual addr = %p\n", sm750_dev->p_v_reg);
+	pr_info("mmio virtual addr = %p\n", sm750_dev->v_reg);
 
-	sm750_dev->accel.dpr_base = sm750_dev->p_v_reg + DE_BASE_ADDR_TYPE1;
-	sm750_dev->accel.dp_port_base = sm750_dev->p_v_reg + DE_PORT_ADDR_TYPE1;
+	sm750_dev->accel.dpr_base = sm750_dev->v_reg + DE_BASE_ADDR_TYPE1;
+	sm750_dev->accel.dp_port_base = sm750_dev->v_reg + DE_PORT_ADDR_TYPE1;
 
-	mmio750 = sm750_dev->p_v_reg;
+	mmio750 = sm750_dev->v_reg;
 	sm750_set_chip_type(sm750_dev->devid, sm750_dev->revid);
 
 	sm750_dev->vidmem_start = pci_resource_start(pdev, 0);
@@ -76,15 +76,15 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		sm750_dev->vidmem_start, sm750_dev->vidmem_size);
 
 	/* reserve the vidmem space of smi adaptor */
-	sm750_dev->p_v_mem =
+	sm750_dev->v_mem =
 		ioremap_wc(sm750_dev->vidmem_start, sm750_dev->vidmem_size);
-	if (!sm750_dev->p_v_mem) {
-		iounmap(sm750_dev->p_v_reg);
+	if (!sm750_dev->v_mem) {
+		iounmap(sm750_dev->v_reg);
 		pr_err("Map video memory failed\n");
 		ret = -EFAULT;
 		goto exit;
 	}
-	pr_info("video memory vaddr = %p\n", sm750_dev->p_v_mem);
+	pr_info("video memory vaddr = %p\n", sm750_dev->v_mem);
 exit:
 	return ret;
 }
-- 
2.53.0

