From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Subject: Re: Default timings in vga16fb driver
Date: Thu, 25 Nov 2004 15:55:06 +0100
Message-ID: <41A5F24A.4040804@fujitsu-siemens.com>
References: <41A36DA5.8090200@fujitsu-siemens.com> <200411250016.25813.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010001080203020100090604"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CXL1l-0005Ke-6j
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Nov 2004 06:55:21 -0800
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CXL1i-0002v4-CH
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Nov 2004 06:55:21 -0800
In-Reply-To: <200411250016.25813.adaplas@hotpop.com>
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
To: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010001080203020100090604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Antonino A. Daplas wrote:

> I don't think you overlooked anything. The default modeline of vga16fb
> should be corrected.

OK, so here's the patch (using the timings from /etc/fb.modes). Should I 
send it to linux-kernel, too?

Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy


--------------010001080203020100090604
Content-Type: text/x-patch;
 name="vga16.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vga16.diff"

Patch:	Fix default timings in vga16fb.c

Author: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
Signed-off-by: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>

This patch adapts the timings of the default mode in vga16fb.c
to the 640x480-60 timings in /etc/fb.modes. 

In particular, the total screen height is fixed to be 525 pixels 
rather than 529. The height of 529 was causing trouble on some LCD displays.

(Note: To make the mode 100% identical to the one in /etc/fb.modes,
the pixclock must be set to 39722, too; I didn't want to do that here).

--- linux-2.6.5-7.111/drivers/video/vga16fb.c.orig	2004-11-25 15:38:11.000000000 +0100
+++ linux-2.6.5-7.111/drivers/video/vga16fb.c	2004-11-25 15:45:54.000000000 +0100
@@ -91,8 +91,8 @@ static struct fb_var_screeninfo vga16fb_
 	.pixclock	= 39721,
 	.left_margin	= 48,
 	.right_margin	= 16,
-	.upper_margin	= 39,
-	.lower_margin	= 8,
+	.upper_margin	= 33,
+	.lower_margin	= 10,
 	.hsync_len 	= 96,
 	.vsync_len	= 2,
 	.vmode		= FB_VMODE_NONINTERLACED,

--------------010001080203020100090604--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
