From: Sven Luther <luther@lambda.u-strasbg.fr>
Subject: Re: board with broken vga ...
Date: Thu, 18 Jul 2002 18:16:15 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020718161615.GA7706@lambda.u-strasbg.fr>
References: <B3CC4836A3C@vcnet.vc.cvut.cz> <20020718113642.GA6719@lambda.u-strasbg.fr>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from dpt-info.u-strasbg.fr ([130.79.44.193])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17VDn6-0007Wp-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 18 Jul 2002 09:06:08 -0700
Content-Disposition: inline
In-Reply-To: <20020718113642.GA6719@lambda.u-strasbg.fr>
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

On Thu, Jul 18, 2002 at 01:36:42PM +0200, Sven Luther wrote:
> On Thu, Jul 18, 2002 at 11:42:57AM +0200, Petr Vandrovec wrote:
> > On 18 Jul 02 at 9:51, Sven Luther wrote:
> > > 
> > > Ok, that said, i suppose ours are the only boards with such problems,
> > > but since there is so much taken out of the drivers in your new setup
> > > and put in a common place, would it not solve this problem if there were
> > > an additional function which driver could provide (or fill in NULL if
> > > there was no proble), for retrieving this data, which fbcon can write
> > > back later on ?
> > 
> > Unfortunately there is no such hook. Fortunately call sequence is:
> 
> Yes, i know, but would such a hook be a good addition for the new API or
> something ? 
> 
> Altough, it is true that maybe only pm2fb and pm3fb will make use of it,
> it would be cleaner than patching vgacon code for it.
> 
> > your drivers's init
> >    --> look and init devices
> >        --> call register_framebuffer
> >            --> VGACON reads contents of VGA buffer
> 
> So vgacon is responsible for (wrongly) reading the text data from the
> board.
> 
> >            --> call to fbdev setvar
> >            --> upper layer restores screen
> > ...
> > With matroxfb I moved all initialization which changes framebuffer layout
> > to the setvar call, and so VGACON finds hardware in VGA, and not MMIO,
> > state.
> 
> Mmm, that may be an idea, provided the normal VGA stuff is not broken.
> 
> > You can look at drivers/char/console.c: take_over_console calls
> > save_screen, which in turn calls con_save_screen method of vgacon.
> > So you can try directly overwritting vgacon's savescreen procedure
> > 
> > extern struct consw vga_con;
> > vga_con.con_save_screen = myOwnSaveScreen;

I tried this, but without success, well it worked, but the corruption is
still there.

when i read ->vc_origin, i can see somewhat of the stuff i have in my
scren after the switch.

when i read the framebuffer directly, i get the console as it should be
(at every 8 bytes, so i guess the attributes are in some of the other 7
bytes, either just behind or before it, or at an 4 bytes offset).

I tried writing plain 'X' chars to the ->vc_screenbuf, but nothing
happens (but the stuff i read directly has now 'X's in background as
below :

880Linux version 2.5.25 (luther@iliana) (gcc version 2.95.4 20011002
(Debian prerel
960ease)) #14 Thu Jul 18 17:37:48 CEST 2002XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
1040Video mode to be used for restore is f00XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
1120BIOS-provided physical RAM map:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
1200 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)XXXXXXXXXXXXXXXXXXXXXXXX
1280 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)XXXXXXXXXXXXXXXXXXXXXX
1360 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)XXXXXXXXXXXXXXXXXXXXXX

What seems strange is that i read these stuff before calling
register_framebuffer, so how can the 'X' i write there afterward appear
?

Clearly something strange is going on, i will investigate more.

Friendly,

Sven Luther


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
