From: "Somsak Sriprayoonsakul" <ssy@hpcnc.cpe.ku.ac.th>
Subject: Can't correctly set palette
Date: Wed, 6 Aug 2003 15:25:33 +0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <002701c35bf4$663764c0$16226c9e@hpcncd.cpe.ku.ac.th>
Reply-To: "Somsak Sriprayoonsakul" <ssy@hpcnc.cpe.ku.ac.th>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from nontri.ku.ac.th ([158.108.2.71] helo=ku.ac.th)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19kJdq-0003ul-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 06 Aug 2003 01:27:30 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: kraxel@goldbach.in-berlin.de

Hello,
    I am trying to create a graphical RedHat Linux bootup using Frame Buffer
pixmap drawing (with the help of bogl library with bogl_put function). After
successfully display the image from the command prompt. I try to add my
image-drawing command to rc script, however, the image appeared to use wrong
palette, all color are distorted. It seems that if I am trying to display
the image in the different VT than the Vt that is running the program, the
color palette will always distort (using chvt xx && ./show_image). I try to
get the frame buffer palette using ioctl(FBIOGETCMAP) but it alwasy return
zero fb_cmap. What have I done wrong? Here are the details of my platform

frame buffer driver: vesafb (passing vga=0x301 at boot time)
image: 640x480 - 7 bit indexed color.

I also try libfbx and result is the same.

PS: Don't tell me to use default color palette. I need to display a nice 7
bit image in console mode.

------------------------------------------------------------------------
Somsak Sriprayoonsakul

High Performance Computing and Networking Center
Kasetsart University
ssy@hpcnc.cpe.ku.ac.th
----------------------------------------------------------------------------
---



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
