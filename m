From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 5/8 RESEND] atyfb: Honor the return
	value of pci_register_driver
Date: Thu, 10 Aug 2006 20:56:13 +0800
Message-ID: <44DB2CED.60509@gmail.com>
References: <44DB1DA4.3000703@gmail.com>
	<Pine.LNX.4.62.0608101410390.718@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GBA5I-0008A2-T3 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 05:56:25 -0700
Received: from nz-out-0102.google.com ([64.233.162.195])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GBA5E-0006T7-FZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 05:56:21 -0700
Received: by nz-out-0102.google.com with SMTP id m22so122392nzf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 10 Aug 2006 05:56:19 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0608101410390.718@pademelon.sonytel.be>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Geert Uytterhoeven <geert@linux-m68k.org>

Check return value of pci_register_driver().

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
Geert Uytterhoeven wrote:
> On Thu, 10 Aug 2006, Antonino A. Daplas wrote:
> 
> Actually it's a bit more complicated, as some Ataris do have PCI (although
> currently Atari Hades PCI support is broken).
> 

This one may be better.

Tony

 drivers/video/aty/atyfb_base.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index 053ff63..d6be4c7 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -3859,6 +3859,7 @@ #endif  /*  MODULE  */
 
 static int __devinit atyfb_init(void)
 {
+    int err1 = 1, err2 = 1;
 #ifndef MODULE
     char *option = NULL;
 
@@ -3868,12 +3869,13 @@ #ifndef MODULE
 #endif
 
 #ifdef CONFIG_PCI
-    pci_register_driver(&atyfb_driver);
+    err1 = pci_register_driver(&atyfb_driver);
 #endif
 #ifdef CONFIG_ATARI
-    atyfb_atari_probe();
+    err2 = atyfb_atari_probe();
 #endif
-    return 0;
+
+    return (err1 && err2) ? -ENODEV : 0;
 }
 
 static void __exit atyfb_exit(void)

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
