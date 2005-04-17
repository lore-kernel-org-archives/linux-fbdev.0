From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] drivers/video/fbmem.c: make a function static
Date: Mon, 18 Apr 2005 01:24:19 +0200
Message-ID: <20050417232419.GU3625@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DNJ7u-00067Z-Sc
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Apr 2005 16:24:30 -0700
Received: from emailhub.stusta.mhn.de ([141.84.69.5] helo=mailout.stusta.mhn.de)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DNJ7t-0007dA-6b
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Apr 2005 16:24:30 -0700
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc2-mm3-full/drivers/video/fbmem.c.old	2005-04-18 00:39:21.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/video/fbmem.c	2005-04-18 00:39:34.000000000 +0200
@@ -1312,7 +1312,7 @@
  *	Returns zero.
  *
  */
-int __init video_setup(char *options)
+static int __init video_setup(char *options)
 {
 	int i, global = 0;
 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
