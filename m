From: Vladimir Dergachev <volodya@mindspring.com>
Subject: Re: waitforVBlank, how does this even work?
Date: Wed, 2 Mar 2005 11:32:44 -0500 (EST)
Message-ID: <Pine.LNX.4.62.0503021128001.14333@node2.an-vo.com>
References: <9e473391050301215019081bce@mail.gmail.com>
Reply-To: Vladimir Dergachev <volodya@mindspring.com>
Mime-Version: 1.0
In-Reply-To: <9e473391050301215019081bce@mail.gmail.com>
Sender: dri-devel-admin@lists.sourceforge.net
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@gmail.com>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>, DRI developer's list <dri-devel@lists.sourceforge.net>



On Wed, 2 Mar 2005, Jon Smirl wrote:

> For the r128 driver both the fbdev and drm drivers have implemented
> waitforVBlank and they both play with the interrupt registers. I can
> only assume that no one has ever tried to use them at the same time.
> In the radeon case the DRM driver has implemented waitforVBlank and
> the fbdev driver has not.
>
> This is a mess and it is yet another reason for merging DRM and fbdev
> into a sane, combined driver.

Hi Jon,

    What about isolating interrupt-handling code into a small driver ?
Something simple to respond to interrupts and call all handlers with a 
certain mask.

    This would be useful not only for drm and fbdev but also for km 
(v4l capture module) and stereo-glasses code.

                         best

                           Vladimir Dergachev

>
> -- 
> Jon Smirl
> jonsmirl@gmail.com
>
>
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> --
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/dri-devel
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
--
