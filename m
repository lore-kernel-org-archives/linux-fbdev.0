From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 06 Jan 2020 08:13:52 +0000
Subject: [PATCH] fbdev: remove object duplication in Makefile
Message-Id: <20200106081352.27730-1-masahiroy@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org
Cc: Masahiro Yamada <masahiroy@kernel.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The objects in $(fb-objs) $(fb-y) $(fb-m) are linked to fb.ko .

This line adds $(fb-y) to fb-objs, so the objects from $(fb-y) are
listed twice as the dependency of the module.

It works because Kbuild trims the duplicated objects from linking,
but there is no good reason to have this line.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/video/fbdev/core/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/core/Makefile b/drivers/video/fbdev/core/Makefile
index 37710316a680..26cbc965497c 100644
--- a/drivers/video/fbdev/core/Makefile
+++ b/drivers/video/fbdev/core/Makefile
@@ -16,7 +16,6 @@ fb-y				  += fbcon_rotate.o fbcon_cw.o fbcon_ud.o \
 				     fbcon_ccw.o
 endif
 endif
-fb-objs                           := $(fb-y)
 
 obj-$(CONFIG_FB_CFB_FILLRECT)  += cfbfillrect.o
 obj-$(CONFIG_FB_CFB_COPYAREA)  += cfbcopyarea.o
-- 
2.17.1
