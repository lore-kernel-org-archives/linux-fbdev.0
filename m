From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 0/8] fbcon: Console Rotation
Date: Mon, 07 Nov 2005 18:59:46 +0800
Message-ID: <436F33A2.6070107@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZ5AX-0004RA-Fa
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 03:28:09 -0800
Received: from xproxy.gmail.com ([66.249.82.196])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EZ5AV-00057d-UE
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 03:28:09 -0800
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
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sf.net

This patch series implements generic code to rotate the console at 90, 180,
and 270 degrees. The implementation is completely done in the framebuffer
console level, thus no changes to the framebuffer layer or to the drivers
are needed.

Console rotation is required by some Sharp-based devices where the natural
orientation of the display is not at 0 degrees. Also, users that have
displays that can pivot will benefit by having a console in portrait mode
if they so desire.

The choice to implement the code in the console layer rather than in the
framebuffer layer is due to the following reasons:

- it's fast
- it does not require driver changes
- it can coexist with devices that can rotate the display at the hardware level
- it complements graphics applications that can do display rotation

The changes to core fbcon are minimal-- recognition of the console
rotation angle so it can swap directions, origins and axes (xres vs yres,
xpanstep vs ypanstep, xoffset vs yoffset, etc) and storage of the rotation
angle per display. The bulk of the code that does the actual drawing to the
screen are placed in separate files. Each angle of rotation has separate
methods (bmove, clear, putcs, cursor, update_start which is derived from
update_var, and clear_margins).  To mimimize processing time, the fontdata
are pre-rotated at each console switch (only if the font or the angle has
changed). 

The option can be compiled out (CONFIG_FRAMEBUFFER_CONSOLE_ROTATION = n) if
rotation is not needed. 

Choosing the rotation angle can be done in several ways:

1. boot option fbcon=rotate:n, where
     n = 0 - normal
     n = 1 - 90 degrees (clockwise)
     n = 2 - 180 degrees (upside down)
     n = 3 - 270 degrees (counterclockwise)

2. echo n > /sys/class/graphics/fb[num]/con_rotate
 
     where n is the same as described above. It sets the angle of rotation
of the current console

3 echo n > /sys/class/graphics/fb[num]/con_rotate_all

     where n is the same as described above. Globally sets the angle of
rotation.

GOTCHAS:

	The option, especially at angles of 90 and 270 degrees, will exercise
the least used code of drivers.  Namely, at these angles, panning is done
in the x-axis, so it can reveal bugs in the driver if xpanstep is set
incorrectly. A workaround is to set xpanstep = 0.

	Secondly, at these angles, the framebuffer memory access can be
unaligned if (fontheight * bpp) % 32 ~= 0 which can reveal bugs in the drivers
imageblit, fillrect and copyarea functions.  (I think cfbfillrect may have
this buglet). A workaround is to use a standard 8x16 font.

Speed:

	The scrolling speed difference between 0 and 180 degrees is minimal,
somewhere areound 1-2%.  At 90 or 270 degress, speed drops down to a vicinity
of 30-40%. This is understandable because the blit direction is across the
framebuffer "direction." Scrolling will be helped at these angles if xpanstep
is not equal to zero, use of 8x16 fonts, and setting xres_virtual >= xres * 2.

Note: The code is tested on little-endian only, so I don't know if it will
work in big-endian. Please let me know, it will take only less than a minute
of your time.

Tony



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
