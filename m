From: Sven <luther@dpt-info.u-strasbg.fr>
Subject: Re: Re: board with broken vga ...
Date: Mon, 22 Jul 2002 21:58:49 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200207221958.g6MJwnqi027424@dpt-info.u-strasbg.fr>
References: <BA4F7734912@vcnet.vc.cvut.cz>
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from dpt-info.u-strasbg.fr ([130.79.44.193])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17WjKX-0006rS-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Jul 2002 12:58:54 -0700
In-Reply-To: <BA4F7734912@vcnet.vc.cvut.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
To: luther@dpt-info.u-strasbg.fr, VANDROVE@vc.cvut.cz
Cc: linux-fbdev-devel@lists.sourceforge.net

Hello, ...

I did a bit more looking, and found that :

Jul 22 21:49:32 iliana kernel: SVEN : c->vc_screenbuf is -1055775808

screen buffer is set to that when i overwrite the vgacon save_scree function, and here i save
it (printed with %ld).

Jul 22 21:49:32 iliana kernel: SVEN : set_origin : screenbuf is -941350912.
Jul 22 21:49:32 iliana kernel: SVEN : set_origin : origin is -1072968800.

when set_origin is first called (not from do_update_screen) after that, it held this values.

Clearly the screenbuf is not the same.

(and contains only garbage).

the nredraw_screen is called, which calls again set_origin, and then calls 
do_update_region as follows :

Jul 22 21:49:32 iliana kernel: SVEN : do_update_region : + start = -941350912, count = 3700

here we see that the screenbuf used is the wrongly set one, 
not the one i copied the stuff to.

Mmm, i suppose that what happens is that the screenbuf is different 
for fbcon and vgacon or something such, and this seems clearly the reason
for lot of garbage appearing on my screen, is it not ?

Friendly,

Sven Luther:wq


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
