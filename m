From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH] fbdev: Fujitsu MB862xx framebuffer
	driver i386 allmodconfig fix
Date: Tue, 28 Oct 2008 11:46:30 +0100
Message-ID: <1225190790-32563-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <agust@denx.de>) id 1KumA5-0000Ll-8u
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 28 Oct 2008 10:50:57 +0000
Received: from mail-out.m-online.net ([212.18.0.10])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Kum5s-0004rD-VN for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 28 Oct 2008 10:50:57 +0000
In-Reply-To: 20081018195205.6b746f7d.akpm@linux-foundation.org
References: 20081018195205.6b746f7d.akpm@linux-foundation.org
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: akpm@linux-foundation.org
Cc: avorontsov@ru.mvista.com, linux-fbdev-devel@lists.sourceforge.net, dbaryshkov@gmail.com, m.fortini@selcomgroup.com

Fix i386 allmodconfig build previously failed with:

drivers/video/mb862xx/mb862xxfb.h:65:2: error: #error "Select Lime GDC or CoralP/Carmine support, but not both together"
drivers/video/mb862xx/mb862xxfb.c:549: warning: 'struct of_device' declared inside parameter list
drivers/video/mb862xx/mb862xxfb.c:549: warning: its scope is only this definition or declaration, which is probably not what you want
drivers/video/mb862xx/mb862xxfb.c: In function 'of_platform_mb862xx_probe':
drivers/video/mb862xx/mb862xxfb.c:551: error: dereferencing pointer to incomplete type
drivers/video/mb862xx/mb862xxfb.c:552: error: dereferencing pointer to incomplete type
drivers/video/mb862xx/mb862xxfb.c:559: error: implicit declaration of function 'of_address_to_resource'
drivers/video/mb862xx/mb862xxfb.c:574: error: implicit declaration of function 'irq_of_parse_and_map'
drivers/video/mb862xx/mb862xxfb.c:575: error: 'NO_IRQ' undeclared (first use in this function)
drivers/video/mb862xx/mb862xxfb.c:575: error: (Each undeclared identifier is reported only once
drivers/video/mb862xx/mb862xxfb.c:575: error: for each function it appears in.)
drivers/video/mb862xx/mb862xxfb.c:664: error: implicit declaration of function 'irq_dispose_mapping'
drivers/video/mb862xx/mb862xxfb.c: At top level:
drivers/video/mb862xx/mb862xxfb.c:671: warning: 'struct of_device' declared inside parameter list
drivers/video/mb862xx/mb862xxfb.c: In function 'of_platform_mb862xx_remove':
drivers/video/mb862xx/mb862xxfb.c:673: error: dereferencing pointer to incomplete type
drivers/video/mb862xx/mb862xxfb.c:691: error: dereferencing pointer to incomplete type
drivers/video/mb862xx/mb862xxfb.c:699: error: dereferencing pointer to incomplete type
drivers/video/mb862xx/mb862xxfb.c: At top level:
drivers/video/mb862xx/mb862xxfb.c:719: error: variable 'of_platform_mb862xxfb_driver' has initializer but incomplete type
drivers/video/mb862xx/mb862xxfb.c:720: error: unknown field 'owner' specified in initializer
drivers/video/mb862xx/mb862xxfb.c:720: warning: excess elements in struct initializer
drivers/video/mb862xx/mb862xxfb.c:720: warning: (near initialization for 'of_platform_mb862xxfb_driver')
drivers/video/mb862xx/mb862xxfb.c:721: error: unknown field 'name' specified in initializer
drivers/video/mb862xx/mb862xxfb.c:721: warning: excess elements in struct initializer
drivers/video/mb862xx/mb862xxfb.c:721: warning: (near initialization for 'of_platform_mb862xxfb_driver')
drivers/video/mb862xx/mb862xxfb.c:722: error: unknown field 'match_table' specified in initializer
drivers/video/mb862xx/mb862xxfb.c:722: warning: excess elements in struct initializer
drivers/video/mb862xx/mb862xxfb.c:722: warning: (near initialization for 'of_platform_mb862xxfb_driver')
drivers/video/mb862xx/mb862xxfb.c:723: error: unknown field 'probe' specified in initializer
drivers/video/mb862xx/mb862xxfb.c:723: warning: excess elements in struct initializer
drivers/video/mb862xx/mb862xxfb.c:723: warning: (near initialization for 'of_platform_mb862xxfb_driver')
drivers/video/mb862xx/mb862xxfb.c:724: error: unknown field 'remove' specified in initializer
drivers/video/mb862xx/mb862xxfb.c:724: warning: excess elements in struct initializer
drivers/video/mb862xx/mb862xxfb.c:724: warning: (near initialization for 'of_platform_mb862xxfb_driver')
drivers/video/mb862xx/mb862xxfb.c: In function 'mb862xxfb_init':
drivers/video/mb862xx/mb862xxfb.c:1038: error: implicit declaration of function 'of_register_platform_driver'
drivers/video/mb862xx/mb862xxfb.c: In function 'mb862xxfb_exit':
drivers/video/mb862xx/mb862xxfb.c:1049: error: implicit declaration of function 'of_unregister_platform_driver'

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Matteo Fortini <m.fortini@selcomgroup.com>
---
Andrew, could you remove
add-new-framebuffer-driver-for-fujitsu-mb862xx-gdcs-fix
patch from the -mm tree and apply this patch instead?

Only Lime support is dependent on OF. Carmine/CoralP support
isn't dependent on OF and should build on x86 too.

 drivers/video/Kconfig             |    3 ++-
 drivers/video/mb862xx/mb862xxfb.c |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 35bf659..7fe22cf 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2052,7 +2052,7 @@ config FB_MB862XX
 
 config FB_MB862XX_PCI_GDC
 	bool "Carmine/Coral-P(A) GDC"
-	depends on FB_MB862XX
+	depends on PCI && FB_MB862XX
 	---help---
 	  This enables framebuffer support for Fujitsu Carmine/Coral-P(A)
 	  PCI graphics controller devices.
@@ -2060,6 +2060,7 @@ config FB_MB862XX_PCI_GDC
 config FB_MB862XX_LIME
 	bool "Lime GDC"
 	depends on FB_MB862XX
+	depends on OF && !FB_MB862XX_PCI_GDC
 	select FB_FOREIGN_ENDIAN
 	select FB_LITTLE_ENDIAN
 	---help---
diff --git a/drivers/video/mb862xx/mb862xxfb.c b/drivers/video/mb862xx/mb862xxfb.c
index 26b66cb..38718d9 100644
--- a/drivers/video/mb862xx/mb862xxfb.c
+++ b/drivers/video/mb862xx/mb862xxfb.c
@@ -554,7 +554,7 @@ static int __devinit of_platform_mb862xx_probe(struct of_device *ofdev,
 	struct fb_info *info;
 	struct resource res;
 	resource_size_t res_size;
-	unsigned long ret;
+	unsigned long ret = -ENODEV;
 
 	if (of_address_to_resource(np, 0, &res)) {
 		dev_err(dev, "Invalid address\n");
-- 
1.5.3.3


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
