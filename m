From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Screen Capturing
Date: Fri, 27 Dec 2002 12:33:18 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0212271225240.17067-100000@vervain.sonytel.be>
References: <005401c2ad82$cef8c9c0$bd00000a@abhilash>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Rskg-0007pN-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 27 Dec 2002 03:34:06 -0800
In-Reply-To: <005401c2ad82$cef8c9c0$bd00000a@abhilash>
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
To: Abhilash <abhilash@avenir.net>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 27 Dec 2002, Abhilash wrote:
> I need to capture the screen .For that I use mirror driver in Windows for
> capturing screen.
> ie, its basically overloading the driver functions.
> 
> So in case of Linux, is there any method like this or which is the best
> method?
> In Xlib there are some functions to capture screen and also heard abt VESA
> which is better?

If you are using a frame buffer device, you can capture the contents of
/dev/fb*. Either read from /dev/fb*, or mmap() it. The data you receive are in
the native format of the graphics chip. For CLUT modes, you have to use an
ioctl() to get the colormap.

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
