From: domen@coderock.org
Subject: [patch 5/9] drivers/video/intelfb/*: convert to pci_register_driver
Date: Sun, 06 Mar 2005 11:36:24 +0100
Message-ID: <20050306103625.30A8F1F23D@trashy.coderock.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7t7m-0001gS-Rb
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Mar 2005 02:36:38 -0800
Received: from coderock.org
	([193.77.147.115] helo=trashy.coderock.org ident=postfix)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D7t7m-00061m-7u
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Mar 2005 02:36:38 -0800
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, domen@coderock.org, c.lucas@ifrance.com


convert from pci_module_init to pci_register_driver
(from:http://kerneljanitors.org/TODO).

Signed-off-by: Christophe Lucas <c.lucas@ifrance.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/video/intelfb/intelfbdrv.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/video/intelfb/intelfbdrv.c~pci_register_driver-drivers_video_intelfb drivers/video/intelfb/intelfbdrv.c
--- kj/drivers/video/intelfb/intelfbdrv.c~pci_register_driver-drivers_video_intelfb	2005-03-05 16:12:59.000000000 +0100
+++ kj-domen/drivers/video/intelfb/intelfbdrv.c	2005-03-05 16:12:59.000000000 +0100
@@ -253,7 +253,7 @@ intelfb_init(void)
 	intelfb_setup(option);
 #endif
 
-	return pci_module_init(&intelfb_driver);
+	return pci_register_driver(&intelfb_driver);
 }
 
 static void __exit
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
