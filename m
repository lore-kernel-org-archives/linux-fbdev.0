From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: Re: board with broken vga ...
Date: Mon, 22 Jul 2002 19:54:43 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <BA4F7734912@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from zikova.cvut.cz ([147.32.235.100])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17WhOi-0008Ox-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Jul 2002 10:55:04 -0700
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
To: Sven <luther@dpt-info.u-strasbg.fr>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 22 Jul 02 at 19:46, Sven wrote:
> PEtr wrote : 
> > thought that:
> >   take_over_console -> update_screen(x) -> redraw_screen(x,0) ->
> > (1) set vc_origin to vc_screenbuf in set_origin()
> > (2) paint picture through do_update_region() -> con_getxy, con_putcs
> > vc_screenbuf is accessed through screenbuf macro from console_macros.h.
> > It is very hard to find anything in console.c. I use simple rule:
> > all X variables you see in function are vc_X members of vt struct unless
> > you see definition of X on your screen.
> 
> Well, i did search for screenbuf and not vc_screenbuf, and i did find the macros.
> 
> I did not find any reference in anything excepth vgacon_switch and vgacon_save_screen.

drivers/char/console.c:set_origin(), vc_resize(), ...
 
> is vc_screenbuf still part of the framebuffer memory, i thought it was some other main memory, a ...

vc_screenbuf is alloc_bootmem() or kmalloc(if screen resize happens) memory.
vgacon uses its own vgacon_set_origin(), which sets vc_origin to
VGA framebuffer, while with fbcon it sets vc_origin to vc_screenbuf.

> BAsically, i am now sure that i copy the right data to the screenbuf (well for the character data, i just use empty attributes, is that ok for now ?, where can i find the attribute format ?).

scr_write() will take a care of byteswapping. If in 8bit characters,
upper 8 bits are attr, low 8 bits is character.

> But it seems the problem is when copying the stuff back to the screen that something goes wrong.
> 
> I suspect that it is not the correct data (the one in screenbuf) that is taken or something like that.

Just idea: force your fbdev to use same resolution as vgacon
(80x25, 640x400, or change vgacon resolution to 80x30 if your fbdev uses
640x480) so that vc_resize path is not triggered. It does some copying
too.
                                                            Petr
                                                            


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
