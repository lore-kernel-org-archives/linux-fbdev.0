From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: Re: board with broken vga ...
Date: Mon, 22 Jul 2002 23:07:28 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <BA82E1E583C@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from zikova.cvut.cz ([147.32.235.100])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17WkPK-0004ay-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Jul 2002 14:07:54 -0700
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

On 22 Jul 02 at 23:00, Sven wrote:

> > Just put it into vc_screenbuf after register_framebuffer() returns, and
> > force redraw...
> 
> mmm, will try.
> 
> BTW, how can i force a redraw from pm3fb ?
> 
> > If you'll override save_screen, and you'll put set_origin() into visual_init,
> 
> NO, just tried, i got no more display, and the box hanged ...

Oops. fbcon_set_origin will call scrolldelta which ... So what about simple
origin = screenbuf in visual_init ? It should have no side effects.

> How i do it :
> 
> i copy the data in pm3fb just after i first map the framebuffer. i hold it in a special
> array in pm3fb (for now).
> 
> But then, maybe i should see if the location of the set_origin should be changed, maybe i could do it in vc_resize for now.
> 
> BTW, in the first case, i will see the screen flashing shortly with the garbage i see now, and then work ok, isn't it ? 

Yes.

> And i would need to handle resolution changes myself ?

Yes. Or you can copy data just line by line, instead of like one big chunk.
Yes, it is duplicating of vc_resize code.
                                                Petr Vandrovec
                                                


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
