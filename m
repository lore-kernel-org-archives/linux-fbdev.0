From: Sven Luther <luther@lambda.u-strasbg.fr>
Subject: Re: board with broken vga ...
Date: Thu, 18 Jul 2002 13:36:42 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020718113642.GA6719@lambda.u-strasbg.fr>
References: <B3CC4836A3C@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from dpt-info.u-strasbg.fr ([130.79.44.193])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17V9QY-0007Dp-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 18 Jul 2002 04:26:35 -0700
Content-Disposition: inline
In-Reply-To: <B3CC4836A3C@vcnet.vc.cvut.cz>
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
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Thu, Jul 18, 2002 at 11:42:57AM +0200, Petr Vandrovec wrote:
> On 18 Jul 02 at 9:51, Sven Luther wrote:
> > 
> > Ok, that said, i suppose ours are the only boards with such problems,
> > but since there is so much taken out of the drivers in your new setup
> > and put in a common place, would it not solve this problem if there were
> > an additional function which driver could provide (or fill in NULL if
> > there was no proble), for retrieving this data, which fbcon can write
> > back later on ?
> 
> Unfortunately there is no such hook. Fortunately call sequence is:

Yes, i know, but would such a hook be a good addition for the new API or
something ? 

Altough, it is true that maybe only pm2fb and pm3fb will make use of it,
it would be cleaner than patching vgacon code for it.

> your drivers's init
>    --> look and init devices
>        --> call register_framebuffer
>            --> VGACON reads contents of VGA buffer

So vgacon is responsible for (wrongly) reading the text data from the
board.

>            --> call to fbdev setvar
>            --> upper layer restores screen
> ...
> With matroxfb I moved all initialization which changes framebuffer layout
> to the setvar call, and so VGACON finds hardware in VGA, and not MMIO,
> state.

Mmm, that may be an idea, provided the normal VGA stuff is not broken.

> You can look at drivers/char/console.c: take_over_console calls
> save_screen, which in turn calls con_save_screen method of vgacon.
> So you can try directly overwritting vgacon's savescreen procedure
> 
> extern struct consw vga_con;
> vga_con.con_save_screen = myOwnSaveScreen;
> 
> if you find that your fbdev is primary VGA device. Of course it is
> not tested, and I cannot recommend doing that...

Ok, i will look at it, thanks.

Friendly,

Sven Luther
>                                                     Petr
>                                                     


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
