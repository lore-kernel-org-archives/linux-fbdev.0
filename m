From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 4/4] asiliantfb: Add help text in Kconfig
Date: Sat, 22 Apr 2006 10:51:30 +0800
Message-ID: <44499A32.5060306@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FX8F3-0003cz-9a
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Apr 2006 19:53:01 -0700
Received: from pproxy.gmail.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FX8F2-0001zL-4n
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Apr 2006 19:53:01 -0700
Received: by pproxy.gmail.com with SMTP id i49so647147pye
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 21 Apr 2006 19:52:59 -0700 (PDT)
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

Add help text in Kconfig

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 29fb1f9..5641498 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -400,6 +400,8 @@ config FB_ASILIANT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	help
+	  This is the frame buffer device driver for the Asiliant 69030 chipset
 
 config FB_IMSTT
 	bool "IMS Twin Turbo display support"



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
