From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Add acceleration support to ATI
 Imageon
Date: Thu, 23 Mar 2006 13:23:33 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0603231317370.16810@pademelon.sonytel.be>
References: <20060323112930.GA10090@pupilla>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMOqq-0000Ow-5S
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 04:23:40 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FMOqo-0007OS-Kl
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 04:23:40 -0800
In-Reply-To: <20060323112930.GA10090@pupilla>
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
Cc: Antonino Daplas <adaplas@pol.net>

On Thu, 23 Mar 2006, Mardy wrote:
> Hi, please consider applying the attached patch. It adds acceleration
> support in w100fb.c (i.e. ATI Imageons) for the copyarea and fillrect
> operations.
> 
> Since this is my first submission, please let me know if there's
> something else that should be done.

A Signed-Off-By line?

> +struct dp_gui_master_cntl_t {
> +	unsigned long gmc_src_pitch_offset_cntl		 : 1;
        ^^^^^^^^^^^^^
I'm not sure it's a good idea to use `long' here, since the size of long is
different for 32 and 64 bit platforms.

OTOH, in my copy of C99, I didn't immediately find out whether using `long' or
`int' here has any visible effect at all.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
