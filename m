From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: Re: board with broken vga ...
Date: Mon, 22 Jul 2002 19:35:00 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <BA4A3C769DD@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from zikova.cvut.cz ([147.32.235.100])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17Wh5b-0005w9-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Jul 2002 10:35:19 -0700
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
To: Sven LUTHER <luther@lambda.u-strasbg.fr>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 22 Jul 02 at 19:23, Sven LUTHER wrote:

> Petr wrote :
> > your drivers's init
> >    --> look and init devices
> >        --> call register_framebuffer
> >            --> VGACON reads contents of VGA buffer
> >            --> call to fbdev setvar
> >            --> upper layer restores screen
> > ...
> 
> Mmm, i did manage to override the vga save_screen function, and copy the
> good values into vc_sceenbuf, but to no avail.
> 
> What frustrates me is that i cannot find any reference to some piece of
> code using the data in vc_sceenbuf to write to the screen again.
> 
> How exactly does the upper layer restore the screen ?

I thought that:
  take_over_console -> update_screen(x) -> redraw_screen(x,0) ->
(1) set vc_origin to vc_screenbuf in set_origin()
(2) paint picture through do_update_region() -> con_getxy, con_putcs

vc_screenbuf is accessed through screenbuf macro from console_macros.h.
It is very hard to find anything in console.c. I use simple rule:
all X variables you see in function are vc_X members of vt struct unless
you see definition of X on your screen.
                                                    Petr Vandrovec
                                                    


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
