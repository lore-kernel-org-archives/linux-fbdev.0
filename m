From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [BK PATCHS] fbdev updates.
Date: Tue, 15 Oct 2002 11:14:03 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0210151109180.25245-100000@vervain.sonytel.be>
References: <20021015100024.A9771@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 181Nna-0007xT-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Oct 2002 02:15:34 -0700
In-Reply-To: <20021015100024.A9771@flint.arm.linux.org.uk>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, 15 Oct 2002, Russell King wrote:
> I'm not sure this "set var" business has been thought out as much as it
> should be.
> 
> If can_soft_blank is not set, the driver will never, ever receive any
> calls to perform blanking via the fb_blank callback.  Even the power
> management blanking calls are blocked, and fbcon clears the screen
> instead.  This in itself is fine.
> 
> However, since the set_var method has gone, drivers are now unable to
> set can_soft_blank according to their capabilities because
> fbgen.c:gen_set_disp will do it for them thusly:
> 
>         if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR ||
>             info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
>                 display->can_soft_blank = info->fbops->fb_blank ? 1 : 0;
>                 display->dispsw_data = NULL;
>         } else {
>                 display->can_soft_blank = 0;
>                 display->dispsw_data = info->pseudo_palette;
>         }
> 
> This sucks on devices where blanking can be performed by hardware means.
> For example, on embedded devices, you can turn off the LCD controller
> and LCD panel (and thereby save power).  There's no point in having both
> these powered/running when the display is not in use, draining valuable
> battery power.
> 
> This is also true of most, if not all VGA cards when VESA blanking is in
> effect.  As the code currently stands, if the console is in pseudo colour
> or direct colour mode, everything works as expected.  However, if it isn't,
> you can't even power down your monitor when the screen blanks.
> 
> In 2.5.42, there is a work around possible - it is possible to intercept
> the call to gen_set_var, and set con_soft_blank according to your driver
> capabilities.  However, with the fb_set_var method going away, this is no
> longer possible.

So the generic part of the code should behave like this:

  if (info->fbops->fb_blank && info->fbops->fb_blank(blank_flag)) {
      /* use hardware blanking */
  } else if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR ||
	     info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
      /* use software blanking */
  } else {
      /* no blanking possible, except for filling the screen with black, which
	 is not appropriate (unless we save/restore the contents?) */
  }

Is that OK for you?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
