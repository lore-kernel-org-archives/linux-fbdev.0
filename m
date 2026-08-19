Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E883DA7D7
	for <linux-fbdev@vger.kernel.org>; Wed, 19 Aug 2026 22:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787178540; cv=none; b=ISyBhrsa8JXRR378GLwkZwgx+LlQfMuQG3D8/JOGpiKiBNGgEigbK2sara6b9HQshH/1VpF5Z6VZMaPmyBfbX7ZsrFqm3Fqn7j9IbzM6kME5rj1YNT0aPPybYCYrO3M/NUOkjliWyHFIypLHQ9WaPJUeea8Umap8rm2qpfYsvdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787178540; c=relaxed/simple;
	bh=SOqECmxdvbnN4HB0fatSOol0FpfSI3aw8SkRlLSHP/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cSDQe4Dz47toFGQ4Fq1e1cCOuxsdRWJ0smL79Rt3eRBWzM6GcgoZtY2GBbyszVUnaXcuKLAGtIFwZS3obNDWkjdxsJnqfOmYgVTMQyMXQby/5OGo7NqHGBWgBNcx0BdhbCb3XWdfQ3tsojJrrnuLIJyBFoZBw8YUU3bXJpw4dNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pnN2mSpL; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnN2mSpL"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c998fd549a8so1097193a12.2
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Aug 2026 15:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787178538; x=1787783338; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ak2jmxVCeU+lMeQASQO/CfV20ix4PcHNAD4Nc/Kpacg=;
        b=pnN2mSpL8/uOl6PssoNbEH/4468VWjWVfpNNgZ5Pi/esrNMT2/ApVC5OPKaqtSdApx
         ZP2/ncq5JaF7WWCpjb5BOodEN/LPwP740Ia6RmKiAwNEeEbZhLz0SIZdOefGtwwIjtng
         60AB4U8fAFEh+AZFWK46/vRqAnyl3yPAV1on9aIjbZ5PQr1f/kIJ9Tn+03k0dzbO+qTY
         qudEAlDMwA+IS95wN3+DNg7rw10bcS+HW/luns7azuPQS6+xI6mLSr5Vzoq4/8Nrddx5
         0RCc/No963ILKpLIFSTslBOT3fha9+rtVJUcB3QmLvBhLxiGc1d9OcUBm4kRggcy4H+e
         rF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787178538; x=1787783338;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ak2jmxVCeU+lMeQASQO/CfV20ix4PcHNAD4Nc/Kpacg=;
        b=btrutnQabJgCQgRdc36E1b1vz/cv9uwq0m3FeZrF9qpqk8kCp1lbnfqEYC/WKlCwMr
         yyaIHzyO2rdzp7/ObjHZNvsOZ3XeOcMUSDHj3+oj12cv+N7BelB01PsVTOyE+PcsT0BV
         PCpoJIcmAJ306bPebNL4G65j+ZJccNJZof0uIxWfOm2Wne1B5QBCjn1/QEFV6fD/1MvZ
         pCgF72niqi27vgqiRluGGpNvcEZvzLUzU5/SPbN+tLWL6KhOvcLEMy0xPNcINwlh9Kwe
         nZy1BqdJp0yOqXBwt2BH7rDeySElitFVkUYXB6uFwCuXeW0LElofeYK7rkxtSEk9Qptr
         pGyg==
X-Forwarded-Encrypted: i=1; AHgh+Rrb7YhQljdArGYaOL+z9iPIldRe+ahbr0SvKZ8PC/q6H9Bd7jxDHo4QHPAsolKTPsvAbfPAqCk1PzvMYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy+BKvt8S/ouITZWqp+QzFhX/LxJqD9FaxzpLNx+1/EAk/iogP
	c8AHb8Zn4Tqo30mnRcvvBVO2L06plkblJQEB7MVbBQF9XhQwqyU+D6Eg
X-Gm-Gg: AR+sD13hRCq04vsfLqbVZG72sYhSk5fn+dVLukhh3po1jyVrD+kLAyipw5HsX+ur4wI
	GTIV4ypRq3KFrIWeNuiIWMXDP3B1NYi0pxjW3LmGEUZFBAj3DA5oxSc1l/ZgdCRQ2LnWx/3aF4B
	B5mXWJh5DwDnR6OnWtjAK/1AvSK1bTtpb9oonIxyuyMrofl58O62Oxb84CE9rX1y9I890CvvrL+
	1q1PTWbDjIHMmfIUlA5aqHpxgfR1qrA/QxxkYbK23sUhjdHWE+XvpPAMI5FrJJgedrfQMNT1n92
	A1hPntIbON7WUPVZ8gRYMFQyQOZXu2uMUCoPcGJNv6e0Xdk246jSBL/ohhAlm8taSWhAc+RzEg4
	cHdKOHmc+JPgutJIiYqsz4wW3ncG1A2HhdnIdH8UQm5xnjOa++BQD9CLuHwjpp0mNBLmphQ4Jkj
	nRWRfkgkpPuOcrjEdB/FcZZP9Eq/RZ5v5IFNd+43wVsgvllonYNfzfPt2f2QfjH/l/G6JUmkwW6
	S7+PPOwQqVWAnUKGJ5C2Xut8obZ1onDzfVXhsFBUqj0vGq53w==
X-Received: by 2002:a05:6a20:2d13:b0:3b2:a809:1000 with SMTP id adf61e73a8af0-3cd014aacfemr16987105637.3.1787178538277;
        Wed, 19 Aug 2026 15:28:58 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-59-250-182-adsl.sparkbb.co.nz. [122.59.250.182])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf191821sm9678993eec.28.2026.08.19.15.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 15:28:57 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
	id C13D036057C; Thu, 20 Aug 2026 10:28:52 +1200 (NZST)
From: Michael Schmitz <schmitzmic@gmail.com>
To: linux-m68k@vger.kernel.org,
	geert@linux-m68k.org
Cc: schmitzmic@gmail.com,
	Miro Kropacek <miro.kropacek@gmail.com>,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v3 4/5] fbdev: Add support for SuperVidel's SuperBlitter
Date: Thu, 20 Aug 2026 10:28:37 +1200
Message-Id: <20260819222838.21256-5-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260819222838.21256-1-schmitzmic@gmail.com>
References: <20260819222838.21256-1-schmitzmic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

From: Miro Kropacek <miro.kropacek@gmail.com>

The SuperVidel graphics FPGA includes a hardware blitter (bit block
transfer engine) operating within the SuperVidel DDR2 video RAM.

Two versions of this blitter exist. Later versions (>= 9) of the
SuperVidel firmware support an asynchronous command FIFO, older
versions must be polled for command completion.

Add hardware-accelerated copyarea, fillrect and imageblit fb
operations (falling back to the non-accelerated versions for
anything that exceeds blitter capabilities).

Signed-off-by: Miro Kropacek <miro.kropacek@gmail.com>
Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Cc: <linux-fbdev@vger.kernel.org>
Link: https://lists.debian.org/debian-68k/2026/08/msg00000.html

---

Changes in v3:

- adapt patch to fb_info -> *fb_info rewrite (in patch 2)
---
 drivers/video/fbdev/atafb.c | 197 ++++++++++++++++++++++++++++++++++++
 1 file changed, 197 insertions(+)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index 1a245141560b..1e5724d99b39 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -2303,6 +2303,185 @@ static int ext_detect(struct fb_info *info)
 	return 1;
 }
 
+/* ------------------- SuperVidel SuperBlitter ---------------------- */
+
+/*
+ * Hardware blitter in the SuperVidel FPGA, operating within SV DDR2 RAM.
+ * FW revision >= 9 provides a command FIFO (async operation); older
+ * revisions are programmed directly with busy-polling.
+ */
+#define SVBLIT_REGS_PHYS	0x80010000
+#define SVBLIT_SRC1		0x58	/* bits 26:0 */
+#define SVBLIT_SRC2		0x5c
+#define SVBLIT_DST		0x60
+#define SVBLIT_COUNT		0x64	/* bytes per line - 1 */
+#define SVBLIT_SRC1_OFFSET	0x68	/* line start to next line start */
+#define SVBLIT_SRC2_OFFSET	0x6c
+#define SVBLIT_DST_OFFSET	0x70
+#define SVBLIT_MASK_AND_LINES	0x74	/* bits 11:0: number of lines */
+#define SVBLIT_CONTROL		0x78	/* bit 0: busy/start, bits 4:1: mode */
+#define SVBLIT_VERSION		0x7c	/* bits 9:0: FW revision */
+#define SVBLIT_FIFO		0x80	/* wr: data; rd: bit 0 empty, bit 1 full */
+
+/*
+ * SuperBlitter bug: Instead of declared 2048 bytes, 2032 is the real maximum.
+ */
+#define SVBLIT_MAX_SPAN	2032
+
+static void __iomem *svblit_regs;
+static int svblit_fw;
+
+static inline u32 svblit_rd(unsigned int reg)
+{
+	return __raw_readl(svblit_regs + reg);
+}
+
+static inline void svblit_wr(unsigned int reg, u32 val)
+{
+	__raw_writel(val, svblit_regs + reg);
+}
+
+/* wait until all queued blits have finished */
+static void svblit_wait(void)
+{
+	if (svblit_fw >= 9)
+		/* FIFO empty flag = fewer than 9 longwords queued */
+		while (!(svblit_rd(SVBLIT_FIFO) & 1))
+			cpu_relax();
+	while (svblit_rd(SVBLIT_CONTROL) & 1)
+		cpu_relax();
+}
+
+/*
+ * FW >= 9 queues commands through the 512-longword FIFO: a command is
+ * 9 longwords (registers 0x58..0x78 in order), executed whenever >= 9
+ * words are queued and the blitter is idle. The full flag rises at
+ * >= 500 queued words, so below it there is always room for a whole
+ * command — one flag check per command prevents overflow (dropped
+ * words would desync the 9-word framing until an SV reinit, which is
+ * exactly what overflowing did before this guard existed). Older FW
+ * is programmed directly with busy-polling.
+ *
+ * The line byte count field is 11 bits but see SVBLIT_MAX_SPAN.
+ */
+static void svblit_copy(u32 src, u32 dst, u32 nbytes, u32 src_offset,
+			u32 dst_offset, u32 lines)
+{
+	while (nbytes) {
+		u32 chunk = min(nbytes, SVBLIT_MAX_SPAN);
+
+		if (svblit_fw >= 9) {
+			while (svblit_rd(SVBLIT_FIFO) & 2)
+				cpu_relax();
+			svblit_wr(SVBLIT_FIFO, src);
+			svblit_wr(SVBLIT_FIFO, 0);
+			svblit_wr(SVBLIT_FIFO, dst);
+			svblit_wr(SVBLIT_FIFO, chunk - 1);
+			svblit_wr(SVBLIT_FIFO, src_offset);
+			svblit_wr(SVBLIT_FIFO, 0);
+			svblit_wr(SVBLIT_FIFO, dst_offset);
+			svblit_wr(SVBLIT_FIFO, lines);
+			svblit_wr(SVBLIT_FIFO, 0x01);
+		} else {
+			while (svblit_rd(SVBLIT_CONTROL) & 1)
+				cpu_relax();
+			svblit_wr(SVBLIT_SRC1, src);
+			svblit_wr(SVBLIT_SRC2, 0);
+			svblit_wr(SVBLIT_DST, dst);
+			svblit_wr(SVBLIT_COUNT, chunk - 1);
+			svblit_wr(SVBLIT_SRC1_OFFSET, src_offset);
+			svblit_wr(SVBLIT_SRC2_OFFSET, 0);
+			svblit_wr(SVBLIT_DST_OFFSET, dst_offset);
+			svblit_wr(SVBLIT_MASK_AND_LINES, lines);
+			svblit_wr(SVBLIT_CONTROL, 0x01);
+		}
+
+		src += chunk;
+		dst += chunk;
+		nbytes -= chunk;
+	}
+}
+
+static int svblit_sync(struct fb_info *info)
+{
+	svblit_wait();
+	return 0;
+}
+
+static void svblit_copyarea(struct fb_info *info,
+			    const struct fb_copyarea *area)
+{
+	u32 bytespp = info->var.bits_per_pixel / 8;
+	u32 pitch = info->fix.line_length;
+
+	/*
+	 * The blitter walks lines in ascending order, so overlapping
+	 * moves down/right would read already overwritten data. Those
+	 * are rare for fbcon (scrolling backwards); leave them and
+	 * oversized areas to the CPU.
+	 */
+	if (area->height > 4095 ||
+	    area->dy > area->sy ||
+	    (area->dy == area->sy && area->dx > area->sx)) {
+		svblit_wait();
+		cfb_copyarea(info, area);
+		return;
+	}
+
+	svblit_copy(external_addr + area->sy * pitch + area->sx * bytespp,
+		    external_addr + area->dy * pitch + area->dx * bytespp,
+		    area->width * bytespp, pitch, pitch, area->height);
+	/* async: every CPU access to the fb goes through svblit_wait() */
+}
+
+static void svblit_fillrect(struct fb_info *info,
+			    const struct fb_fillrect *rect)
+{
+	u32 bytespp = info->var.bits_per_pixel / 8;
+	u32 pitch = info->fix.line_length;
+	u8 *line;
+	u32 pix;
+
+	svblit_wait();		/* the CPU is about to touch the fb */
+
+	if (rect->rop != ROP_COPY || rect->height <= 1 ||
+	    rect->height > 4096) {
+		cfb_fillrect(info, rect);
+		return;
+	}
+
+	pix = (info->fix.visual == FB_VISUAL_TRUECOLOR) ?
+		((u32 *)info->pseudo_palette)[rect->color] : rect->color;
+
+	/* draw the first line with the CPU ... */
+	line = (u8 *)info->screen_base + rect->dy * pitch +
+	       rect->dx * bytespp;
+	switch (bytespp) {
+	case 1:
+		memset(line, pix, rect->width);
+		break;
+	case 2:
+		memset16((u16 *)line, pix, rect->width);
+		break;
+	default:
+		memset32((u32 *)line, pix, rect->width);
+		break;
+	}
+
+	/* ... and let the blitter replicate it into the other lines */
+	svblit_copy(external_addr + rect->dy * pitch + rect->dx * bytespp,
+		    external_addr + (rect->dy + 1) * pitch +
+		    rect->dx * bytespp,
+		    rect->width * bytespp, 0, pitch, rect->height - 1);
+}
+
+static void svblit_imageblit(struct fb_info *info,
+			     const struct fb_image *image)
+{
+	svblit_wait();		/* CPU rendering must not race queued blits */
+	cfb_imageblit(info, image);
+}
+
 #endif /* ATAFB_EXT */
 
 /* ------ This is the same for most hardware types -------- */
@@ -3179,6 +3358,24 @@ static int __init atafb_probe(struct platform_device *pdev)
 		phys_screen_base = external_addr;
 		screen_len = external_len & PAGE_MASK;
 		memset (screen_base, 0, external_len);
+
+		/* framebuffer in SV RAM: enable the SuperBlitter */
+		if (external_addr >= 0xa0000000) {
+			svblit_regs = ioremap(SVBLIT_REGS_PHYS, 0x100);
+			if (svblit_regs) {
+				svblit_fw = svblit_rd(SVBLIT_VERSION) & 0x1ff;
+				atafb_ops.fb_fillrect = svblit_fillrect;
+				atafb_ops.fb_copyarea = svblit_copyarea;
+				atafb_ops.fb_imageblit = svblit_imageblit;
+				atafb_ops.fb_sync = svblit_sync;
+				fb_info->flags |= FBINFO_HWACCEL_COPYAREA |
+						  FBINFO_HWACCEL_FILLRECT;
+				dev_info(&pdev->dev,
+					 "SuperBlitter enabled, FW revision %d (%s)\n",
+					 svblit_fw, svblit_fw >= 9 ?
+					 "async FIFO" : "sync");
+			}
+		}
 	}
 #endif /* ATAFB_EXT */
 
-- 
2.17.1

