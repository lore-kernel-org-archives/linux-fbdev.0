From: Harald Welte <HaraldWelte@viatech.com>
Subject: [PATCH 01/15] [FB] make viafb work on x86_64
Date: Thu, 21 May 2009 04:28:39 +0800
Message-ID: <1242851333-325-1-git-send-email-HaraldWelte@viatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <laforge@prithivi.openmoko.org>) id 1M6siY-0004b6-AU
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 May 2009 20:48:50 +0000
Received: from ganesha.gnumonks.org ([213.95.27.120])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M6siR-0003Xz-VX
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 May 2009 20:48:50 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Harald Welte <HaraldWelte@viatech.com>

From: Harald Welte <laforge@gnumonks.org>

This patch makes fixes a bug in viafb on x86_64 builds (e.g. for VIA Nano CPU).
You cannot make the assumption that sizeof(unsigned int) == sizeof(unsigned
long), so the parsing of the default mode (640x480) fails, leading to a
division by zero during insmod of the driver.

Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
---
 drivers/video/via/viafbdev.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index e327b84..a0fec29 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -2103,7 +2103,7 @@ static void viafb_remove_proc(struct proc_dir_entry *viafb_entry)
 
 static int __devinit via_pci_probe(void)
 {
-	unsigned int default_xres, default_yres;
+	unsigned long default_xres, default_yres;
 	char *tmpc, *tmpm;
 	char *tmpc_sec, *tmpm_sec;
 	int vmode_index;
@@ -2196,8 +2196,8 @@ static int __devinit via_pci_probe(void)
 	viafb_FB_MM = viaparinfo->fbmem_virt;
 	tmpm = viafb_mode;
 	tmpc = strsep(&tmpm, "x");
-	strict_strtoul(tmpc, 0, (unsigned long *)&default_xres);
-	strict_strtoul(tmpm, 0, (unsigned long *)&default_yres);
+	strict_strtoul(tmpc, 0, &default_xres);
+	strict_strtoul(tmpm, 0, &default_yres);
 
 	vmode_index = viafb_get_mode_index(default_xres, default_yres, 0);
 	DEBUG_MSG(KERN_INFO "0->index=%d\n", vmode_index);
-- 
1.6.2.4


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
