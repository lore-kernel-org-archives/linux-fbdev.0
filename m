From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Re: waitforVBlank, how does this even work?
Date: Wed, 2 Mar 2005 17:29:50 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0503021727320.20488@pentafluge.infradead.org>
References: <9e473391050301215019081bce@mail.gmail.com>
 <Pine.LNX.4.62.0503021128001.14333@node2.an-vo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>
Cc: Jon Smirl <jonsmirl@gmail.com>, DRI developer's list <dri-devel@lists.sourceforge.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>


> Hi Jon,
> 
>     What about isolating interrupt-handling code into a small driver ?
> Something simple to respond to interrupts and call all handlers with a 
> certain mask.
> 
>     This would be useful not only for drm and fbdev but also for km 
> (v4l capture module) and stereo-glasses code.

Ultimatly this is the goal. That is what the struct xxx_par is for in 
struct fb_info. It is the core driver private data that can be shared by 
everyone. Ben would you mind if I reworked your code to have this "core".
It will take me some time but I can have it working. I need to do some 
fixes for multiple monitor handling anyways.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
