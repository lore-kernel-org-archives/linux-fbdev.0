From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH] lxfb: drop dead declarations from header
Date: Fri, 20 Jun 2008 13:41:11 -0400
Message-ID: <20080620134111.67038f21@xo-debian>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758880AbYFTRir@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: adaplas@gmail.com, jordan.crouse@amd.com, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net


We never sent the gamma stuff upstream, and don't really care about it.
However, lx_[gs]_et_gamma prototypes snuck into lxfb.h anyways; there
are no definitions for them.  Drop the dead code.

Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 drivers/video/geode/lxfb.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/video/geode/lxfb.h b/drivers/video/geode/lxfb.h
index 3b9416f..6a51448 100644
--- a/drivers/video/geode/lxfb.h
+++ b/drivers/video/geode/lxfb.h
@@ -51,8 +51,6 @@ static inline unsigned int lx_get_pitch(unsigned int xres, int bpp)
 }
 
 void lx_set_mode(struct fb_info *);
-void lx_get_gamma(struct fb_info *, unsigned int *, int);
-void lx_set_gamma(struct fb_info *, unsigned int *, int);
 unsigned int lx_framebuffer_size(void);
 int lx_blank_display(struct fb_info *, int);
 void lx_set_palette_reg(struct fb_info *, unsigned int, unsigned int,
-- 
1.5.5.3
