From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: waitforVBlank, how does this even work?
Date: Thu, 03 Mar 2005 10:42:34 +1100
Message-ID: <1109806955.5610.129.camel@gaston>
References: <9e473391050301215019081bce@mail.gmail.com>
	 <Pine.LNX.4.62.0503021128001.14333@node2.an-vo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.62.0503021128001.14333@node2.an-vo.com>
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
To: Vladimir Dergachev <volodya@mindspring.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, fbdev <linux-fbdev-devel@lists.sourceforge.net>, DRI developer's list <dri-devel@lists.sourceforge.net>


> 
>     What about isolating interrupt-handling code into a small driver ?
> Something simple to respond to interrupts and call all handlers with a 
> certain mask.
> 
>     This would be useful not only for drm and fbdev but also for km 
> (v4l capture module) and stereo-glasses code.
> 

Nope, I don't agree.

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
