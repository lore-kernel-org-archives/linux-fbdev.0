Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C8384E1C
	for <linux-fbdev@vger.kernel.org>; Mon, 10 Mar 2025 07:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741590238; cv=none; b=W8ziXXiTqJ1A7Eb5xBd7bm6eKbsBNj2f2cgSu/K/wXKFvXj6UsJgu5C4Y/jSIazj9mAUsgLwr4m1cfKiXuyMkCLvmw1H+ER/srr9jZc0RNvJpXi/lbMRTTQJ1aL83S1tLeYcAHj6/Mr3u4+aa++kK4E96NERoPV5+zmXo+jY/OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741590238; c=relaxed/simple;
	bh=H9OtY5ZvbpAx0TbVjLRrNbkxq0eaYqUvevAmCvgMzzk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PguCpRmE+vNsR62DrgT0B2Fv0ZdPA6tf0oLbLk5Rr0vaFZU5bgEXvp9SBvS/5Ozph7nNL78+P8guFxUKi1FNprZO82bhuI4vAMPpS/KQZ7wLz/ABDHdXif0j6IH7Pn/J28H4a4TYxyVvCZO8zdPC9VbeSH+BbsKGSHBwQiZOlc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: by c64.rulez.org (Postfix, from userid 1000)
	id 242EC100CF; Mon, 10 Mar 2025 08:03:51 +0100 (CET)
From: Zsolt Kajtar <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: deller@gmx.de,
	Zsolt Kajtar <soci@c64.rulez.org>
Subject: [PATCH] Remove fb_draw.h includes
Date: Mon, 10 Mar 2025 07:57:45 +0100
Message-Id: <20250310065745.17623-1-soci@c64.rulez.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is related to the fbcon packed pixel drawing refactoring. There I
missed that fb_draw.h was included from two unexpected places. That
shouldn't be like that. This patch removes the dependency.

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/video/fbdev/aty/mach64_cursor.c |  7 +++++-
 drivers/video/fbdev/wmt_ge_rops.c       | 30 +++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/aty/mach64_cursor.c b/drivers/video/fbdev/aty/mach64_cursor.c
index 971355c2c..e826cb7dd 100644
--- a/drivers/video/fbdev/aty/mach64_cursor.c
+++ b/drivers/video/fbdev/aty/mach64_cursor.c
@@ -6,7 +6,6 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/string.h>
-#include "../core/fb_draw.h"
 
 #include <asm/io.h>
 
@@ -57,6 +56,12 @@
  * definitation and CUR_VERT_POSN must be saturated to zero.
  */
 
+/* compose pixels based on mask */
+static inline unsigned long comp(unsigned long set, unsigned long unset, unsigned long mask)
+{
+	return ((set ^ unset) & mask) ^ unset;
+}
+
     /*
      *  Hardware Cursor support.
      */
diff --git a/drivers/video/fbdev/wmt_ge_rops.c b/drivers/video/fbdev/wmt_ge_rops.c
index 69106299a..92fbb3f3a 100644
--- a/drivers/video/fbdev/wmt_ge_rops.c
+++ b/drivers/video/fbdev/wmt_ge_rops.c
@@ -12,7 +12,6 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 
-#include "core/fb_draw.h"
 #include "wmt_ge_rops.h"
 
 #define GE_COMMAND_OFF		0x00
@@ -41,6 +40,33 @@
 
 static void __iomem *regbase;
 
+/* from the spec it seems more like depth than bits per pixel */
+static inline unsigned long pixel_to_pat(u32 depth, u32 pixel, struct fb_info *p)
+{
+	switch (depth) {
+	case 1:
+		return ~0ul*pixel;
+	case 2:
+		return ~0ul/3*pixel;
+	case 4:
+		return ~0ul/15*pixel;
+	case 8:
+		return ~0ul/255*pixel;
+	case 12:
+	case 15:
+	case 16:
+		return ~0ul/0xffff*pixel;
+	case 18:
+	case 24:
+		return 0x1000001ul*pixel;
+	case 32:
+		return pixel;
+	default:
+		fb_warn_once(p, "%s: unsupported pixelformat %d\n", __func__, depth);
+		return 0;
+	}
+}
+
 void wmt_ge_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
 {
 	unsigned long fg, pat;
@@ -54,7 +80,7 @@ void wmt_ge_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
 	else
 		fg = rect->color;
 
-	pat = pixel_to_pat(p->var.bits_per_pixel, fg);
+	pat = pixel_to_pat(p->var.bits_per_pixel, fg, p);
 
 	if (p->fbops->fb_sync)
 		p->fbops->fb_sync(p);
-- 
2.30.2

