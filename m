From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Re: [PATCH] fbdev updates.
Date: Fri, 5 Jul 2002 18:58:43 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020705185843.D27920@flint.arm.linux.org.uk>
References: <20020705100937.C23355@flint.arm.linux.org.uk> <Pine.LNX.4.44.0207051014250.25589-100000@www.transvirtual.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17QXM1-0004Dn-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 05 Jul 2002 10:58:49 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207051014250.25589-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Fri, Jul 05, 2002 at 10:16:28AM -0700
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

On Fri, Jul 05, 2002 at 10:16:28AM -0700, James Simmons wrote:
> > On Fri, Jul 05, 2002 at 10:53:35AM +0200, Geert Uytterhoeven wrote:
> > > If you have an `asymmetric' dual-head chipset (both heads are not independent,
> > > and/or have different capabilities), you'll have 2 info structures, with one
> > > shared par. So info and par cannot be combined.
> >
> > That may be true for such systems.  I don't believe in imposing such
> > restrictions on drivers that can _never ever_ fall into that category.
> 
> Imposing a standard set of rules to a subsystem. What insane person would
> ever do that?

Imposing a set of useless features on hardware that can not support it
by design.  Yes, that's sensible, oh yes.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
