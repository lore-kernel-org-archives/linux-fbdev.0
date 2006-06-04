From: Malcolm Parsons <malcolm.parsons@gmail.com>
Subject: [PATCH] Fix fbcon limited scroll in
	SCROLL_PAN_REDRAW mode
Date: Sun, 4 Jun 2006 11:02:03 +0100
Message-ID: <20060604100202.GA22768@arthur>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FnQRG-0005Bo-PE for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Jun 2006 18:32:59 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FnQRB-0003kV-7g for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Jun 2006 18:32:53 -0700
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FmpQs-0001LM-4o
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 04 Jun 2006 03:02:07 -0700
Received: from [172.23.170.147] (helo=anti-virus03-10)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1FmpQq-0008J0-9n for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 04 Jun 2006 11:02:04 +0100
Received: from [82.33.127.97] (helo=arthur)
	by asmtp-out3.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1FmpQp-0002XM-QQ for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 04 Jun 2006 11:02:03 +0100
Received: from malcolm by arthur with local (Exim 4.62)
	(envelope-from <malcolm.parsons@gmail.com>) id 1FmpQp-000643-5A
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 04 Jun 2006 11:02:03 +0100
Content-Disposition: inline
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


When scrolling up in SCROLL_PAN_REDRAW mode with a large limited scroll
region, the bottom few lines have to be redrawn.  Without this patch, 
the wrong text is drawn into these lines, corrupting the display.

Observed in 2.6.14 when running an IRC client in the Nintendo DS linux
port.

I haven't tested if scrolling down has the same problem.

Patch against 2.6.17-rc5 (git):

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 953eb8c..47ba1a7 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -1745,7 +1745,7 @@ static int fbcon_scroll(struct vc_data *
 					fbcon_redraw_move(vc, p, 0, t, count);
 				ypan_up_redraw(vc, t, count);
 				if (vc->vc_rows - b > 0)
-					fbcon_redraw_move(vc, p, b - count,
+					fbcon_redraw_move(vc, p, b,
 							  vc->vc_rows - b, b);
 			} else
 				fbcon_redraw_move(vc, p, t + count, b - t - count, t);
