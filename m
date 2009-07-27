From: GnuCash Administrator <admin.gnucash@gmail.com>
Subject: fbcon rotation on keypad event
Date: Mon, 27 Jul 2009 14:19:23 +0100
Message-ID: <8e9a4c730907270619w18e7813fl3735ed31cf14d601@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <admin.gnucash@gmail.com>) id 1MVQ7A-0007It-Az
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Jul 2009 13:19:40 +0000
Received: from mail-bw0-f215.google.com ([209.85.218.215])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MVQ71-00087i-6k for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Jul 2009 13:19:40 +0000
Received: by bwz11 with SMTP id 11so2674085bwz.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 27 Jul 2009 06:19:24 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Hello to All.

I need to rotate the framebuffer console on a keyboard event inside
the keyboard driver itself.

What for functions and header files ared needed to be included and
started to get this to work in the driver.

In the file fbcon.c exist functions like "fbcon_rotate_all" but i dont
know if it is possible and how it is possible to call this function
from the keyboard driver.

Thanks in advance for the start help.
Greetings

------------------------------------------------------------------------------
