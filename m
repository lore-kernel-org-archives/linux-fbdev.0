From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: Re: [PATCH] fbdev updates.
Date: Fri, 5 Jul 2002 10:16:28 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0207051014250.25589-100000@www.transvirtual.com>
References: <20020705100937.C23355@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17QWhA-0006Ow-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 05 Jul 2002 10:16:36 -0700
In-Reply-To: <20020705100937.C23355@flint.arm.linux.org.uk>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> On Fri, Jul 05, 2002 at 10:53:35AM +0200, Geert Uytterhoeven wrote:
> > If you have an `asymmetric' dual-head chipset (both heads are not independent,
> > and/or have different capabilities), you'll have 2 info structures, with one
> > shared par. So info and par cannot be combined.
>
> That may be true for such systems.  I don't believe in imposing such
> restrictions on drivers that can _never ever_ fall into that category.

Imposing a standard set of rules to a subsystem. What insane person would
ever do that?



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
