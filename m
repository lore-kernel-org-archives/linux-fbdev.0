From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sun, 03 Jun 2018 14:40:57 +0000
Subject: [PATCH 04/21] udl-kms: fix crash due to uninitialized memory
Message-Id: <20180603144220.475786254@twibright.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180603144053.875668929@twibright.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Airlie <airlied@redhat.com>, Bernie Thompson <bernie@plugable.com>, Ladislav Michl <ladis@linux-mips.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

We must use kzalloc when allocating the fb_deferred_io structure.
Otherwise, the field first_io is undefined and it causes a crash.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 drivers/gpu/drm/udl/udl_fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-4.16.12/drivers/gpu/drm/udl/udl_fb.c
=================================--- linux-4.16.12.orig/drivers/gpu/drm/udl/udl_fb.c	2018-05-29 17:55:39.000000000 +0200
+++ linux-4.16.12/drivers/gpu/drm/udl/udl_fb.c	2018-05-29 17:55:39.000000000 +0200
@@ -221,7 +221,7 @@ static int udl_fb_open(struct fb_info *i
 
 		struct fb_deferred_io *fbdefio;
 
-		fbdefio = kmalloc(sizeof(struct fb_deferred_io), GFP_KERNEL);
+		fbdefio = kzalloc(sizeof(struct fb_deferred_io), GFP_KERNEL);
 
 		if (fbdefio) {
 			fbdefio->delay = DL_DEFIO_WRITE_DELAY;

