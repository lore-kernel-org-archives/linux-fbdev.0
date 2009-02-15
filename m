From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] arkfb: misplaced parentheses?
Date: Sun, 15 Feb 2009 16:57:56 +0100
Message-ID: <49983B84.7010002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roel.kluin@gmail.com>) id 1LYjNd-0003Ag-AS
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 15 Feb 2009 15:58:05 +0000
Received: from mail-ew0-f15.google.com ([209.85.219.15])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LYjNX-00051w-CP for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 15 Feb 2009 15:58:05 +0000
Received: by ewy8 with SMTP id 8so1626536ewy.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 15 Feb 2009 07:57:57 -0800 (PST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: adaplas@gmail.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net

I think below is what was intended? otherwise we could as well have written:

regval || (code[0] & 4) ? 0x80 : 0)

But it doesn't seem likely that regval should be considered as boolean

please review.
-------------------------->8------------------8<---------------------------
fix misplaced parentheses

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index 314d186..d583bea 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -470,7 +470,7 @@ static void ark_dac_read_regs(void *data, u8 *code, int count)
 
 	while (count != 0)
 	{
-		vga_wseq(NULL, 0x1C, regval | (code[0] & 4) ? 0x80 : 0);
+		vga_wseq(NULL, 0x1C, regval | (code[0] & 4 ? 0x80 : 0));
 		code[1] = vga_r(NULL, dac_regs[code[0] & 3]);
 		count--;
 		code += 2;
@@ -485,7 +485,7 @@ static void ark_dac_write_regs(void *data, u8 *code, int count)
 
 	while (count != 0)
 	{
-		vga_wseq(NULL, 0x1C, regval | (code[0] & 4) ? 0x80 : 0);
+		vga_wseq(NULL, 0x1C, regval | (code[0] & 4 ? 0x80 : 0));
 		vga_w(NULL, dac_regs[code[0] & 3], code[1]);
 		count--;
 		code += 2;

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
