From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 30 Jun 2017 08:00:30 +0000
Subject: [PATCH] video: fbdev: matrox: the list iterator can't be NULL
Message-Id: <20170630080030.2hee3stcmn5utlmc@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

My static checker is complaining because we check "drv" for NULL and
then we dereference it to get the next item in the list.  It can't be
NULL so we can remove this check.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/fbdev/matrox/matroxfb_base.c
index 11eb094396ae..f6a0b9af97a9 100644
--- a/drivers/video/fbdev/matrox/matroxfb_base.c
+++ b/drivers/video/fbdev/matrox/matroxfb_base.c
@@ -2001,7 +2001,7 @@ static void matroxfb_register_device(struct matrox_fb_info* minfo) {
 	for (drv = matroxfb_driver_l(matroxfb_driver_list.next);
 	     drv != matroxfb_driver_l(&matroxfb_driver_list);
 	     drv = matroxfb_driver_l(drv->node.next)) {
-		if (drv && drv->probe) {
+		if (drv->probe) {
 			void *p = drv->probe(minfo);
 			if (p) {
 				minfo->drivers_data[i] = p;
