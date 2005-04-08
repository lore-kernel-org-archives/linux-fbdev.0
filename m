From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Resource management for fbdev.
Date: Fri, 08 Apr 2005 11:52:51 +1000
Message-ID: <1112925171.9517.358.camel@gaston>
References: <Pine.LNX.4.56.0503260019020.20306@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJihN-0004Su-Vg
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 07 Apr 2005 18:54:17 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DJihM-0000e4-Dc
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 07 Apr 2005 18:54:17 -0700
In-Reply-To: <Pine.LNX.4.56.0503260019020.20306@pentafluge.infradead.org>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, Andrew Morton <akpm@osdl.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On Sat, 2005-03-26 at 00:34 +0000, James Simmons wrote:
> I have a new resource management for testing. Its is a clenaup of the 
> handling the drawing plane and the cursor. I have tested it on 
> 
> New NVIDIA fbdev driver.
> NeoMagic
> ATY Mach64
> Radeon
> Vesa
> 
> Please try it out. The patch is over 40K so grab it from the below link
> 
> http://www.infradead.org/~jsimmons/resource.diff

I had a quick look, and I'm fairly confused. That patch introduces a lot
of changes all over the place without any comment or explanation, in
code that has proven in the past to be fragile and prone to side
effects. Also, I see no explanation of the rationale for the resource
manager and it's API. At a minimum, the patch should be split into

 - implementation of the resource manager with appropriate explanations
and documentation
 - driver updates

Have you worked at all with the DRM folks ? We have a bad need to merge
DRM and fbdev as soon as possible and we need while doing so to impement
some kind of efficient memory manager for the card video RAM. I'm not
sure your proposal fits into this picture.

Also, we need to properly deal with the fact that real soon now, not all
of the video memory will be accessible from the CPU (not only from the
kernel, but from the CPU in general). There are already cards whose PCI
aperture is too small to enclose the entire video memory, and some funky
issues with aperture control on radeons might make me also limit the
amount of video memory accessible.

Ben.
 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
