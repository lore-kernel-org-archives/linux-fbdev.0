From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: waitforVBlank, how does this even work?
Date: Thu, 03 Mar 2005 09:38:56 +1100
Message-ID: <1109803136.5680.104.camel@gaston>
References: <9e473391050301215019081bce@mail.gmail.com>
	 <Pine.LNX.4.62.0503021128001.14333@node2.an-vo.com>
	 <Pine.LNX.4.56.0503021727320.20488@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.56.0503021727320.20488@pentafluge.infradead.org>
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
Cc: Jon Smirl <jonsmirl@gmail.com>, DRI developer's list <dri-devel@lists.sourceforge.net>

On Wed, 2005-03-02 at 17:29 +0000, James Simmons wrote:
> > Hi Jon,
> > 
> >     What about isolating interrupt-handling code into a small driver ?
> > Something simple to respond to interrupts and call all handlers with a 
> > certain mask.
> > 
> >     This would be useful not only for drm and fbdev but also for km 
> > (v4l capture module) and stereo-glasses code.
> 
> Ultimatly this is the goal. That is what the struct xxx_par is for in 
> struct fb_info. It is the core driver private data that can be shared by 
> everyone. Ben would you mind if I reworked your code to have this "core".
> It will take me some time but I can have it working. I need to do some 
> fixes for multiple monitor handling anyways.

Wait, wait ... there is already Jon working on the driver, and I plan to
include part of his recent work along with some initial dual head
support soon, let's avoid having too many people working at the same
time on it.

Also, with the merge DRM/fbdev, this will become a non-issue, wether the
ioctl comes from DRM or fbdev, we'll be able to do the right thing.

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
