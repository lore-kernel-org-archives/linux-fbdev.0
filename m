From: Sven <luther@dpt-info.u-strasbg.fr>
Subject: Re: Re: board with broken vga ...
Date: Mon, 22 Jul 2002 19:46:17 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200207221746.g6MHkHkl026650@dpt-info.u-strasbg.fr>
References: <BA4A3C769DD@vcnet.vc.cvut.cz>
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from dpt-info.u-strasbg.fr ([130.79.44.193])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17WhGI-0007CS-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Jul 2002 10:46:23 -0700
In-Reply-To: <BA4A3C769DD@vcnet.vc.cvut.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
To: luther@lambda.u-strasbg.fr, VANDROVE@vc.cvut.cz
Cc: linux-fbdev-devel@lists.sourceforge.net

PEtr wrote : 
> thought that:
>   take_over_console -> update_screen(x) -> redraw_screen(x,0) ->
> (1) set vc_origin to vc_screenbuf in set_origin()
> (2) paint picture through do_update_region() -> con_getxy, con_putcs
> vc_screenbuf is accessed through screenbuf macro from console_macros.h.
> It is very hard to find anything in console.c. I use simple rule:
> all X variables you see in function are vc_X members of vt struct unless
> you see definition of X on your screen.

Well, i did search for screenbuf and not vc_screenbuf, and i did find the macros.

I did not find any reference in anything excepth vgacon_switch and vgacon_save_screen.

Also :

is vc_screenbuf still part of the framebuffer memory, i thought it was some other main memory, a ...

Mmm, i will have to look more at it, thanks for the info thpugh.

BAsically, i am now sure that i copy the right data to the screenbuf (well for the character data, i just use empty attributes, is that ok for now ?, where can i find the attribute format ?).

But it seems the problem is when copying the stuff back to the screen that something goes wrong.

I suspect that it is not the correct data (the one in screenbuf) that is taken or something like that.

But then, maybe i am worng (well most probably i am wrong).

Friendly,

Sven Luther:wq


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
