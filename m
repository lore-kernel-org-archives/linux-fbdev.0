Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5143D5246
	for <linux-fbdev@vger.kernel.org>; Sun, 16 Aug 2026 07:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786865886; cv=none; b=KdoTIqxpzeoXcW6bAbLII6ae+PB7AzakGTF6wp9WX5PQYg9gF3bNuLKhJCpZoKMJ4zat0uSeTie1+mVsAFdkQenaLG4VDhOsnn9PFY0dorSZ5YIcOsp47JtLFyOozZwwkDoivwhOiXWOQtBg6OwMceBIzhLQ19OYzMD94MoLkbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786865886; c=relaxed/simple;
	bh=eeWVDwEacRSJnz7aoqjRiOchVpKPLLINO8827HPeYyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YnO4ov99SIfFOUOuV1Eyi/pm06uF7VvWbGggf5cJHZtnGDJLs5gPDQlKbuSlAzcedzl34ecMuMWBcp16jMAuCW64ff+yJpgLf97En/k2+VcPgmAhRsSb3Cx9/LYbUDYBkQB3XMrVrqh0ickGoh3t7OdyA5S+1EyEMA2UaDHnOKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTSRSwo4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTSRSwo4"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cf452def93so26996235ad.1
        for <linux-fbdev@vger.kernel.org>; Sun, 16 Aug 2026 00:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786865884; x=1787470684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RQI3AyX99exIaNSvIi7NmGMw2tFAjvIHhhh2QgMhw7g=;
        b=mTSRSwo42XnCWdCi0IA9E0RXIxUZ7IO9rsX48emeq/CjviDQT+fcXF7oM5oc4RXfCy
         oO++VXFrwbyoKnJx9ZBeocReCfF0TkYyDmK+FjbN0N44078FMW6zNRV2uHt7Q8F2IrU6
         clkT3/XMJsQIUkifV7UK2qj0jFod1I8HzScwCqeLbxA6sd+dYQeaq+Bqt6jl+Xtw5fLO
         QlnGxzY0ngNTUGUOzDH7xf0atH+forx9qqQIkQyRqZC78blchpFPAuLxHJM4lJTn+rwO
         GHipLO2F5UVB2OI2ocVsO1uGR2xoUv6StXu2k8iy1jX7Nb+gZD097pcgzmU6W2YryZhg
         h/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786865884; x=1787470684;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RQI3AyX99exIaNSvIi7NmGMw2tFAjvIHhhh2QgMhw7g=;
        b=Oz4SyxLuJYEqQViReh/R81yxZNmPpqbLHlHzi4ZUu4IgSlPVN9jnIxD8Oe7mfeJp/t
         hRpJCzXYYxHarpDXZinr9WuPuF3nht5y0/110IFGrz6curvOGj0UMDP6gKa+LN/obz+h
         /lST0gsvfzIEKPUchEmoBNpHymrJ6N06qOwZCMCfsp3qlzS3hQY5vXktOzuANEpPn6va
         hYjKtvDVLBsaTGoOBOT3bDXbMxl5uIcmMdPM7a6W64Ju1g4OI0+BmBs2U8BqkUfYMwgw
         hfx6/uyaterki/AfLOrlOHJ1ceMkrOSsCafTqd+1vFSbHH/62l1ARRiPHHKleRMrHusC
         wIMg==
X-Forwarded-Encrypted: i=1; AHgh+RoQuo4P5F3IvzdfyiqzE1LKZ9okVN5a7d2CN5qNtKqSx/JfS32+5ogYIbKnelhYoCnlMeeDYOHUt0Gvwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUaRRwdPTI8QWZMTI8g4yN9tjeD6uSwGa/qjkLvCVYJmKia2dV
	iDiSAoNCHsiD21YGftvHCh38AbiFrlcrBU6uCTRpxb6wrxFi7Y6iNkU0
X-Gm-Gg: AR+sD11efFTqSVeGF+iIWGZhBynvR4dN3+uAU1vU69ApBJkyLuwXICu7S6GuFkQcGqg
	9ECZv0IEs9hZm46g3LK1XN5xC+t9bz8K7ITel8Iurk8X1BDtTL+5DMk8dPjrMFvakm7xtjixzv3
	83LtxO67kLO4Nz17OM4DNnL8xuam0GKrD/QKbXjhsCeKYHmllI63sl03BUuTd5aON4ZQ/ETOMnU
	1DQ+My51Kzo1Z1d72A3FGUc4x7JU3YuHzrEewyLTbhiRU1g58BMC5i5shjChERDL6iN8of3DW9g
	h/Jgh73YTor9jBGJE3/h2mlWRgsmfcSjO7iuQRzzYs5vGv7VszpIOlLIqQup/SUAXbTYELgo8FC
	BbLvDy2AShynokIL02SDF/fIVwG9ZJ8aQsQmxgQPon6zStyBGae1HTs5ar2+vZxWhn9Is9PYJET
	8qxZq87e2ThW2aJHzzlalK1GDbo97LDXomPoJzKSWDsaAzt1xhfZ2B1G4wNruIVmSwH1JWSCu8D
	qY/8joQ82rkvbdRNrzXLjdQp1337os1M5iHeiIRS0e7m+9ZkH8PdQ==
X-Received: by 2002:a17:902:f68a:b0:2cc:fa13:dcab with SMTP id d9443c01a7336-2d3afe6fe0dmr131629665ad.8.1786865884435;
        Sun, 16 Aug 2026 00:38:04 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-170-159-fibre.sparkbb.co.nz. [222.152.170.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d563165e19sm5381745ad.42.2026.08.16.00.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 00:38:04 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
	id C2DFE3604D1; Sun, 16 Aug 2026 19:37:58 +1200 (NZST)
From: Michael Schmitz <schmitzmic@gmail.com>
To: linux-m68k@vger.kernel.org,
	geert@linux-m68k.org
Cc: schmitzmic@gmail.com,
	Miro Kropacek <miro.kropacek@gmail.com>,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v2 4/5] fbdev: Add support for SuperVidel's SuperBlitter
Date: Sun, 16 Aug 2026 19:37:51 +1200
Message-Id: <20260816073752.16656-5-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260816073752.16656-1-schmitzmic@gmail.com>
References: <20260816073752.16656-1-schmitzmic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 drivers/video/fbdev/atafb.c | 197 ++++++++++++++++++++++++++++++++++++
 1 file changed, 197 insertions(+)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index 50853d7a08e3..dc2d4154e1b6 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -2304,6 +2304,185 @@ static int ext_detect(void)
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
@@ -3168,6 +3347,24 @@ static int __init atafb_probe(struct platform_device *pdev)
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
+				fb_info.flags |= FBINFO_HWACCEL_COPYAREA |
+						 FBINFO_HWACCEL_FILLRECT;
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

