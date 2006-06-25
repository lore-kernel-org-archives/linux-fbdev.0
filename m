From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] fbdev: tag by scantype in sysfs
Date: Sun, 25 Jun 2006 18:08:27 +0800
Message-ID: <449E609B.9060307@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FuRad-00069E-CK for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Jun 2006 03:11:39 -0700
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FuRab-0005MT-VK
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Jun 2006 03:11:39 -0700
Received: by py-out-1112.google.com with SMTP id z74so304121pyg
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Jun 2006 03:11:37 -0700 (PDT)
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
Cc: Daniel THOMPSON <daniel.thompson@st.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Daniel R Thompson <daniel.thompson@st.com>

Modify the sysfs description of a video mode such that modes are tagged
with their scan type, (p)rogessive, (i)nterlaced, (d)ouble scan. For example,
U:1920x1080i-50. This is useful to disambiguate some of the 'consumer'
video timings found in CEA-861 (especially those for EDTV).

Signed-off-by: Daniel R Thompson <daniel.thompson@st.com>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/fbsysfs.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
index b20b300..4f78f23 100644
--- a/drivers/video/fbsysfs.c
+++ b/drivers/video/fbsysfs.c
@@ -100,13 +100,22 @@ static int mode_string(char *buf, unsign
 		       const struct fb_videomode *mode)
 {
 	char m = 'U';
+	char v = 'p';
+
 	if (mode->flag & FB_MODE_IS_DETAILED)
 		m = 'D';
 	if (mode->flag & FB_MODE_IS_VESA)
 		m = 'V';
 	if (mode->flag & FB_MODE_IS_STANDARD)
 		m = 'S';
-	return snprintf(&buf[offset], PAGE_SIZE - offset, "%c:%dx%d-%d\n", m, mode->xres, mode->yres, mode->refresh);
+
+	if (mode->vmode & FB_VMODE_INTERLACED)
+		v = 'i';
+	if (mode->vmode & FB_VMODE_DOUBLE)
+		v = 'd';
+
+	return snprintf(&buf[offset], PAGE_SIZE - offset, "%c:%dx%d%c-%d\n",
+	                m, mode->xres, mode->yres, v, mode->refresh);
 }
 
 static ssize_t store_mode(struct class_device *class_device, const char * buf,


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
