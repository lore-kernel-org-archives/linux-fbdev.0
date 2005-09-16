From: Lior Balkohen <balkohen@gmail.com>
Subject: fbcon woes with closed source framebuffer kernel module
Date: Fri, 16 Sep 2005 15:24:36 +0200
Message-ID: <196b7d3105091606241b4d2ba4@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EGGCr-0002zj-2u
	for Linux-fbdev-devel@lists.sourceforge.net; Fri, 16 Sep 2005 06:24:45 -0700
Received: from nproxy.gmail.com ([64.233.182.200])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EGGCp-0002Fw-PA
	for Linux-fbdev-devel@lists.sourceforge.net; Fri, 16 Sep 2005 06:24:45 -0700
Received: by nproxy.gmail.com with SMTP id a4so177981nfc
        for <Linux-fbdev-devel@lists.sourceforge.net>; Fri, 16 Sep 2005 06:24:36 -0700 (PDT)
Content-Disposition: inline
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
To: Linux-fbdev-devel@lists.sourceforge.net

hi list,

i got an STB with STB04xxx Digital Set-Top Box Integrated Controller
from IBM (it's a 250Mhz embedded powerpc CPU).

the machine runs a 2.6.9 kernel with a closed source framebuffer
kernel module "fb.ko".

I can perform lot of ioctls and mmap the framebuffer device, and
implement a putpixel() to draw something on TV-Output.

but when i compile framebuffer based console driver "fbcon.ko" and the
fonts "font.ko" and load those modules on the box, I DO NOT get a VT
or console login prompt on the TV-output.

what's wrong? or should i implement my own putc, scroll, etc... or
better a terminal for framebuffers like jfbterm, fbiterm???

thanks in advance for any suggestions!


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
