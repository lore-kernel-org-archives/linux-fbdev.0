From: Peter Samuelson <peter@p12n.org>
Subject: Re: [patch] con2fbmap limit check
Date: Wed, 31 Oct 2007 15:50:20 -0500
Message-ID: <20071031205020.GC27631@p12n.org>
References: <20071031145819.GB27631@p12n.org>
	<Pine.LNX.4.64.0710312048270.12491@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1InKWE-0002MK-VV for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Oct 2007 13:50:31 -0700
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1InKWD-0006gi-Ah
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Oct 2007 13:50:30 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710312048270.12491@anakin>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net


[Geert Uytterhoeven]
> No patch included?

Ha.  Guess I was hasty.  Sorry about that.
-- 
Peter Samuelson | org-tld!p12n!peter | http://p12n.org/

commit fe3c8a57a2f8c0b169898c5a0b5f3dcc6de5943e
Author: Peter Samuelson <peter@p12n.org>
Date:   Wed Oct 31 09:49:28 2007 -0500

    Fix limit check in FBIOPUT_CON2FBMAP ioctl.
    
    Signed-Off-By: Peter Samuelson <peter@p12n.org>

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 1194f5e..df679ef 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1057,7 +1057,7 @@ fb_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 	case FBIOPUT_CON2FBMAP:
 		if (copy_from_user(&con2fb, argp, sizeof(con2fb)))
 			return - EFAULT;
-		if (con2fb.console < 0 || con2fb.console > MAX_NR_CONSOLES)
+		if (con2fb.console < 1 || con2fb.console > MAX_NR_CONSOLES)
 		    return -EINVAL;
 		if (con2fb.framebuffer < 0 || con2fb.framebuffer >= FB_MAX)
 		    return -EINVAL;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
