From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: [PATCH][RFC] Add support for Epson
 S1D13806 FB
Date: Mon, 14 Mar 2005 14:25:48 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0503141425000.4784@numbat.sonytel.be>
References: <qkX0zxQn.1110795218.6236360.varenet@localhost>
 <200503142015.14749.adaplas@hotpop.com> <20050314131839.GB2695@linux-sh.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DApaA-0000VQ-1C
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 05:26:06 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DApa8-0005MC-CC
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 05:26:05 -0800
In-Reply-To: <20050314131839.GB2695@linux-sh.org>
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
Cc: Thibaut VARENE <T-Bone@parisc-linux.org>, Antonino Daplas <adaplas@pol.net>, Ben Dooks <ben-linux-arm@fluff.org>

On Mon, 14 Mar 2005, Paul Mundt wrote:
> On Mon, Mar 14, 2005 at 08:15:13PM +0800, Antonino A. Daplas wrote:
> > 3. You can use pci_resource_len()/pci_resource_start() instead of
> > 
> > +	info->fix.mmio_start = pdev->resource[1].start;
> > +	info->fix.mmio_len = pdev->resource[1].end - pdev->resource[1].start;

+1?

> > +	info->fix.smem_start = pdev->resource[0].start;
> > +	info->fix.smem_len = pdev->resource[0].end - pdev->resource[0].start;

+1?

> > +
> > 
> No, the pdev here refers to a platform device, not a pci device.
> 
> While the pci_resource_xxx() routines would still technically do the
> right thing, this is purely coincidental.

Nah, they would work better here, since they do include the +1 ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
