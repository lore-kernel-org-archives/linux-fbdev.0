From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Subject: Re: [PATCH, 2.4] Add logo drawing support for 8-bit mono
Date: Sun, 27 Apr 2003 02:08:41 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030427000841.GI31642@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030426233557.GF31642@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from iris1.csv.ica.uni-stuttgart.de ([129.69.118.2])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 199ZjI-0001db-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 26 Apr 2003 17:09:17 -0700
Content-Disposition: inline
In-Reply-To: <20030426233557.GF31642@rembrandt.csv.ica.uni-stuttgart.de>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Thiemo Seufer wrote:
> Hello Geert,
> 
> this patch adds logo drawing support for mono visuals with 8 bits
> per pixel. The DECstation's PMAG-AA is such a card.
> 
> 2.4 only, the 2.5 logo code is very different.

This patch is also needed to make it work.


Thiemo


diff -BurpNX /bigdisk/src/dontdiff linux-orig/drivers/video/fbcon.c linux/drivers/video/fbcon.c
--- linux-orig/drivers/video/fbcon.c	Sat Jan 11 22:55:05 2003
+++ linux/drivers/video/fbcon.c	Sat Apr 12 15:44:11 2003
@@ -2328,7 +2329,9 @@ static int __init fbcon_show_logo( void 
 	}
 #endif
 #if defined(CONFIG_FBCON_CFB8) || defined(CONFIG_FB_SBUS)
-	if (depth == 8 && p->type == FB_TYPE_PACKED_PIXELS) {
+	if (depth == 8 && p->type == FB_TYPE_PACKED_PIXELS
+	    && p->visual != FB_VISUAL_MONO10
+	    && p->visual != FB_VISUAL_MONO01) {
 	    /* depth 8 or more, packed, with color registers */
 		
 	    src = logo;


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
