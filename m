From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: PATCH: move soft_cursor into fbconsole
Date: Sat, 11 Jun 2005 22:35:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0506112234430.22598@numbat.sonytel.be>
References: <9e47339105061021571f479b10@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DhChb-00078C-Sh
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Jun 2005 13:35:35 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DhCha-0005KW-3o
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Jun 2005 13:35:35 -0700
In-Reply-To: <9e47339105061021571f479b10@mail.gmail.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, James Simmons <jsimmons@pentafluge.infradead.org>

On Sat, 11 Jun 2005, Jon Smirl wrote:
> James has indicated that the soft_cursor only works with fbconsole and
> it won't work from user space. This means that soft_cursor is in the
> way of using a hardware cursor from user space. This patch removes
> soft_cursor from all of the drivers. So if the driver doesn't support
> a hardware cursor fb_cursor is NULL.
> 
> I also fixed the three drivers with hardware implementation. These
> drivers had cases where the hardware cursor had an error and then
> returned the software one instead. Now they return -ENODEV when they
> can't use the hardware one.
> 
> In console/bitlbt.c I made this change:
> 	/* First try the hardware cursor */
> 	if (info->fbops->fb_cursor)
> 		err = info->fbops->fb_cursor(info, &cursor);
> 	/* if that doesn't exist or didn't work, use the software one */
> 	if (err)
> 		soft_cursor(info, &cursor);
> 
> The effect of all of this is the make a clear path for getting to
> hardware cursors without triggering the soft_cursor fallback.
> Triggering of the fallback was moved into fb_console. This also lets
> me remove the softcursor module from memory when fb_console is not
> loaded.
> 
> Give this a try and let me know what you think. 

This patch corrupts some comments in drivers/video/amifb.c.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
