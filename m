From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: board with broken vga ...
Date: Thu, 18 Jul 2002 11:42:57 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <B3CC4836A3C@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from zikova.cvut.cz ([147.32.235.100])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17V7oa-0004ib-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 18 Jul 2002 02:43:16 -0700
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
To: Sven Luther <luther@lambda.u-strasbg.fr>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 18 Jul 02 at 9:51, Sven Luther wrote:
> 
> Ok, that said, i suppose ours are the only boards with such problems,
> but since there is so much taken out of the drivers in your new setup
> and put in a common place, would it not solve this problem if there were
> an additional function which driver could provide (or fill in NULL if
> there was no proble), for retrieving this data, which fbcon can write
> back later on ?

Unfortunately there is no such hook. Fortunately call sequence is:

your drivers's init
   --> look and init devices
       --> call register_framebuffer
           --> VGACON reads contents of VGA buffer
           --> call to fbdev setvar
           --> upper layer restores screen
...
With matroxfb I moved all initialization which changes framebuffer layout
to the setvar call, and so VGACON finds hardware in VGA, and not MMIO,
state.

You can look at drivers/char/console.c: take_over_console calls
save_screen, which in turn calls con_save_screen method of vgacon.
So you can try directly overwritting vgacon's savescreen procedure

extern struct consw vga_con;
vga_con.con_save_screen = myOwnSaveScreen;

if you find that your fbdev is primary VGA device. Of course it is
not tested, and I cannot recommend doing that...
                                                    Petr
                                                    


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
