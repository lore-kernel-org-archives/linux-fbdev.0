From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [BK PATCHS] fbdev updates.
Date: Fri, 18 Oct 2002 19:32:46 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021018193245.A15827@flint.arm.linux.org.uk>
References: <20021015103833.C9771@flint.arm.linux.org.uk> <Pine.LNX.4.33.0210181018470.10832-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 182bvg-0005Wo-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Oct 2002 11:33:01 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0210181018470.10832-100000@maxwell.earthlink.net>; from jsimmons@infradead.org on Fri, Oct 18, 2002 at 10:27:59AM -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Oct 18, 2002 at 10:27:59AM -0700, James Simmons wrote:
> Yes the drivers should always have priority. The other stuff is there
> only if the drivers have no power management of any kind. I leave it up to
> the driver write to implement a fb_blank function that handles different
> cases.

The drivers don't have priority though.  You call set_par, and then
wander off into the internals of fbgen.c to set can_soft_blank youself,
without giving the drivers any look-in to set that correctly.

> > There is also the argument about wanting soft blanking, but hardware power
> > saving.
> 
> Hm. True unfortunely the fbdev layer lacks handling details like that. The
> console system is even worse. This is why a single flag like
> can_soft_blank can actually be a limitation.

Well, it needs to be fixed.  We've lost functionality that was present in
2.4, and therefore I call it a bug.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
