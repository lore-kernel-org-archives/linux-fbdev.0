Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8E526CE36
	for <linux-fbdev@vger.kernel.org>; Sun, 10 Aug 2025 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754841660; cv=none; b=tLbLmQQcLArUaRVwnxtxiNiZvU+o4YnKKPBv2qZNj9ZSl9FFM10YFK2MaNbzPC8LT1+rkmeeYs8Lm5b57OT4FW3iYNiWuZKTt2xQN+mV8B12h8jDzlgHvMvUhR/SLvtBVKc0HPW5DWChQPI5FiqX2AB54W/Ef7M1TokMSTWcm7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754841660; c=relaxed/simple;
	bh=RiurPsxjYSDuuKcHrhC4HvinGFqJIkcBbFy7W8xeGjU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gsWmzN+ByS7eUwKeQZRJ8zAYTgdxwK+on1BmyC+8aYf+2/gVC/Pfayet355eqpI1fylton4pfUsBBbYHAL6FY8hPVKn3+wO+jX+TtyO87ej/MTnFBO35Zb9En23mxcLRJvqyKAzzHQNkd6cRnzQRnimEUvXx7LL64amWu2yc3Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: by c64.rulez.org (Postfix, from userid 1000)
	id 023B01014E; Sun, 10 Aug 2025 18:00:48 +0200 (CEST)
From: Zsolt Kajtar <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org
Cc: Zsolt Kajtar <soci@c64.rulez.org>
Subject: [PATCH] fbdev: s3fb: Implement powersave for S3 FB
Date: Sun, 10 Aug 2025 17:47:54 +0200
Message-Id: <20250810154754.16211-1-soci@c64.rulez.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch implements power saving for S3 cards by powering down the
RAMDAC and stopping MCLK and DCLK while the card is supposed to be
suspended.

The RAMDAC is also disabled while the screen is blanked and the DCLK
in stopped while in DPMS power off.

The practical difference it makes is that on a machine with such a
card the display will be placed in DPMS power off while standby is
activated (due to stopped DCLK). Same like when using other cards with
implemented power saving functionality.

Without it on my setup the connected display powers up and stays that
way showing VT63 while in standby. Sort of annoying as before standby
it's specifically placed into DPMS off in Xorg for a while.

The used functionality should exists for sure on Trio32 to Aurora64V
(according to the documentation) so I think it's generally applicable.
I'm using this on S3 Trio 3D and S3 Virge DX.

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/video/fbdev/s3fb.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/video/fbdev/s3fb.c b/drivers/video/fbdev/s3fb.c
index ff84106ec..9b3fca9b3 100644
--- a/drivers/video/fbdev/s3fb.c
+++ b/drivers/video/fbdev/s3fb.c
@@ -988,34 +988,30 @@ static int s3fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 static int s3fb_blank(int blank_mode, struct fb_info *info)
 {
 	struct s3fb_info *par = info->par;
+	u8 data;
+
+	data = (blank_mode == FB_BLANK_UNBLANK) ? 0x00 : 0x20;
+	svga_wseq_mask(par->state.vgabase, 0x01, data, 0x20);
+	svga_wseq_mask(par->state.vgabase, 0x18, data, 0x20);
 
 	switch (blank_mode) {
-	case FB_BLANK_UNBLANK:
-		fb_dbg(info, "unblank\n");
-		svga_wcrt_mask(par->state.vgabase, 0x56, 0x00, 0x06);
-		svga_wseq_mask(par->state.vgabase, 0x01, 0x00, 0x20);
-		break;
-	case FB_BLANK_NORMAL:
-		fb_dbg(info, "blank\n");
-		svga_wcrt_mask(par->state.vgabase, 0x56, 0x00, 0x06);
-		svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
+	default:
+		data = 0x00;
 		break;
 	case FB_BLANK_HSYNC_SUSPEND:
-		fb_dbg(info, "hsync\n");
-		svga_wcrt_mask(par->state.vgabase, 0x56, 0x02, 0x06);
-		svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
+		data = 0x02;
 		break;
 	case FB_BLANK_VSYNC_SUSPEND:
-		fb_dbg(info, "vsync\n");
-		svga_wcrt_mask(par->state.vgabase, 0x56, 0x04, 0x06);
-		svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
+		data = 0x04;
 		break;
 	case FB_BLANK_POWERDOWN:
-		fb_dbg(info, "sync down\n");
-		svga_wcrt_mask(par->state.vgabase, 0x56, 0x06, 0x06);
-		svga_wseq_mask(par->state.vgabase, 0x01, 0x20, 0x20);
+		data = 0x06;
 		break;
 	}
+	svga_wcrt_mask(par->state.vgabase, 0x56, data, 0x06);
+
+	data = (blank_mode == FB_BLANK_POWERDOWN) ? 0x01 : 0x00;
+	svga_wseq_mask(par->state.vgabase, 0x14, data, 0x01);
 
 	return 0;
 }
@@ -1445,6 +1441,8 @@ static int __maybe_unused s3_pci_suspend(struct device *dev)
 	}
 
 	fb_set_suspend(info, 1);
+	svga_wseq_mask(par->state.vgabase, 0x18, 0x20, 0x20);
+	svga_wseq_mask(par->state.vgabase, 0x14, 0x03, 0x03);
 
 	mutex_unlock(&(par->open_lock));
 	console_unlock();
@@ -1471,6 +1469,9 @@ static int __maybe_unused s3_pci_resume(struct device *dev)
 		return 0;
 	}
 
+	vga_wseq(par->state.vgabase, 0x08, 0x06);
+	svga_wseq_mask(par->state.vgabase, 0x18, 0x00, 0x20);
+	svga_wseq_mask(par->state.vgabase, 0x14, 0x00, 0x03);
 	s3fb_set_par(info);
 	fb_set_suspend(info, 0);
 
-- 
2.30.2

