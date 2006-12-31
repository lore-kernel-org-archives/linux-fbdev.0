From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] matroxfb: Use kzalloc
Date: Sun, 31 Dec 2006 17:06:05 +0100
Message-ID: <20061231170605.30fd7005.khali@linux-fr.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H1Tt7-0001mi-Eb for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jan 2007 12:36:05 -0800
Received: from smtp-101-monday.nerim.net ([62.4.16.101] helo=kraid.nerim.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1H1Tt7-0004TX-2S
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jan 2007 12:36:05 -0800
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
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net

Use kzalloc instead of kmalloc+memset, twice.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/video/matrox/i2c-matroxfb.c   |    4 +---
 drivers/video/matrox/matroxfb_crtc2.c |    3 +--
 2 files changed, 2 insertions(+), 5 deletions(-)

--- linux-2.6.20-rc2.orig/drivers/video/matrox/i2c-matroxfb.c	2006-12-31 17:01:35.000000000 +0100
+++ linux-2.6.20-rc2/drivers/video/matrox/i2c-matroxfb.c	2006-12-31 17:03:01.000000000 +0100
@@ -146,7 +146,7 @@ static void* i2c_matroxfb_probe(struct m
 	unsigned long flags;
 	struct matroxfb_dh_maven_info* m2info;
 
-	m2info = kmalloc(sizeof(*m2info), GFP_KERNEL);
+	m2info = kzalloc(sizeof(*m2info), GFP_KERNEL);
 	if (!m2info)
 		return NULL;
 
@@ -155,8 +155,6 @@ static void* i2c_matroxfb_probe(struct m
 	matroxfb_DAC_out(PMINFO DAC_XGENIOCTRL, 0x00);
 	matroxfb_DAC_unlock_irqrestore(flags);
 
-	memset(m2info, 0, sizeof(*m2info));
-
 	switch (ACCESS_FBINFO(chip)) {
 		case MGA_2064:
 		case MGA_2164:
--- linux-2.6.20-rc2.orig/drivers/video/matrox/matroxfb_crtc2.c	2006-12-31 17:01:34.000000000 +0100
+++ linux-2.6.20-rc2/drivers/video/matrox/matroxfb_crtc2.c	2006-12-31 17:03:01.000000000 +0100
@@ -694,12 +694,11 @@ static void* matroxfb_crtc2_probe(struct
 	/* hardware is CRTC2 incapable... */
 	if (!ACCESS_FBINFO(devflags.crtc2))
 		return NULL;
-	m2info = kmalloc(sizeof(*m2info), GFP_KERNEL);
+	m2info = kzalloc(sizeof(*m2info), GFP_KERNEL);
 	if (!m2info) {
 		printk(KERN_ERR "matroxfb_crtc2: Not enough memory for CRTC2 control structs\n");
 		return NULL;
 	}
-	memset(m2info, 0, sizeof(*m2info));
 	m2info->primary_dev = MINFO;
 	if (matroxfb_dh_registerfb(m2info)) {
 		kfree(m2info);


-- 
Jean Delvare

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
