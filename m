From: Marcin Slusarz <marcin.slusarz@gmail.com>
Subject: [PATCH] fbcon: don't inline updatescrollmode
Date: Sat, 25 Oct 2008 22:00:59 +0200
Message-ID: <20081025200055.GE10932@joi>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751768AbYJYUBa@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Antonino Daplas <adaplas@gmail.com>, Krzysztof Helt <krzysztof.h1@wp.pl>, linux-fbdev-devel@lists.sourceforge.net

Updatescrollmode is marked inline, but it's big and is called only from
non-critical codepaths (fbcon_resize, fbcon_switch, fbcon_modechanged).
Dropping it saves almost 800 bytes of text size.

   text    data     bss     dec     hex filename
  23859     287    8448   32594    7f52 drivers/video/console/fbcon.o.before
  23065     287    8448   31800    7c38 drivers/video/console/fbcon.o.after

Signed-off-by: Marcin Slusarz <marcin.slusarz@gmail.com>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: linux-fbdev-devel@lists.sourceforge.net
---
 drivers/video/console/fbcon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 64b3d30..b92947d 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -2118,7 +2118,7 @@ static void fbcon_bmove_rec(struct vc_data *vc, struct display *p, int sy, int s
 		   height, width);
 }
 
-static __inline__ void updatescrollmode(struct display *p,
+static void updatescrollmode(struct display *p,
 					struct fb_info *info,
 					struct vc_data *vc)
 {
-- 
1.5.6.4
