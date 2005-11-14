From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Use of 'reserved' fields in var_screeninfo
Date: Mon, 14 Nov 2005 20:30:13 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0511142029340.15023@numbat.sonytel.be>
References: <4378E2CB.3080902@mvista.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ebk25-0001mq-Q0
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Nov 2005 11:30:25 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Ebk20-0000sK-BX
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Nov 2005 11:30:25 -0800
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id jAEJUDiT004769
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Nov 2005 20:30:13 +0100 (MET)
In-Reply-To: <4378E2CB.3080902@mvista.com>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 14 Nov 2005, Kevin Hilman wrote:
> I've got a question about the purpose of the reserved fields in the
> var_screeninfo struct:
> 
> struct fb_var_screeninfo {
> 	[ ... ]
> 	__u32 reserved[5];		/* Reserved for future compatibility */
> };
> 
> What are these reserved for?  Is it appropriate for drivers to use these for

They are reserved for future expansion.

> additional, HW-specific values that are then made available to the VSCREENINFO
> ioctls?

Not really, only for generic info that's useful for multiple drivers.
What do you want to export there?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
