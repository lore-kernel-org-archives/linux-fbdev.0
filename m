From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: waitforVBlank, how does this even work?
Date: Wed, 02 Mar 2005 18:10:14 +1100
Message-ID: <1109747415.5611.92.camel@gaston>
References: <9e473391050301215019081bce@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e473391050301215019081bce@mail.gmail.com>
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
Cc: DRI developer's list <dri-devel@lists.sourceforge.net>

On Wed, 2005-03-02 at 00:50 -0500, Jon Smirl wrote:
> For the r128 driver both the fbdev and drm drivers have implemented
> waitforVBlank and they both play with the interrupt registers. I can
> only assume that no one has ever tried to use them at the same time.
> In the radeon case the DRM driver has implemented waitforVBlank and
> the fbdev driver has not.
> 
> This is a mess and it is yet another reason for merging DRM and fbdev
> into a sane, combined driver.

I'd say nobody ever used both :)

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
