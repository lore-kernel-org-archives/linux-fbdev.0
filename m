From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fbdraw 0.1 available
Date: Sat, 11 Sep 2004 12:53:23 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0409111241390.17924@waterleaf.sonytel.be>
References: <41426651.2010201@comcast.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C65VY-0007XJ-SE
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Sep 2004 03:53:28 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C65VY-00080M-3x
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Sep 2004 03:53:28 -0700
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i8BArNMp023605
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 Sep 2004 12:53:24 +0200 (MEST)
In-Reply-To: <41426651.2010201@comcast.net>
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

On Fri, 10 Sep 2004, Zack wrote:
> My changes to permit (optional) in-kernel drawing for applications
> are available. It's only version 0.1 at this point, meaning alpha,
> but I'm happy with the performance and structure. I've included
> a test application that allows benchmarking.
>
> home.comcast.net/~plinius/fbdraw-0.1.tar.gz
>
> To install, move the tarfile to the 2.6.8.1 root dir, and use
> tar zxfv fbdraw-0.1.tar.gz.
>
> Constructive criticism is welcome.

A few comments/questions:

  - Is there any special reason why you implement your own fb_fill_area() and
    fb_copy_area() (which doesn't do anything?), while fb_fillrect() and
    fb_copyarea() already exist?

  - Do you have compared the performance of your fbdraw compared to user space
    mmap()ing the frame buffer and doing all drawings in user space?

BTW, I'm also considering exporting fb_fillrect(), fb_copyarea(), and
fb_imageblit() to userspace, but for a different reason.

Right now applications need to know the exact frame buffer layout. For most
modern PC graphics cards that's OK, since they all do cfb8/16/24/32. But older
(usually unaccelerated) and embedded hardware may use a different layout (e.g.
seperate buffers for even and odd display lines on some set top box hardware,
bitplanes, ...) putting a severe burden on applications.

By letting the application draw to a fixed format cfb8 (pseudocolor) or cfb32
(RGBA) shadow buffer and call the kernel for updating the screen, this can be
solved in a generic way.  Currently now fb_imageblit() already has to do the
conversion from cfb8 to native layout anyway.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
