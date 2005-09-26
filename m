From: Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH] s3c2410fb - minor warning fix
Date: Mon, 26 Sep 2005 22:13:16 +0100
Message-ID: <20050926211316.GA29631@home.fluff.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EK0Is-0000j8-Tc
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 26 Sep 2005 14:14:26 -0700
Received: from host-84-9-200-79.bulldogdsl.com ([84.9.200.79] helo=aeryn.fluff.org.uk)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EK0Ir-0004bt-Et
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 26 Sep 2005 14:14:26 -0700
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: arnaud.patard@rtp-net.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The function s3c2410fb_activate_var does not return
a value, therefore it should be declared void.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

--- ../linux-2.6.14/linux-2.6.14-rc2/drivers/video/s3c2410fb.c	2005-09-25 15:18:42.000000000 +0100
+++ linux-2.6.13-simtec2/drivers/video/s3c2410fb.c	2005-09-26 18:03:17.000000000 +0100
@@ -228,8 +228,8 @@
  * information
 */
 
-static int s3c2410fb_activate_var(struct s3c2410fb_info *fbi,
-				  struct fb_var_screeninfo *var)
+static void s3c2410fb_activate_var(struct s3c2410fb_info *fbi,
+				   struct fb_var_screeninfo *var)
 {
 	fbi->regs.lcdcon1 &= ~S3C2410_LCDCON1_MODEMASK;
 

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="s3c2410-fb-gcc4-fix1.patch"

--- ../linux-2.6.14/linux-2.6.14-rc2/drivers/video/s3c2410fb.c	2005-09-25 15:18:42.000000000 +0100
+++ linux-2.6.13-simtec2/drivers/video/s3c2410fb.c	2005-09-26 18:03:17.000000000 +0100
@@ -228,8 +228,8 @@
  * information
 */
 
-static int s3c2410fb_activate_var(struct s3c2410fb_info *fbi,
-				  struct fb_var_screeninfo *var)
+static void s3c2410fb_activate_var(struct s3c2410fb_info *fbi,
+				   struct fb_var_screeninfo *var)
 {
 	fbi->regs.lcdcon1 &= ~S3C2410_LCDCON1_MODEMASK;
 

--6c2NcOVqGQ03X4Wi--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
