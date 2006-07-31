From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 11/13] i810fb: Use generic DDC reading
Date: Tue, 01 Aug 2006 07:38:14 +0800
Message-ID: <44CE9466.7030905@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G7hOq-0003Dx-VG for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 16:42:17 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G7hOq-0004Mn-M6
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 16:42:16 -0700
Received: by py-out-1112.google.com with SMTP id d42so802545pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 31 Jul 2006 16:42:16 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Update driver to use generic DDC reading

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/Kconfig         |    1 +
 drivers/video/i810/i810-i2c.c |   42 +----------------------------------------
 2 files changed, 2 insertions(+), 41 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index a838924..115d00d 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -829,6 +829,7 @@ config FB_I810_I2C
 	depends on FB_I810 && FB_I810_GTF
 	select I2C
 	select I2C_ALGOBIT
+	select FB_DDC
 	help
 
 config FB_INTEL
diff --git a/drivers/video/i810/i810-i2c.c b/drivers/video/i810/i810-i2c.c
index c1f7b49..565a431 100644
--- a/drivers/video/i810/i810-i2c.c
+++ b/drivers/video/i810/i810-i2c.c
@@ -19,7 +19,6 @@ #include "i810_regs.h"
 #include "i810_main.h"
 #include "../edid.h"
 
-#define I810_DDC 0x50
 /* bit locations in the registers */
 #define SCL_DIR_MASK		0x0001
 #define SCL_DIR			0x0002
@@ -151,53 +150,14 @@ void i810_delete_i2c_busses(struct i810f
 	par->chan[2].par = NULL;
 }
 
-static u8 *i810_do_probe_i2c_edid(struct i810fb_i2c_chan *chan)
-{
-        u8 start = 0x0;
-        struct i2c_msg msgs[] = {
-                {
-                        .addr   = I810_DDC,
-                        .len    = 1,
-                        .buf    = &start,
-                }, {
-                        .addr   = I810_DDC,
-                        .flags  = I2C_M_RD,
-                        .len    = EDID_LENGTH,
-                },
-        };
-        u8 *buf;
-
-        buf = kmalloc(EDID_LENGTH, GFP_KERNEL);
-        if (!buf) {
-		DPRINTK("i810-i2c: Failed to allocate memory\n");
-                return NULL;
-        }
-        msgs[1].buf = buf;
-
-        if (i2c_transfer(&chan->adapter, msgs, 2) == 2) {
-		DPRINTK("i810-i2c: I2C Transfer successful\n");
-                return buf;
-	}
-
-        DPRINTK("i810-i2c: Unable to read EDID block.\n");
-        kfree(buf);
-        return NULL;
-}
-
 int i810_probe_i2c_connector(struct fb_info *info, u8 **out_edid, int conn)
 {
 	struct i810fb_par *par = info->par;
         u8 *edid = NULL;
-        int i;
 
 	DPRINTK("i810-i2c: Probe DDC%i Bus\n", conn+1);
 	if (conn < par->ddc_num) {
-		for (i = 0; i < 3; i++) {
-			/* Do the real work */
-			edid = i810_do_probe_i2c_edid(&par->chan[conn]);
-			if (edid)
-				break;
-		}
+		edid = fb_ddc_read(&par->chan[conn].adapter);
 	} else {
 		const u8 *e = fb_firmware_edid(info->device);
 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
