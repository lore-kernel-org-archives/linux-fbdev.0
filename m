From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/2] Remove __initdata from
	xilinx_fb_fix and xilinx_fb_var
Date: Mon, 09 Jul 2007 17:52:44 -0600
Message-ID: <20070709235244.4919.10308.stgit@trillian>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I8338-00044J-Ae for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Jul 2007 16:53:51 -0700
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]
	helo=pd4mo2so.prod.shaw.ca)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I8337-0000UE-1Y
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Jul 2007 16:53:50 -0700
Received: from pd4mr1so.prod.shaw.ca
	(pd4mr1so-qfe3.prod.shaw.ca [10.0.141.212]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JKX0003FROD1930@l-daemon> for
	linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Jul 2007 17:53:01 -0600 (MDT)
Received: from pn2ml1so.prod.shaw.ca ([10.0.121.145])
	by pd4mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JKX00BGBRODD141@pd4mr1so.prod.shaw.ca> for
	linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Jul 2007 17:53:02 -0600 (MDT)
Received: from trillian.secretlab.ca ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004)) with ESMTP id <0JKX00IBXROCFH90@l-daemon> for
	linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Jul 2007 17:53:01 -0600 (MDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

From: Grant Likely <grant.likely@secretlab.ca>

xilinxfb_drv_probe refers to both tables, but it cannot be initdata.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
cc: Andrei Konovalov <akonovalov@ru.mvista.com>
---

 drivers/video/xilinxfb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index 1d29a89..44ce955 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -79,7 +79,7 @@
 /*
  * Here are the default fb_fix_screeninfo and fb_var_screeninfo structures
  */
-static struct fb_fix_screeninfo xilinx_fb_fix __initdata = {
+static struct fb_fix_screeninfo xilinx_fb_fix = {
 	.id =		"Xilinx",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_TRUECOLOR,
@@ -88,7 +88,7 @@ static struct fb_fix_screeninfo xilinx_fb_fix __initdata = {
 	.accel =	FB_ACCEL_NONE
 };
 
-static struct fb_var_screeninfo xilinx_fb_var __initdata = {
+static struct fb_var_screeninfo xilinx_fb_var = {
 	.xres =			XRES,
 	.yres =			YRES,
 	.xres_virtual =		XRES_VIRTUAL,

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
