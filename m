From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Fri, 02 Jul 2010 07:30:01 +0000
Subject: Re: [PATCH 1/3] FB: Add some members for CPU Interface.
Message-Id: <20100702073001.GA25492@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4C29CFBD.3040205@samsung.com>
	<AANLkTilgB3s8hy5Qg7IYpyBzwHCgK_GswVZqpxhryU5L@mail.gmail.com>
In-Reply-To: <AANLkTilgB3s8hy5Qg7IYpyBzwHCgK_GswVZqpxhryU5L@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jun 30, 2010 at 08:02:31AM +0800, Jaya Kumar wrote:
> > diff --git a/include/linux/fb.h b/include/linux/fb.h
> > index 907ace3..73381c3 100644
> > --- a/include/linux/fb.h
> > +++ b/include/linux/fb.h
> > @@ -269,6 +269,12 @@ struct fb_var_screeninfo {
> >  	__u32 vmode;			/* see FB_VMODE_*		*/
> >  	__u32 rotate;			/* angle we rotate counter clockwise */
> >  	__u32 reserved[5];		/* Reserved for future compatibility */
> > +
> > +	/* For cpu interface timing. */
> > +	__u32 cs_setup;
> > +	__u32 wr_setup;
> > +	__u32 wr_act;
> > +	__u32 wr_hold;

This changes the framebuffer userspace API, making it incompatible with
existing users.  What this means is that stuff using the framebuffer API
in userspace has to be upgraded/downgraded in lock-step with this change
- which is not a good idea.
