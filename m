From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 11 Jun 2012 11:05:17 +0000
Subject: Re: [PATCH 1/3] mx3fb: do not support panning with fb blanked
Message-Id: <20120611110517.GE11168@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1339376810-8247-1-git-send-email-Ying.Liu@freescale.com>
 <20120611095102.GD11168@n2100.arm.linux.org.uk>
 <CA+8Hj81L9-NC=08_dvV2u_eM0NdssJsjduAgTbH37nusu56Avw@mail.gmail.com>
In-Reply-To: <CA+8Hj81L9-NC=08_dvV2u_eM0NdssJsjduAgTbH37nusu56Avw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jun 11, 2012 at 06:46:14PM +0800, Liu Ying wrote:
> 2012/6/11, Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > On Mon, Jun 11, 2012 at 09:06:48AM +0800, Liu Ying wrote:
> >> This patch checks if framebuffer is unblanked before
> >> we actually trigger panning in custom pan display
> >> function.
> >>
> >> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
> >> ---
> >>  drivers/video/mx3fb.c |    5 +++++
> >>  1 files changed, 5 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
> >> index e3406ab..d53db60 100644
> >> --- a/drivers/video/mx3fb.c
> >> +++ b/drivers/video/mx3fb.c
> >> @@ -1063,6 +1063,11 @@ static int mx3fb_pan_display(struct
> >> fb_var_screeninfo *var,
> >>  	dev_dbg(fbi->device, "%s [%c]\n", __func__,
> >>  		list_empty(&mx3_fbi->idmac_channel->queue) ? '-' : '+');
> >>
> >> +	if (mx3_fbi->blank != FB_BLANK_UNBLANK) {
> >> +		dev_dbg(fbi->device, "panning with fb blanked not supported\n");
> >> +		return -EFAULT;
> >> +	}
> >
> > Why is this an error, and why return -EFAULT?  What userspace access
> > failed?
> >
> Hi, Russell,
> 
> IMHO, panning with framebuffer blanked is meaningless, at least, it is
> not a common usecase.

Yes, but why should anything in userspace care whether the display is
blanked or not?

For example, we may pan the display when a user program produces output,
and we're on the last line of the display.  We don't fail that just
because the screen happens to be blank.  So I don't see why we should
actively fail an explicit userspace pan request just because the console
happened to be blanked.

What I'm basically saying is that as far as _userspace_ is concerned,
all the standard APIs should just work as normal whether the display is
blanked or not.
