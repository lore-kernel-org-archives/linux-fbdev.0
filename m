From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: [PATCH] fbdev updates.
Date: Fri, 5 Jul 2002 10:14:12 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0207050948200.25589-100000@www.transvirtual.com>
References: <20020705094435.A23355@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17QWf1-0006Df-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 05 Jul 2002 10:14:23 -0700
In-Reply-To: <20020705094435.A23355@flint.arm.linux.org.uk>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> First, I detest the idea of "fix", "var", "par" and "info".  Specifically
> the "par" crap. Intensely.

   Why? Should each driver have their own structs that are completely
different then? In this case you would be better off doing something like
newport_con.c.

    We pretty much have this today. Each driver has so much excess code
because they want to create their own special structs. Lost of bloat for
no reason! I will NOT put up with that anymore!!!! Sorry!

> "par" and "info" should be combined IMO,
> which my framebuffer drivers do.

No!!!! This is one of the reasons we have the mess we have!! Look at how
much code that could be removed from the standard drivers into fbmem.c and
fbcon.c.

We should have
					 focus on
struct vc_data    struct fb_info         struct xxx_par

[ fbcon.c]        [ fbmem.c]             [ fbdev driver ]

This makes for a nice modular system. It allows for fbdev to exist without
fbcon. Ideally fbmem could even be modular. Insmod the core driver.
Insmod fbmem.o and you have the fbdev interface. You could then rmmod
fbmem.o and do dri.o. Now with the same core driver you have the DRI
interface. Or you could do both drivers at the same time. Eventually I
will combine both interfaces but that will take some time.

> Secondly, I think you're completely confused above.  lccr0 and lccr3 have
> nothing to do with some "generic struct fb_info".  They hold the base
> register values for two of the SA1100 control registers.
>
> Thirdly, you didn't delete them.  You _moved_ them within the structure.
> They therefore served zero functional purpose.

If you could send me a patch I would be happy.

> Fourthly, nothing but the sa1100fb driver has any business accessing the
> elements around these two both before and after the move.

True which is why things like that go into par.

> Ehh?  That's got nothing to do with cpufreq.  The reason we have the
> cpufreq interface in sa1100fb is that the base clock rate for the LCD
> controller on this chip is derived from the CPU core clock.  You change
> the core clock, you have to reprogram the pixel clock divisor.

Other devices besides the SA1100 does this as well. I knew this and this
reason lead me to originally place it into struct fb_info. Later I
realized it was a bad idea.





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
