From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] fbdev: workaround for broken X
 servers
Date: Fri, 5 Nov 2004 15:00:01 +0000 (GMT)
Message-ID: <Pine.LNX.4.58L.0411051453110.25345@blysk.ds.pg.gda.pl>
References: <1099448020.900.25.camel@gaston> <200411052055.17316.adaplas@hotpop.com>
 <Pine.GSO.4.61.0411051357050.15464@waterleaf.sonytel.be>
 <200411052115.07646.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQ5ZX-0008Qf-E3
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 07:00:15 -0800
Received: from pollux.ds.pg.gda.pl ([153.19.208.7] ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CQ5ZS-0005xo-4c
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 07:00:15 -0800
In-Reply-To: <200411052115.07646.adaplas@hotpop.com>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Fri, 5 Nov 2004, Antonino A. Daplas wrote:

> > > And make it black is usually done in software (by memsetting the screen
> > > with the black color).
> >
> > Or by setting all color palette registers to black, if available, since
> > it's cheaper...
> >
> 
> Ok. So, if pseudocolor/directcolor, set palette to all black, otherwise memset
> the screen.

 Still not there -- some RAMDACs can be asked to do blanking themselves.  
And there are these interesting implementations like the Bt463 that have a
palette even though using the truecolor mode.

  Maciej


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
