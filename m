From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] fbdev updates.
Date: Fri, 5 Jul 2002 18:57:54 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020705185754.C27920@flint.arm.linux.org.uk>
References: <20020705094435.A23355@flint.arm.linux.org.uk> <Pine.LNX.4.44.0207050948200.25589-100000@www.transvirtual.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17QXLH-00049p-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 05 Jul 2002 10:58:03 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207050948200.25589-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Fri, Jul 05, 2002 at 10:14:12AM -0700
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
To: James Simmons <jsimmons@transvirtual.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, Jul 05, 2002 at 10:14:12AM -0700, James Simmons wrote:
> > First, I detest the idea of "fix", "var", "par" and "info".  Specifically
> > the "par" crap. Intensely.
> 
>    Why? Should each driver have their own structs that are completely
> different then? In this case you would be better off doing something like
> newport_con.c.
> 
>     We pretty much have this today. Each driver has so much excess code
> because they want to create their own special structs. Lost of bloat for
> no reason! I will NOT put up with that anymore!!!! Sorry!

James, you're OTT here.  Look at what the structure contains.  You will
notice that it's very specific to the driver.  Drivers have the implicit
right to define what data they need to maintain their internal state;
the core has no right to define that.

If you're going to be this hard headed about this, YOU can take over
complete maintainence of ALL framebuffer drivers.  I'll direct ALL
problems to you to solve.

It's part of the deal.  Either you allow driver writers to cleanly code
the way they see fit, or you take over maintainence of those drivers.
You break it, you fix it.  What's it to be?

> > "par" and "info" should be combined IMO,
> > which my framebuffer drivers do.
> 
> No!!!! This is one of the reasons we have the mess we have!! Look at how
> much code that could be removed from the standard drivers into fbmem.c and
> fbcon.c.

sa1100fb was already cleaned up in the way YOU wanted to remove most of
the junk back in the 2.4 days.  I consider it to be extremely clean.  Or
used to be.  All that now remains in there has very little commonality
between the drivers.

When there is ONE and only ONE framebuffer device possible, it makes
sense to try to combine structures as much as possible, especially
when:

1. allocation of structures has overhead.
2. you can get some performance advantage from combining such structures.
3. you're running on an embedded platform and are trying not to waste
   ANY resources.

> > Secondly, I think you're completely confused above.  lccr0 and lccr3 have
> > nothing to do with some "generic struct fb_info".  They hold the base
> > register values for two of the SA1100 control registers.
> >
> > Thirdly, you didn't delete them.  You _moved_ them within the structure.
> > They therefore served zero functional purpose.
> 
> If you could send me a patch I would be happy.

Patch for what?  I _really_ don't understand your request here.

> > Fourthly, nothing but the sa1100fb driver has any business accessing the
> > elements around these two both before and after the move.
> 
> True which is why things like that go into par.

Then why are you trying to share the par between others (as you said in
a previous message)?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
