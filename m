From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [Linux-fbdev-devel] Resource management.
Date: Tue, 22 Feb 2005 00:59:22 -0500
Message-ID: <9e47339105022121595913c9b@mail.gmail.com>
References: <Pine.LNX.4.56.0502211908520.14500@pentafluge.infradead.org>
	 <200502220653.01286.adaplas@hotpop.com>
	 <Pine.LNX.4.56.0502212313160.18148@pentafluge.infradead.org>
	 <9e473391050221170111610521@mail.gmail.com>
	 <Pine.LNX.4.56.0502220319330.20949@pentafluge.infradead.org>
	 <21d7e99705022120462cb9494c@mail.gmail.com>
	 <Pine.LNX.4.56.0502220450190.22255@pentafluge.infradead.org>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.56.0502220450190.22255@pentafluge.infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@www.infradead.org>
Cc: Dave Airlie <airlied@gmail.com>, James Simmons <jsimmons@pentafluge.infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, adaplas@pol.net, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, 22 Feb 2005 05:13:07 +0000 (GMT), James Simmons
<jsimmons@www.infradead.org> wrote:
> > > 4. Which comes to the next point. The code is not modular enough. Take
> > >    drm_bufs.c. Everything is a ioctl function. This has a few disadvantages.
> > >    One is the fbdev layer couldn't just link into it so fbcon could use
> > >    it. The second is it's not easy to take advantage of things like sysfs.
> > >    If you could untangle the code somewhat it would make life so much
> > >    easier. That would include making life easier for OS ports.
> >
> > the reason we can't take advantage of sysfs or anything like it is
> > that we can't bind to the PCI device as we break things.. this is the
> > root of a lot of our problems...
> 
> Is this because you want to be OS portable? This makes things very very
> hard to merge. Fbdev attempts to take advantage the most powerful linux
> kernel features.

My turn to laugh! It's because Linux only allow one driver to bind to
the device and fbdev has already bound to it. We have done
siginificant work to DRM to try and work around this (stealth mode)
but the right solution is to have a common base driver.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
--
