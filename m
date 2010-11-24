From: Inki Dae <inki.dae@samsung.com>
Date: Wed, 24 Nov 2010 01:41:23 +0000
Subject: RE: [PATCH 1/4] FB: added a structure for CPU interface to linux/fb.h
Message-Id: <001501cb8b78$b3c8aa80$1b59ff80$%dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1290496504-4867-1-git-send-email-inki.dae@samsung.com>
In-Reply-To: <1290496504-4867-1-git-send-email-inki.dae@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello.

Below is my comments
Thank you.

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov@mvista.com]
> Sent: Wednesday, November 24, 2010 1:02 AM
> To: Inki Dae
> Cc: linux-fbdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> kyungmin.park@samsung.com; kgene.kim@samsung.com; akpm@linux-
> foundation.org; lethal@linux-sh.org
> Subject: Re: [PATCH 1/4] FB: added a structure for CPU interface to
> linux/fb.h
> 
> Hello.
> 
> Inki Dae wrote:
> 
> > RGB or CPU interfaces could be used as display mode but framebuffer
> > framework doesn't consider CPU interface so I added this structure
> > because fb_cpumode structure could be used commonly.
> 
> > Signed-off-by: Inki Dae <inki.dae@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  include/linux/fb.h |   12 ++++++++++++
> >  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> > diff --git a/include/linux/fb.h b/include/linux/fb.h
> > index 7fca3dc..9b9842c 100644
> > --- a/include/linux/fb.h
> > +++ b/include/linux/fb.h
> > @@ -1147,6 +1147,18 @@ struct fb_videomode {
> >  	u32 flag;
> >  };
> >
> > +struct fb_cpumode {
> > +	const char *name;	/* optional */
> > +	u32 refresh;		/* optional */
> > +	u32 xres;
> > +	u32 yres;
> 
>     I think that those two fields should happily fit into 'u16' type.
> 
I agree to your opinion, but I just followed existing struct fb_videomode.
Do you or everybody have any idea for whether changing typef('u32' -> 'u16')
or not?
if it is more better to modify type then I will correct it.


> > +	u32 pixclock;
> > +	u32 cs_setup;
> > +	u32 wr_setup;
> > +	u32 wr_act;
> > +	u32 wr_hold;
> 
>     Suspecting the same about the above 4 fields...
> 

Same.

> WBR, Sergei

