From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: 2.6.12-rc3 compile failure in tgafb.c, tgafb not working anymore
Date: Mon, 25 Apr 2005 11:21:14 +0800
Message-ID: <200504251121.16609.adaplas@hotpop.com>
References: <20050421185034.GS607@vega.lnet.lut.fi> <20050422112030.GW607@vega.lnet.lut.fi> <20050422144047.GY607@vega.lnet.lut.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DPuDn-0005Fb-J6
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 24 Apr 2005 20:25:19 -0700
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DPuDm-0004vC-43
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 24 Apr 2005 20:25:19 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id AB1E970C49
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 25 Apr 2005 03:24:08 +0000 (UTC)
In-Reply-To: <20050422144047.GY607@vega.lnet.lut.fi>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: Tomi Lapinlampi <lapinlam@vega.lnet.lut.fi>, Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, rth@twiddle.net, adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net

On Friday 22 April 2005 22:40, Tomi Lapinlampi wrote:
> On Fri, Apr 22, 2005 at 02:20:30PM +0300, Tomi Lapinlampi wrote:
> > Actually, I was able to get a clean compile with the patch from
> > http://marc.theaimsgroup.com/?l=linux-alpha&m=111392038121433&w=2
>
> Hi again,
>
> Although the tgafb driver compiles with the above patch, it shows
> similar behaviour as before: The kernel loads, the monitor comes alive
> but the screen stays completely blank.
> The last kernel that worked was 2.6.8.1. I've tested with 2.6.{9,10,11}

What does fbset show?  If the line rgba shows all zero, then you will get a
blank screen. The driver must properly set info->var.green|red|blue|transp,
which in turn depends on the hardware configuration.

You can try to insert these in tgafb_pci_register() after fb_find_mode().

If at 8bpp pseudocolor:

all->info.var.green.length = 8;
all->info.var.red.length = 8;
all->info.var.blue.length = 8;
all->info.var.green.offset = 0;
all->info.var.red.offset = 0;
all->info.var.blue.offset = 0;

If at 32-bit truecolor:

all->info.var.green.length = 8;
all->info.var.red.length = 8;
all->info.var.blue.length = 8;
all->info.var.green.offset = 8;
all->info.var.red.offset = 16;
all->info.var.blue.offset = 0;

If the above changes work, a definitive fix is still needed, one that will
also set the above for each visual the hardware supports on each
fb_check_var().

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
