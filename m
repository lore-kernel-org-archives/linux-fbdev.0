From: Sven Luther <luther@lambda.u-strasbg.fr>
Subject: board with broken vga ...
Date: Thu, 18 Jul 2002 09:51:46 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020718075146.GA6020@lambda.u-strasbg.fr>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from dpt-info.u-strasbg.fr ([130.79.44.193])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17V5un-0000KP-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 18 Jul 2002 00:41:33 -0700
Received: from lambda.u-strasbg.fr (lambda.u-strasbg.fr [130.79.90.63])
	by dpt-info.u-strasbg.fr (8.12.3/8.12.3/Debian -4) with ESMTP id g6I7fTmR017212
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 18 Jul 2002 09:41:29 +0200
Received: from luther by lambda.u-strasbg.fr with local (Exim 3.35 #1 (Debian))
	id 17V64g-0001ZP-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 18 Jul 2002 09:51:46 +0200
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Hello, ...

i am looking again at pm3fb (still old style one though).

Permedia3 (and probably permedia2 also) has a problem with accessing vga
stuff in mmio mode, which makes it not work correctly when the text from
the vga console mode is copied over to the fbcon at the switch.

I have the understanding that you moved this stuff over to some other
place and not the pm3fb driver itself (but where ?)

I now know how to get this data by looking at the framebuffer directly
(it is found starting at framebuffer addr + 0 in 8 byte steps.), but
need to know how i can hook it in, to write it back.

Also, the size of this text is somewhat of a mistery for me still.

Ok, that said, i suppose ours are the only boards with such problems,
but since there is so much taken out of the drivers in your new setup
and put in a common place, would it not solve this problem if there were
an additional function which driver could provide (or fill in NULL if
there was no proble), for retrieving this data, which fbcon can write
back later on ?

Friendly,

Sven Luther


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
