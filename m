From: "Mukund JB." <mukundjb@esntechnologies.co.in>
Subject: Is framebufer driver a replacement for video driver?
Date: Thu, 4 Nov 2004 21:59:29 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB348111ECB1B@mail.esn.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPkSr-0002RE-Hd
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Nov 2004 08:27:57 -0800
Received: from [202.125.86.130] (helo=ns2.astrainfonets.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CPkSp-0001lD-Lq
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Nov 2004 08:27:57 -0800
Content-class: urn:content-classes:message
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@hotpop.com, tonnerre@thundrix.ch


Hi all,

I have a small query. I may be silly, but please help by make it clear.

Framebuffer definition :-

The frame buffer device provides an abstraction for the graphics
hardware. It represents the frame buffer of some video hardware and
allows application software to access the graphics hardware through a
well-defined interface, so the software doesn't need to know anything
about the low-level (hardware register) stuff.

Does a framebuffer driver directly interact with the hardware registers
of the video card?=20
					or=20

Is there a generic low level driver that will interact with the
hardware?

What happens when I say startx at command prompt with XF86Config-4 file
configured for framebuffer driver?

Is it like, When I say startx with XF86Config-4 file configured for
framebuffer driver, the video we get is a result of X server using the
framebuffer driver directly? Right?

In this case, Is there a video driver involved in getting the video
apart from the framebuffer driver?

Thanks for the linux society for the continues support.

Regards,
Mukund jampala



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
