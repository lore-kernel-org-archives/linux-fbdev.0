From: "D M" <michelidea@hotmail.com>
Subject: My own frame buffer:-)
Date: Thu, 27 Jun 2002 10:56:53 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <F39qZGUTwSIQK9VPRfL000010e5@hotmail.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from f39.law3.hotmail.com ([209.185.241.39] helo=hotmail.com)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17NWxV-0001rJ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Jun 2002 03:57:05 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; format=flowed; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev-devel@lists.sourceforge.net


Gr=FCezi!

Id like to build a small linux computer. I have a small industrial 486 boar=
d=20
with some I/O's. Id like to connect a graphic LCD (mabe 128x64 pixel,=20
monochrome) display to this IO port.

My question:
I would like to use a GUI (like picogui). Picogui is supporting the=20
framebuffer. Now i would like to writing a kernel module that i can insert =

in runtime. After i can start picogui on this framebuffer. I don't need to =

have all the kernel messages/console on the display, just that, what picogu=
i=20
is writing to the framebuffer.
The kernel module has to get the data from picogui, to prepare for LCD and =

send it over the I/O port.

What do you think, is it easy, or is it a lot of work? Is it possible? Do i=
=20
need to implement some ioctrl() routines? (Or better: Does a framebuffer=20
application use ioctrl() commands?)

Thank you

David

_________________________________________________________________
Join the world=92s largest e-mail service with MSN Hotmail.=20
http://www.hotmail.com



-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
