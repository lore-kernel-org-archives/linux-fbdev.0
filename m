From: Sven <luther@dpt-info.u-strasbg.fr>
Subject: Re: Re: board with broken vga ...
Date: Mon, 22 Jul 2002 23:00:31 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200207222100.g6ML0VPI027766@dpt-info.u-strasbg.fr>
References: <BA7D2B624A5@vcnet.vc.cvut.cz>
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from dpt-info.u-strasbg.fr ([130.79.44.193])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17WkIG-0002HO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Jul 2002 14:00:37 -0700
In-Reply-To: <BA7D2B624A5@vcnet.vc.cvut.cz>
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

> Just put it into vc_screenbuf after register_framebuffer() returns, and
> force redraw...

mmm, will try.

BTW, how can i force a redraw from pm3fb ?

> If you'll override save_screen, and you'll put set_origin() into visual_init,

NO, just tried, i got no more display, and the box hanged ...

How i do it :

i copy the data in pm3fb just after i first map the framebuffer. i hold it in a special
array in pm3fb (for now).

But then, maybe i should see if the location of the set_origin should be changed, maybe i could do it in vc_resize for now.

BTW, in the first case, i will see the screen flashing shortly with the garbage i see now, and then work ok, isn't it ? And i would need to handle resolution changes myself ?

Friendly,

Sven Luther:q


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
