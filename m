From: domen@coderock.org
Subject: [patch 4/9] drivers/video/console/*: convert to pci_register_driver
Date: Sun, 06 Mar 2005 11:36:21 +0100
Message-ID: <20050306103622.1BC1D1F23C@trashy.coderock.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7t7o-0001gh-G3
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Mar 2005 02:36:40 -0800
Received: from coderock.org
	([193.77.147.115] helo=trashy.coderock.org ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D7t7n-0003Zf-QU
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Mar 2005 02:36:40 -0800
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


 kj-domen/drivers/video/console/sticore.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/video/console/sticore.c~pci_register_driver-drivers_video_console drivers/video/console/sticore.c
--- kj/drivers/video/console/sticore.c~pci_register_driver-drivers_video_console	2005-03-05 16:12:58.000000000 +0100
+++ kj-domen/drivers/video/console/sticore.c	2005-03-05 16:12:58.000000000 +0100
@@ -1050,7 +1050,7 @@ static void __init sti_init_roms(void)
 
 	/* Register drivers for native & PCI cards */
 	register_parisc_driver(&pa_sti_driver);
-	pci_module_init(&pci_sti_driver);
+	pci_register_driver(&pci_sti_driver);
 
 	/* if we didn't find the given default sti, take the first one */
 	if (!default_sti)
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
