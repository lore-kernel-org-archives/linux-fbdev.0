From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [Linux-fbdev-devel] Resource management.
Date: Tue, 22 Feb 2005 13:59:22 -0500
Message-ID: <a728f9f90502221059686284a7@mail.gmail.com>
References: <Pine.LNX.4.56.0502211908520.14500@pentafluge.infradead.org>
	 <200502220653.01286.adaplas@hotpop.com>
	 <Pine.LNX.4.56.0502212313160.18148@pentafluge.infradead.org>
	 <9e473391050221170111610521@mail.gmail.com>
	 <Pine.LNX.4.56.0502220319330.20949@pentafluge.infradead.org>
	 <21d7e99705022120462cb9494c@mail.gmail.com>
	 <9e47339105022121234d0f7f73@mail.gmail.com>
	 <Pine.LNX.4.56.0502221719440.30102@pentafluge.infradead.org>
Reply-To: Alex Deucher <alexdeucher@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.56.0502221719440.30102@pentafluge.infradead.org>
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
Cc: Jon Smirl <jonsmirl@gmail.com>, Dave Airlie <airlied@gmail.com>, James Simmons <jsimmons@pentafluge.infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, adaplas@pol.net, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, 22 Feb 2005 17:23:03 +0000 (GMT), James Simmons
<jsimmons@www.infradead.org> wrote:
> 
> > As far as I know none of the significant contributors on either fbdev
> > or DRM are being paid to work on the project.
> 
> So I have noticed. There is much to do but no real man power. We are
> talking about this merging but at our rate it will take 5 years to happen.
> We don't have the man power to do this. So I'm not going to bother
> merging. Its all pipe dreams here.
> 
> 

with that attitude it's never gonna happen.  I work almost exclusively
on X, but once we get at least one sample driver done (probably
radeon, I would be more than happy to devote my limited development
resources to the new drm/fb super driver.  Right now the kernel FB
drivers have no benefit for me so I don't use/develop them.  The drm
just works and I'm more interested in the crtc/modes/outputs handling
than the command processor control stuff.  I think a lot of X
developers (and porobably IHVs) will get on board when this happens. 
X is undermanned as well, but we've managed to do a pretty good job of
supported a lot of features on a fair number of cards.

Alex


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
--
