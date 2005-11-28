From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/16] nvidiafb: Driver cleanup
Date: Mon, 28 Nov 2005 23:14:25 +0800
Message-ID: <438B1ED1.90501@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhGmX-0001zd-NB
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:29:13 -0800
Received: from zproxy.gmail.com ([64.233.162.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EhGmX-0001tn-7F
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:29:13 -0800
Received: by zproxy.gmail.com with SMTP id z3so2537278nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 29 Nov 2005 17:29:11 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

- remove redundant casts
- add mode_option to module parameter

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/nvidia/nv_i2c.c |    6 +++---
 drivers/video/nvidia/nvidia.c |    7 +++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/video/nvidia/nv_i2c.c b/drivers/video/nvidia/nv_i2c.c
index fa72472..bd9eca0 100644
--- a/drivers/video/nvidia/nv_i2c.c
+++ b/drivers/video/nvidia/nv_i2c.c
@@ -46,7 +46,7 @@ static void nvidia_gpio_setscl(void *dat
 
 static void nvidia_gpio_setsda(void *data, int state)
 {
-	struct nvidia_i2c_chan *chan = (struct nvidia_i2c_chan *)data;
+	struct nvidia_i2c_chan *chan = data;
 	struct nvidia_par *par = chan->par;
 	u32 val;
 
@@ -64,7 +64,7 @@ static void nvidia_gpio_setsda(void *dat
 
 static int nvidia_gpio_getscl(void *data)
 {
-	struct nvidia_i2c_chan *chan = (struct nvidia_i2c_chan *)data;
+	struct nvidia_i2c_chan *chan = data;
 	struct nvidia_par *par = chan->par;
 	u32 val = 0;
 
@@ -79,7 +79,7 @@ static int nvidia_gpio_getscl(void *data
 
 static int nvidia_gpio_getsda(void *data)
 {
-	struct nvidia_i2c_chan *chan = (struct nvidia_i2c_chan *)data;
+	struct nvidia_i2c_chan *chan = data;
 	struct nvidia_par *par = chan->par;
 	u32 val = 0;
 
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index bee09c6..961007d 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -485,7 +485,7 @@ static int nvidia_backlight_levels[] = {
 
 static int nvidia_set_backlight_enable(int on, int level, void *data)
 {
-	struct nvidia_par *par = (struct nvidia_par *)data;
+	struct nvidia_par *par = data;
 	u32 tmp_pcrt, tmp_pmc, fpcontrol;
 
 	tmp_pmc = NV_RD32(par->PMC, 0x10F0) & 0x0000FFFF;
@@ -1513,7 +1513,7 @@ static int __devinit nvidiafb_probe(stru
 	if (!info)
 		goto err_out;
 
-	par = (struct nvidia_par *)info->par;
+	par = info->par;
 	par->pci_dev = pd;
 
 	info->pixmap.addr = kmalloc(8 * 1024, GFP_KERNEL);
@@ -1804,6 +1804,9 @@ module_param(vram, int, 0);
 MODULE_PARM_DESC(vram,
 		 "amount of framebuffer memory to remap in MiB"
 		 "(default=0 - remap entire memory)");
+module_param(mode_option, charp, 0);
+MODULE_PARM_DESC(mode_option, "Specify initial video mode");
+
 #ifdef CONFIG_MTRR
 module_param(nomtrr, bool, 0);
 MODULE_PARM_DESC(nomtrr, "Disables MTRR support (0 or 1=disabled) "



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
