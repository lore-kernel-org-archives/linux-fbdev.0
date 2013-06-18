From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@freescale.com>
Date: Tue, 18 Jun 2013 14:23:05 +0000
Subject: [PATCH linux-next] fb: make fp_get_options name argument const
Message-Id: <1371565386-23335-1-git-send-email-vincent.stehle@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-next@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@freescale.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Dave Airlie <airlied@redhat.com>, trivial@kernel.org

drm_get_connector_name now returns a const value, which causes the following
compilation warning:

  drivers/gpu/drm/drm_fb_helper.c: In function ‘drm_fb_helper_parse_command_line’:
  drivers/gpu/drm/drm_fb_helper.c:127:3: warning: passing argument 1 of ‘fb_get_options’ discards ‘const’ qualifier from pointer target type [enabled by default]
  In file included from drivers/gpu/drm/drm_fb_helper.c:35:0:
  include/linux/fb.h:627:12: note: expected ‘char *’ but argument is of type ‘const char *’

As fb_get_options uses its name argument as read only, make it const. This
fixes the aforementioned compilation warning.

Signed-off-by: Vincent Stehlé <vincent.stehle@freescale.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: trivial@kernel.org
---


Hi,

I remarked this warning while building linux-next with imx_v6_v7_defconfig.
Is changing fb_get_options prototype "permitted", please?

Best regards,

V.


 drivers/video/fbmem.c |    2 +-
 include/linux/fb.h    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 098bfc6..d8d5779 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1881,7 +1881,7 @@ static int ofonly __read_mostly;
  *
  * NOTE: Needed to maintain backwards compatibility
  */
-int fb_get_options(char *name, char **option)
+int fb_get_options(const char *name, char **option)
 {
 	char *opt, *options = NULL;
 	int retval = 0;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index d49c60f..ffac70a 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -624,7 +624,7 @@ extern void fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch, u3
 extern void fb_set_suspend(struct fb_info *info, int state);
 extern int fb_get_color_depth(struct fb_var_screeninfo *var,
 			      struct fb_fix_screeninfo *fix);
-extern int fb_get_options(char *name, char **option);
+extern int fb_get_options(const char *name, char **option);
 extern int fb_new_modelist(struct fb_info *info);
 
 extern struct fb_info *registered_fb[FB_MAX];
-- 
1.7.10.4



