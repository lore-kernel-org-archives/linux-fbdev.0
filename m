From: Sven <luther@dpt-info.u-strasbg.fr>
Subject: Re: Re: board with broken vga ...
Date: Mon, 22 Jul 2002 22:40:29 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200207222040.g6MKeTJc027655@dpt-info.u-strasbg.fr>
References: <BA75C96412A@vcnet.vc.cvut.cz>
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from dpt-info.u-strasbg.fr ([130.79.44.193])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17Wjyr-0007Af-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Jul 2002 13:40:34 -0700
In-Reply-To: <BA75C96412A@vcnet.vc.cvut.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: luther@dpt-info.u-strasbg.fr, VANDROVE@vc.cvut.cz
Cc: linux-fbdev-devel@lists.sourceforge.net

Hello, ...

Sorry, i cannot do propper cut&paste here, as i am mailing over a console with lot of debug message showing :(((

Anyway, ...

Yes, vc_resize get calledafter we call register_framebuffer, and before the first set_origin, and i guess this
is the reason for our problems.

What would be a solution, would be not to override the vga save_screen as i do, 
but copy the data (which i now hold in a private structure of pm3fb) after vc_resize was done.

I did a bit of looking, but couldn't find a proper place to do this.

And yes, i am working on linus 2.5.25, without further patches (well pm3fb does need 
to get adapted to the new way, but idon't feel that i undertsood 
sufficiently what is going on to do the adapation (in the little time i have for this).


As for the screenbuf, i don't think there is any strange set_origin going on, but
then it was not me who wrote pm3fb, and i couldn't say for sure.


The first screenbuf, and the one i am copying to, is the one from vgacon, 
since i did override the vgacon save_screen, i guess this is notsomething that should be happening.

Mmm, how does the standard way handle things ? vgacon save_screen fills the screenbuf, and
vc_resize does copy the stuff over to the new screenbuf ?

Yes, i think that it happens in vc_resize, i will look more to see if i can spot the  
part that moves data around and check if it does it right or not.



Yes, the framebuffer format is <> frome what svgacon save_screen expect.

(i get the console chars every other 8 bytes, with probably the attributes at an 4 byte offset or something such.)

Mmm, is the fact that vc_resize uses the origin directlt not a buggy behavior ?

What do we have vgacon_save_screen for then, if it never gets used ?

Mmm, maybe vgacon_save_screen is just for saving stuff when we switch vga console, and has nothing
should not be used as we use it, but togeher with vgacon_switch.



What would solve my problem in the easiest way would be to have some 
framebuffer restore hook or something in the fbdev driver, which would get called
in take_over_screen or something such, after the screen has been resized ?

Or Maybe simply tell vc_resize that we use a special way of reading the framebuffer.

Or i should implement the trick you use for setting the card in 
graphic mode later on in the setvar stuff ?

Friendly,

Sven Luther


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
