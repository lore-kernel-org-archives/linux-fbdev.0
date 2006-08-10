From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 6/8] matroxfb: Honor the return value of
	pci_register_driver
Date: Thu, 10 Aug 2006 19:51:59 +0800
Message-ID: <44DB1DDF.4050604@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GB9Ap-0003GY-Nq for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 04:58:03 -0700
Received: from nz-out-0102.google.com ([64.233.162.196])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GB9Ao-0006Ho-Ef
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 04:58:03 -0700
Received: by nz-out-0102.google.com with SMTP id m22so116768nzf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 10 Aug 2006 04:58:02 -0700 (PDT)
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
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Check the return value of pci_register_driver()

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/matrox/matroxfb_base.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/video/matrox/matroxfb_base.c b/drivers/video/matrox/matroxfb_base.c
index 4a57dab..7acf01c 100644
--- a/drivers/video/matrox/matroxfb_base.c
+++ b/drivers/video/matrox/matroxfb_base.c
@@ -2277,10 +2277,13 @@ static void __init matroxfb_init_params(
 	}
 }
 
-static void __init matrox_init(void) {
+static int __init matrox_init(void) {
+	int err;
+
 	matroxfb_init_params();
-	pci_register_driver(&matroxfb_driver);
+	err = pci_register_driver(&matroxfb_driver);
 	dev = -1;	/* accept all new devices... */
+	return err;
 }
 
 /* **************************** exit-time only **************************** */
@@ -2437,6 +2440,7 @@ static int __initdata initialized = 0;
 static int __init matroxfb_init(void)
 {
 	char *option = NULL;
+	int err = 0;
 
 	DBG(__FUNCTION__)
 
@@ -2448,11 +2452,11 @@ static int __init matroxfb_init(void)
 		return -ENXIO;
 	if (!initialized) {
 		initialized = 1;
-		matrox_init();
+		err = matrox_init();
 	}
 	hotplug = 1;
 	/* never return failure, user can hotplug matrox later... */
-	return 0;
+	return err;
 }
 
 module_init(matroxfb_init);


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
