From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: Linux 2.6.10-rc2
Date: Thu, 18 Nov 2004 11:19:41 +0100 (MET)
Message-ID: <Pine.GSO.4.61.0411181118190.11590@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
 <200411172233.28606.andrew@walrond.org> <Pine.LNX.4.58.0411171504220.2222@ppc970.osdl.org>
 <200411180802.01209.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUjOG-0006wR-Iu
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 18 Nov 2004 02:19:48 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CUjOF-0006le-BO
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 18 Nov 2004 02:19:48 -0800
In-Reply-To: <200411180802.01209.adaplas@hotpop.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Antonino Daplas <adaplas@hotpop.com>, Andrew Walrond <andrew@walrond.org>

On Thu, 18 Nov 2004, Antonino A. Daplas wrote:
> On Thursday 18 November 2004 07:12, Linus Torvalds wrote:
> > On Wed, 17 Nov 2004, Andrew Walrond wrote:
> > > And I can confirm that the problem exists in both 32bit and 64bit
> > > kernels.
> >
> > Ok. None of the code should actually have changed at all, but I notice one
> > bug:
> 
> > please undo those parts (by hand, I've messed up white-space), since they
> > make "burst" be one too big. Looks like the reason for doing that in the
> > first place was an old sparse warning that no longer exists.
> >
> > Antonino? Any I missed?
> 
> Except for the above, I don't think so. The problem seems to be restricted
> to the monochrome expansion and rectangle fill functions.  The only changes
> in those functions are the use of the NV_{WR|RD} instead of direct loads.
> 
> Andrew's problem looks like that it might be related to the "burst" bug, 
> although I'm surprised it did not show up in my hardware (tried on 3
> different nvidia cards, NV3, NV11, NV32).
> 
> Here's a patch that reverts to old code.
> 
> Tony
> 
> diff -Nru a/drivers/video/riva/riva_hw.c b/drivers/video/riva/riva_hw.c
> --- a/drivers/video/riva/riva_hw.c	2004-11-10 07:14:37 +08:00
> +++ b/drivers/video/riva/riva_hw.c	2004-11-18 07:45:23 +08:00
> @@ -641,10 +641,8 @@
>      {
>          int  b = fifo_data.graphics_burst_size >> 4;
>          *burst = 0;
> -        while (b) {
> +        while (b >>= 1)
>  	    (*burst)++;
> -	    b >>= 1;
> -	}

Wouldn't it be safer to use one of the ops in bitops.h? Or is there a special
reason (e.g. very limited number of possible values) you don't use those?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
