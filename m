From: James Simmons <jsimmons@infradead.org>
Subject: Re: backlight/frontlight
Date: Fri, 20 Dec 2002 18:13:34 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0212201811460.6471-100000@phoenix.infradead.org>
References: <20021219193645.B25149@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.infradead.org ([195.224.96.167])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18PRf5-0001at-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 20 Dec 2002 10:14:15 -0800
In-Reply-To: <20021219193645.B25149@flint.arm.linux.org.uk>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@cam.org>, Frank Becker <fbecker@intrinsyc.com>, Chris Larson <kergoth@handhelds.org>, linux-arm-kernel@lists.arm.linux.org.uk, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > What's required actually, is someone who's willing to pick that 
> > implementation (or another one, whatever is best) and lead maintainership 
> > for that code by gathering other's contribution.  Then, when the 
> > generic interface 
> > is suitable for most devices out there then it can be submited for 
> > inclusion with the -rmk patch, and/or James Simons' frame buffer rework in 
> > 2.5.
> 
> It'd definitely be best to involve James Simmons in this - he's the
> maintainer for fbcon, and, since the drivers are in framebuffer display
> land, it seems only sensible.

Hi!

     I would like to see this as well. At present the core api is 
finished. Of course it is possible to add other stuff as long as it 
doesn't require us changing a bunch of drivers that wouldn't support it.




-------------------------------------------------------
This SF.NET email is sponsored by:  The Best Geek Holiday Gifts!
Time is running out!  Thinkgeek.com has the coolest gifts for
your favorite geek.   Let your fingers do the typing.   Visit Now.
T H I N K G E E K . C O M        http://www.thinkgeek.com/sf/
