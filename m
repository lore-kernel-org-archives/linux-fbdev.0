From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [patch] framebuffer Kconfig -- add option
 for building cfb*.o (0/2)
Date: Mon, 14 Feb 2005 13:23:37 +0100 (MET)
Message-ID: <Pine.GSO.4.61.0502141322060.16209@waterleaf.sonytel.be>
References: <421096C6.3030105@arcom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D0fGV-0003ji-FD
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Feb 2005 04:23:47 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D0fGT-0003dC-Pl
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Feb 2005 04:23:47 -0800
In-Reply-To: <421096C6.3030105@arcom.com>
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
To: David Vrabel <dvrabel@arcom.com>, linux-fbdev-devel list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 14 Feb 2005, David Vrabel wrote:
> This set of two patches add a new option (FB_SOFTWARE_CFB_OPS) to the
> framebuffer Kconfig to enable building the generic software cfbfillrect,
> cfbcopyarea and cfbimageblt objects.  This cuts out a lot of stuff from
> the Makefile and allows drivers in their own directory to be more
> self-contained.
> 
> 1/2 -- add the FB_SOFTWARE_CFB_OPS option to Kconfig and Makefile
> 2/2 -- make all drivers (where appropriate) select FB_SOFTWARE_CFB_OPS
> 
> Please consider applying, thanks.

Thanks, good idea!

But I'd prefer to have 3 separate options, since some drivers don't need all 3
of them, e.g.:
  - CONFIG_CFB_FILLRECT
  - CONFIG_CFB_COPYAREA
  - CONFIG_CFB_IMAGEBLT

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
