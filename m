From: Parmeshwr Prasad <parmeshwr_prasad@dell.com>
Date: Thu, 26 Feb 2015 10:48:08 +0000
Subject: [PATCH 3/3] Moved assignment out of if() statement in efifb.c
Message-Id: <20150226104803.GC20577@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150218083654.GD9820@linuxteamdev.amer.dell.com>
In-Reply-To: <20150218083654.GD9820@linuxteamdev.amer.dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: linux-efi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org

Removing initialization out of if condition.

Signed-off-by: Parmeshwr Prasad <parmeshwr_prasad@dell.com>
---
 drivers/video/fbdev/efifb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index cc1a156..9124ba9 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -275,11 +275,13 @@ static int efifb_probe(struct platform_device *dev)
        info->fix = efifb_fix;
        info->flags = FBINFO_FLAG_DEFAULT | FBINFO_MISC_FIRMWARE;

-       if ((err = fb_alloc_cmap(&info->cmap, 256, 0)) < 0) {
+       err = fb_alloc_cmap(&info->cmap, 256, 0);
+       if (err < 0) {
                pr_err("efifb: cannot allocate colormap\n");
                goto err_unmap;
        }
-       if ((err = register_framebuffer(info)) < 0) {
+       err = register_framebuffer(info);
+       if (err < 0) {
                pr_err("efifb: cannot register framebuffer\n");
                goto err_fb_dealoc;
        }
--
1.9.3

