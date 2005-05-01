From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] drivers/video/fbmem.c: make a function static
Date: Sun, 1 May 2005 17:43:05 +0200
Message-ID: <20050501154305.GR3592@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DSGbC-0000Gu-Gk
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 01 May 2005 08:43:14 -0700
Received: from emailhub.stusta.mhn.de ([141.84.69.5] helo=mailout.stusta.mhn.de)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DSGbA-0000lO-JQ
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 01 May 2005 08:43:14 -0700
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
To: Andrew Morton <akpm@osdl.org>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 18 Apr 2005

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
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
