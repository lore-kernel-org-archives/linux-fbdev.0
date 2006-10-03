From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [patch] 2.6.18: pmagb-b-fb: Fix a default clock
	frequency
Date: Tue, 3 Oct 2006 16:54:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64N.0610031649000.4642@blysk.ds.pg.gda.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GUmbG-0005vY-29 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Oct 2006 08:54:30 -0700
Received: from pollux.ds.pg.gda.pl ([153.19.208.7])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GUmbE-0001Yz-M1
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Oct 2006 08:54:30 -0700
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id B08D0F62FA
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue,  3 Oct 2006 17:54:12 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bwbo4HlUe1UD
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue,  3 Oct 2006 17:54:12 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 6CC6AE1C79
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue,  3 Oct 2006 17:54:12 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.1) with ESMTP id k93FsKRN018430
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 3 Oct 2006 17:54:20 +0200
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

Hello,

 Inspection of real hardware has revealed one of the clock frequencies 
known to be supported by PMAGB-B hardware is off by 3kHz.  Following is a 
fix.  Please apply.

  Maciej

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

patch-mips-2.6.12-rc4-20050526-pmagb-b-74M-0
diff -up --recursive --new-file linux-mips-2.6.12-rc4-20050526.macro/drivers/video/pmagb-b-fb.c linux-mips-2.6.12-rc4-20050526/drivers/video/pmagb-b-fb.c
--- linux-mips-2.6.12-rc4-20050526.macro/drivers/video/pmagb-b-fb.c	2005-07-11 15:59:17.000000000 +0000
+++ linux-mips-2.6.12-rc4-20050526/drivers/video/pmagb-b-fb.c	2005-10-23 00:54:49.000000000 +0000
@@ -188,7 +188,7 @@ static void __init pmagbbfb_screen_setup
 static void __init pmagbbfb_osc_setup(struct fb_info *info)
 {
 	static unsigned int pmagbbfb_freqs[] __initdata = {
-		130808, 119843, 104000, 92980, 74367, 72800,
+		130808, 119843, 104000, 92980, 74370, 72800,
 		69197, 66000, 65000, 50350, 36000, 32000, 25175
 	};
 	struct pmagbbfb_par *par = info->par;

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
