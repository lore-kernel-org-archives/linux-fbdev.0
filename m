From: James Simmons <jsimmons@infradead.org>
Subject: Re: [BK PATCHS] fbdev updates.
Date: Fri, 18 Oct 2002 10:16:46 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210181012560.10832-100000@maxwell.earthlink.net>
References: <Pine.GSO.4.21.0210151109180.25245-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 182aqV-00017m-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Oct 2002 10:23:35 -0700
In-Reply-To: <Pine.GSO.4.21.0210151109180.25245-100000@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Russell King <rmk@arm.linux.org.uk>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> So the generic part of the code should behave like this:
>
>   if (info->fbops->fb_blank && info->fbops->fb_blank(blank_flag)) {
>       /* use hardware blanking */
>   } else if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR ||
> 	     info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
>       /* use software blanking */
>   } else {
>       /* no blanking possible, except for filling the screen with black, which
> 	 is not appropriate (unless we save/restore the contents?) */
>   }
>
> Is that OK for you?

I was thinking more like

   if (info->fbops->fb_blank && info->fbops->fb_blank(blank_flag)) {
       /* use hardware blanking */
   } else if (info->var.accel_flags) {
	/* Use hardware fillrect to blank the screen */
 	info->fbops->fb_fillrect(info, whole_screen);
   } else {
	/* Nothing avaiable. Use set the colormap to black */
   }

What do you think?



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
