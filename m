From: Petr Baudis <pasky@ucw.cz>
Subject: [PATCH 2.6] fbcon font cloning fix
Date: Thu, 18 Mar 2004 22:57:13 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040318215713.GA3779@pasky.ji.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B45Vz-0006BS-LZ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 18 Mar 2004 13:57:23 -0800
Received: from ip-213-226-226-138.ji.cz
	([213.226.226.138] helo=machine.sinus.cz ident=qmailr)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1B45Vu-0000WY-9p
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 18 Mar 2004 13:57:18 -0800
Content-Disposition: inline
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
To: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

  Hello,

  this patch (against 2.6.4) fixes a bug which I hit when migrating from 2.4.
Basically, when I do setfont during the system boot, the then-spawned ttys do
not retain the new font but fall back to the default one.

  I've tracked that down to a clearly bogus test in fbcon_set_display(),
because vc->vc_font.width is not set at that time yet (no font has been loaded
for the new vc). But even if it would (or this was meant to test against
tmp->vc_font.width), it would mean only *HUGE* fonts would be retained.  And
even if there were *two* bugs there and it was supposed to be less-than there,
I couldn't make a sense of the test.

  Please consider applying.

 drivers/video/console/fbcon.c |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)

  Kind regards,
                                Petr Baudis

diff -rup linux/drivers/video/console/fbcon.c linux+pasky/drivers/video/console/fbcon.c
--- linux/drivers/video/console/fbcon.c	Thu Mar 18 22:14:28 2004
+++ linux+pasky/drivers/video/console/fbcon.c	Thu Mar 18 21:32:01 2004
@@ -746,19 +746,17 @@ static void fbcon_set_display(struct vc_
 		struct display *q = &fb_display[i];
 		struct vc_data *tmp = vc_cons[i].d;
 		
-		if (vc->vc_font.width > 32) {
-			/* If we are not the first console on this
-			   fb, copy the font from that console */
-			vc->vc_font.width = tmp->vc_font.width;
-			vc->vc_font.height = tmp->vc_font.height;
-			vc->vc_font.data = p->fontdata = q->fontdata;
-			p->userfont = q->userfont;
-			if (p->userfont) {
-				REFCOUNT(p->fontdata)++;
-				charcnt = FNTCHARCNT(p->fontdata);
-			}
-			con_copy_unimap(vc->vc_num, i);
+		/* If we are not the first console on this
+		   fb, copy the font from that console */
+		vc->vc_font.width = tmp->vc_font.width;
+		vc->vc_font.height = tmp->vc_font.height;
+		vc->vc_font.data = p->fontdata = q->fontdata;
+		p->userfont = q->userfont;
+		if (p->userfont) {
+			REFCOUNT(p->fontdata)++;
+			charcnt = FNTCHARCNT(p->fontdata);
 		}
+		con_copy_unimap(vc->vc_num, i);
 	}
 
 	if (!p->fontdata) {


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
