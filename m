From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Virtual framebuffer driver - mmap problem
Date: Wed, 8 Sep 2004 14:07:45 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0409081406380.20726@waterleaf.sonytel.be>
References: <77e82a3f0409080434722d7650@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C51Eq-0005a9-HB
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 08 Sep 2004 05:07:48 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C51Ep-00054F-MG
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 08 Sep 2004 05:07:48 -0700
In-Reply-To: <77e82a3f0409080434722d7650@mail.gmail.com>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>

On Wed, 8 Sep 2004, Shivappa Kushtagi wrote:
> I would like to use virtual framebuffer on a linux system which is
> installed with R.H.9 to simulate my target display ( an embedded
> device with 320*480 resolution).

The virtual framebuffer is intended for testing _the kernel_ only.

> I have written a application which will mmap /dev/fb0 and fill it with
> some RGB values. I run framebuffer based VNC server to see whatever I
> have written. I always get a white image. Looks like mmap is mapped to
> some other address and fbvnc server is reading from somewhere else.
>
> Does the existing drivers/video/vfb.c code works ? or Do I need to
> tweak it ?

You cannot mmap() the video memory of vfb.

Why don't you use vesafb?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
