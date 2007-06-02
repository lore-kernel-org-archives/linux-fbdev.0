From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 22/24] intelfb: The pseudo_palette is
	only 16 elements long
Date: Sat, 02 Jun 2007 18:14:31 +0800
Message-ID: <46614307.6090106@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HuQl9-0000VW-3z for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:22:59 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HuQl8-0001yO-PF
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:22:59 -0700
Received: by py-out-1112.google.com with SMTP id u77so1509666pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 02 Jun 2007 03:22:58 -0700 (PDT)
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
Cc: Sylvain Meyer <sylvain.meyer@worldonline.fr>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

The pseudo_palette is only 16 elements long.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/intelfb/intelfb.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/intelfb/intelfb.h b/drivers/video/intelfb/intelfb.h
index 80b94c1..6148300 100644
--- a/drivers/video/intelfb/intelfb.h
+++ b/drivers/video/intelfb/intelfb.h
@@ -302,7 +302,7 @@ struct intelfb_info {
 	u32 ring_lockup;
 
 	/* palette */
-	u32 pseudo_palette[17];
+	u32 pseudo_palette[16];
 
 	/* chip info */
 	int pci_chipset;


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
