From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date: Sat, 05 May 2018 15:45:51 +0000
Subject: [git:media_tree/master] media: include/video/omapfb_dss.h: use IS_ENABLED()
Message-Id: <E1fEzNz-0004LP-9t@www.linuxtv.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: include/video/omapfb_dss.h: use IS_ENABLED()
Author:  Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date:    Fri May 4 16:49:32 2018 -0400

Just checking for ifdefs cause build issues as reported by
kernel test:

config: openrisc-allmodconfig (attached as .config)
compiler: or1k-linux-gcc (GCC) 6.0.0 20160327 (experimental)

All errors (new ones prefixed by >>):

   drivers/video/fbdev/omap2/omapfb/omapfb-main.c: In function 'omapfb_init_connections':
>> drivers/video/fbdev/omap2/omapfb/omapfb-main.c:2396:8: error: implicit declaration of function 'omapdss_find_mgr_from_display' [-Werror=implicit-function-declaration]
     mgr = omapdss_find_mgr_from_display(def_dssdev);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/omap2/omapfb/omapfb-main.c:2396:6: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     mgr = omapdss_find_mgr_from_display(def_dssdev);
         ^
   drivers/video/fbdev/omap2/omapfb/omapfb-main.c: In function 'omapfb_find_default_display':
>> drivers/video/fbdev/omap2/omapfb/omapfb-main.c:2430:13: error: implicit declaration of function 'omapdss_get_default_display_name' [-Werror=implicit-function-declaration]
     def_name = omapdss_get_default_display_name();
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/omap2/omapfb/omapfb-main.c:2430:11: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     def_name = omapdss_get_default_display_name();
              ^

So, use IS_ENABLED() instead.

Fixes: 771f7be87ff9 ("media: omapfb: omapfb_dss.h: add stubs to build with COMPILE_TEST && DRM_OMAP")

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

 include/video/omapfb_dss.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---

diff --git a/include/video/omapfb_dss.h b/include/video/omapfb_dss.h
index e9775144ff3b..12755d8d9b4f 100644
--- a/include/video/omapfb_dss.h
+++ b/include/video/omapfb_dss.h
@@ -778,7 +778,7 @@ struct omap_dss_driver {
 
 typedef void (*omap_dispc_isr_t) (void *arg, u32 mask);
 
-#ifdef CONFIG_FB_OMAP2
+#if IS_ENABLED(CONFIG_FB_OMAP2)
 
 enum omapdss_version omapdss_get_version(void);
 bool omapdss_is_initialized(void);
