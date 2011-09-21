From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 21 Sep 2011 06:25:36 +0000
Subject: Re: [PATCH 1/3] include: fb: Add definiton for window positioning
Message-Id: <1316586336.1949.14.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316532641-2657-1-git-send-email-ajaykumar.rs@samsung.com>
	<1316532641-2657-2-git-send-email-ajaykumar.rs@samsung.com>
	<20110920112427.GB19695@sapphire.tkos.co.il>
	<CAEC9eQOpwfmRfcxHoiA00xX0a=dxXj1xJDpW14DozGXKXPJ3Xg@mail.gmail.com>
	<20110920170858.GA3827@tarshish>
In-Reply-To: <20110920170858.GA3827@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, 2011-09-20 at 20:08 +0300, Baruch Siach wrote:
> Hi Ajay,
> 
> On Tue, Sep 20, 2011 at 08:56:57PM +0530, Ajay kumar wrote:
> > Hi Baruch,
> > On Tue, Sep 20, 2011 at 4:54 PM, Baruch Siach <baruch@tkos.co.il> wrote:
> > > Hi Ajay,
> > >
> > > On Tue, Sep 20, 2011 at 11:30:39AM -0400, Ajay Kumar wrote:
> > >> This patch adds a data structure definiton to hold framebuffer windows/planes.
> > >> An ioctl number is also added to provide user access
> > >> to change window position dynamically.
> > >
> > > [snip]
> > >
> > >> +/* Window overlaying */
> > >> +struct fb_overlay_win_pos {
> > >> +     __u32 win_pos_x;        /* x-offset from LCD(0,0) where window starts */
> > >> +     __u32 win_pos_y;        /* y-offset from LCD(0,0) where window starts */
> > >> +};
> > >
> > > Why not allow negative offsets where the left or upper part of the framebuffer
> > > is hidden?
> > 
> > Thanks for pointing it out. Are there drivers which place the overlay
> > windows such that some part of the window is hidden from being
> > displayed on the screen?
> 
> I don't know. However, since this is new userspace ABI which should stay 
> compatible forever, we should make sure to do it right. Using __s32 instead of 
> __u32 won't limit us in the future.

OMAP HW doesn't allow "funny" things like overlay being outside the
visible area, i.e. negative position or size larger than the display.
And my guess is that hardware rarely allow things like that, as it would
just complicate the hardware without any gain.

Out-of-display-overlays can of course be emulated by the software. But
I'm not sure if it's good to add the complexity in the driver layer, as
it could as well be handled in the userspace.

Then again, a signed value would be future safer ("just in case"), and
if the driver can just reject values it doesn't want to support, there's
no real harm there either.

 Tomi


