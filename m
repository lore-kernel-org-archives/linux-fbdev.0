From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Patch to add mode setting to sysfs
Date: Fri, 18 Feb 2005 10:42:12 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0502181041180.721@numbat.sonytel.be>
References: <9e4733910502161430ff1dad1@mail.gmail.com> <200502180804.46005.adaplas@hotpop.com>
 <9e473391050217185912a7d3d7@mail.gmail.com> <200502181531.05517.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D24ei-0005pu-DZ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Feb 2005 01:42:36 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D24ef-0000hb-Ow
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Feb 2005 01:42:36 -0800
In-Reply-To: <200502181531.05517.adaplas@hotpop.com>
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
Cc: Jon Smirl <jonsmirl@gmail.com>, adaplas@pol.net, James Simmons <jsimmons@pentafluge.infradead.org>

On Fri, 18 Feb 2005, Antonino A. Daplas wrote:
> On Friday 18 February 2005 10:59, Jon Smirl wrote:
> > fbcon really need to know the entire mode structure or could it work
> > with just the resolution?
> 
> fbcon only needs xres, yres, vxres and vyres.  But in order to preserve
> the graphics state per console, everything in var is required.

And visual/color depth (for modes `less' than 16 colors).

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
