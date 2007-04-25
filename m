From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 14/41] i810fb: Fix incorrect frequency
	mask
Date: Wed, 25 Apr 2007 14:34:16 +0800
Message-ID: <462EF668.5030701@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hgc6a-0000xy-A1 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:40:01 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hgc6a-0002pB-0T
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:40:00 -0700
Received: by py-out-1112.google.com with SMTP id a29so116192pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:39:59 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Fix a long-standing bug.  The mask used to detect a 100Mhz or 133Mhz chipset
is incorrect. (The only side effect of this bug is that it will choose an
incorrect watermark).

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/i810/i810.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/i810/i810.h b/drivers/video/i810/i810.h
index aa65ffc..889e4ea 100644
--- a/drivers/video/i810/i810.h
+++ b/drivers/video/i810/i810.h
@@ -133,7 +133,7 @@ #define FONTDATAMAX                 8192
 /* Masks (AND ops) and OR's */
 #define FB_START_MASK               (0x3f << (32 - 6))
 #define MMIO_ADDR_MASK              (0x1FFF << (32 - 13))
-#define FREQ_MASK                   0x1EF
+#define FREQ_MASK                   (1 << 4)
 #define SCR_OFF                     0x20
 #define DRAM_ON                     0x08            
 #define DRAM_OFF                    0xE7


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
