From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Re: [PATCH] fbdev updates.
Date: Fri, 5 Jul 2002 19:27:34 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020705192734.F27920@flint.arm.linux.org.uk>
References: <20020705185843.D27920@flint.arm.linux.org.uk> <Pine.LNX.4.44.0207051120280.25589-100000@www.transvirtual.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17QXnx-0008RM-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 05 Jul 2002 11:27:42 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207051120280.25589-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Fri, Jul 05, 2002 at 11:21:16AM -0700
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, Jul 05, 2002 at 11:21:16AM -0700, James Simmons wrote:
> > > Imposing a standard set of rules to a subsystem. What insane person would
> > > ever do that?
> >
> > Imposing a set of useless features on hardware that can not support it
> > by design.  Yes, that's sensible, oh yes.
> 
> All I'm trying to do is seperate hardware independent data from hardware
> dependent data.

Shrug.  I've decided I no longer care.  There is very little common data
in sa1100fb_info.  In fact, from my point of view as the previous driver
maintainer, I'd say that all the data within sa1100fb_info is hardware
dependent, with the exception of the fb_info at the start, which is
placed there to provide a convienent and FAST way to get at the data.

However, since you've decided you know better, I leave this driver
completely in your hands to fuck up.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
