From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: Re: board with broken vga ...
Date: Mon, 22 Jul 2002 22:18:22 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <BA75C96412A@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from zikova.cvut.cz ([147.32.235.100])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17Wjdz-0003hZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Jul 2002 13:18:59 -0700
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

On 22 Jul 02 at 21:58, Sven wrote:

> I did a bit more looking, and found that :
> 
> Jul 22 21:49:32 iliana kernel: SVEN : c->vc_screenbuf is -1055775808

Having them hexadecimal would be much better... c11223c0... bootmem.
 
> screen buffer is set to that when i overwrite the vgacon save_scree function, and here i save
> it (printed with %ld).
> 
> Jul 22 21:49:32 iliana kernel: SVEN : set_origin : screenbuf is -941350912.

c7e42000... kmalloc

> Jul 22 21:49:32 iliana kernel: SVEN : set_origin : origin is -1072968800.

c00bcba0... inside VGA framebuffer.

> when set_origin is first called (not from do_update_screen) after that, it held this values.
> 
> Clearly the screenbuf is not the same.

Probably resize triggers in. But you are doing something wrong - do
you work with Linus tree or on the top of James work? Inside (and after)
do_update_region you should not have origin pointing to the VGA
framebuffer anymore, it must point to screenbuf area! Or do you
implement some strange set_origin method?
 
> the nredraw_screen is called, which calls again set_origin, and then calls 
> do_update_region as follows :
> 
> Jul 22 21:49:32 iliana kernel: SVEN : do_update_region : + start = -941350912, count = 3700
> 
> here we see that the screenbuf used is the wrongly set one, 
> not the one i copied the stuff to.

Only place which does realloc is vc_resize, and code here should
properly move data. 
 
> Mmm, i suppose that what happens is that the screenbuf is different 
> for fbcon and vgacon or something such, and this seems clearly the reason
> for lot of garbage appearing on my screen, is it not ?

I've got an idea: vc_resize reads data from vc's origin, unconditionally,
without call to save_screen! So if your framebuffer layout is not
compatible with VGA, you are lost. 
fbcon_init -> fbcon_setup -> vc_resize_con -> origin leaved unset...
Adding call to set_origin(currcons) into visual_init, just before
call to sw->con_init() may fix problem. Or maybe it will just make problem
even worse? Who knows?
                                                        Petr
                                                        


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
