From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: [BK PATCHS] fbdev updates.
Date: Fri, 18 Oct 2002 14:24:48 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210181421110.3591-100000@maxwell.earthlink.net>
References: <20021018193245.A15827@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120] helo=albatross.prod.itd.earthlink.net)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 182eiU-0006Ws-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Oct 2002 14:31:34 -0700
In-Reply-To: <20021018193245.A15827@flint.arm.linux.org.uk>
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
To: Russell King <rmk@arm.linux.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> > Yes the drivers should always have priority. The other stuff is there
> > only if the drivers have no power management of any kind. I leave it up to
> > the driver write to implement a fb_blank function that handles different
> > cases.
>
> The drivers don't have priority though.  You call set_par, and then
> wander off into the internals of fbgen.c to set can_soft_blank youself,
> without giving the drivers any look-in to set that correctly.

Your right. That is a bug from the old fbgen code. Since few driver used
the old fbgen code it never appeared. I suggest we remove can_soft_blank
and just test to see if the function pointer exist for fb_blank. If it
doesn't then we can resort to other tricks in suggested in the ther email.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
