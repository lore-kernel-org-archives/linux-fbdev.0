From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: Problem with current fb_get_color_depth function
Date: Wed, 3 Nov 2004 06:10:12 +0800
Message-ID: <200411030610.12231.adaplas@hotpop.com>
References: <20041010225903.GA2418@darjeeling.triplehelix.org> <200410110832.19978.adaplas@hotpop.com> <20041102055555.GJ6361@triplehelix.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CP6rO-0007Oi-F5
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 14:10:38 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CP6rM-0005We-Gj
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 14:10:38 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 0C91D982EAD
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  2 Nov 2004 22:10:22 +0000 (UTC)
In-Reply-To: <20041102055555.GJ6361@triplehelix.org>
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
To: Joshua Kwan <joshk@triplehelix.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net

On Tuesday 02 November 2004 13:55, Joshua Kwan wrote:
> [ long overdue follow-up ]
>
> On Mon, Oct 11, 2004 at 08:33:10AM +0800, Antonino A. Daplas wrote:
> > So, linux_logo_224 cannot be drawn when visual is directcolor at RGB555
> > or RGB565 because the logo clut requirements exceeds the hardware clut
> > capability. You need to use a logo image with a lower depth such as the
> > 16-color logo, linux_logo_16.
>
> This is weird, because removing that conditional from fb_get_color_depth
> allows a 224-color logo to show correctly on my Radeon framebuffer, in
> full color.
>
> Otherwise, it is dithered to kingdom come and mostly appears all orange
> and black.
>
> You may be right conceptually, but the fact of the matter is that this
> is a regression because 224-color logos work perfectly with the old
> fb_get_color_depth. So what is the real problem?
>

After giving it a lot of thought, perhaps you are not booting at 16 bpp, but
at 8bpp pseudocolor.  However, radeonfb's default var use only a red, green,
and blue length of 6.  Try this patch and let me know if it helps.

Tony

diff -Nru a/drivers/video/aty/radeon_monitor.c b/drivers/video/aty/radeon_monitor.c
--- a/drivers/video/aty/radeon_monitor.c	2004-10-27 14:58:07 +08:00
+++ b/drivers/video/aty/radeon_monitor.c	2004-10-28 06:04:32 +08:00
@@ -12,9 +12,9 @@
 	.xres_virtual	= 640,
 	.yres_virtual	= 480,
 	.bits_per_pixel = 8,
-	.red		= { 0, 6, 0 },
-	.green		= { 0, 6, 0 },
-	.blue		= { 0, 6, 0 },
+	.red		= { 0, 8, 0 },
+	.green		= { 0, 8, 0 },
+	.blue		= { 0, 8, 0 },
 	.activate	= FB_ACTIVATE_NOW,
 	.height		= -1,
 	.width		= -1,




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
