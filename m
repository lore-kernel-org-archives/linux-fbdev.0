From: James Simmons <jsimmons@infradead.org>
Subject: small fbmem.c fix.
Date: Tue, 17 Feb 2004 04:36:56 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0402170435070.24924-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Asx2b-0002rf-EL
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 16 Feb 2004 20:41:01 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Aswsn-0001bE-Oj
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 16 Feb 2004 20:30:54 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


The platinum framebuffer is repeated twice. Removed one of them.


--- fbmem.c	2004-02-16 00:50:15.000000000 -0800
+++ fbmem.c.new	2004-02-16 04:42:15.000000000 -0800
@@ -107,8 +107,6 @@
 extern int platinumfb_setup(char*);
 extern int control_init(void);
 extern int control_setup(char*);
-extern int platinum_init(void);
-extern int platinum_setup(char*);
 extern int valkyriefb_init(void);
 extern int valkyriefb_setup(char*);
 extern int chips_init(void);
r



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
