From: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Fix warning in tdfxfb.c (Was: Re: IA32 (2.6.7 - 2004-06-18.22.30)
 - 2 New warnings (gcc 3.2.2))
Date: Sat, 19 Jun 2004 14:30:32 +0200 (CEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.56.0406191425340.18856@jjulnx.backbone.dif.dk>
References: <200406191135.i5JBZsXL017823@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bbf0P-0000hd-MN
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Jun 2004 05:31:33 -0700
Received: from mail.dif.dk ([193.138.115.101])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bbf0P-0000Bc-8p
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Jun 2004 05:31:33 -0700
Received: from localhost (localhost [127.0.0.1])
	by mail.dif.dk (Postfix) with ESMTP id 4F332FFC9C
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 19 Jun 2004 14:40:10 +0200 (CEST)
Received: from mail.dif.dk ([127.0.0.1])
 by localhost (saerimmer [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 23794-47 for <linux-fbdev-devel@lists.sourceforge.net>;
 Sat, 19 Jun 2004 14:40:08 +0200 (CEST)
Received: from diftmgw2.backbone.dif.dk (diftmgw2.backbone.dif.dk [10.227.136.246])
	by mail.dif.dk (Postfix) with ESMTP id F33D8FFCA9
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 19 Jun 2004 14:40:05 +0200 (CEST)
In-Reply-To: <200406191135.i5JBZsXL017823@cherrypit.pdx.osdl.net>
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
To: John Cherry <cherry@osdl.org>
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 19 Jun 2004, John Cherry wrote:

> drivers/video/tdfxfb.c:1104: warning: initialization discards qualifiers from pointer target type

Here's a patch for that.

The issue is that the mask member of struct fb_cursor is const, so
we shouldn't be assigning it to a non-const char*

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.7-orig/drivers/video/tdfxfb.c	2004-06-16 07:19:02.000000000 +0200
+++ linux-2.6.7/drivers/video/tdfxfb.c	2004-06-19 14:25:16.000000000 +0200
@@ -1101,7 +1101,7 @@ static int tdfxfb_cursor(struct fb_info
 		 */
 		u8 *cursorbase = (u8 *) info->cursor.image.data;
 		char *bitmap = (char *)cursor->image.data;
-		char *mask = cursor->mask;
+		const char *mask = cursor->mask;
 		int i, j, k, h = 0;

 		for (i = 0; i < 64; i++) {


--
Jesper Juhl <juhl-lkml@dif.dk>



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
