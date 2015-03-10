From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 10 Mar 2015 20:17:54 +0000
Subject: Re: [PATCH 4/6] staging: sm750fb: correct incompatible pointer type
Message-Id: <20150310201754.GA8122@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426007817-1884-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1426007817-1884-5-git-send-email-sudipm.mukherjee@gmail.com>
 <20150310201100.GA17629@kroah.com>
In-Reply-To: <20150310201100.GA17629@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Mar 10, 2015 at 09:11:00PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 10, 2015 at 10:46:55PM +0530, Sudip Mukherjee wrote:
> > we were getting build warnings about assignment of incompatible
> > pointer types. some of the function definitions were having wrong
> > return type or arguments.
> > 
> > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> > ---
> >  drivers/staging/sm750fb/sm750.h       | 11 ++++++-----
> >  drivers/staging/sm750fb/sm750_accel.c |  4 ++--
> >  drivers/staging/sm750fb/sm750_accel.h |  4 ++--
> >  3 files changed, 10 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
> > index d39968c..edb955a 100644
> > --- a/drivers/staging/sm750fb/sm750.h
> > +++ b/drivers/staging/sm750fb/sm750.h
> > @@ -23,7 +23,7 @@ struct lynx_accel{
> >  	volatile unsigned char __iomem * dpPortBase;
> >  
> >  	/* function fointers */
> > -	int (*de_init)(struct lynx_accel *);
> > +	void (*de_init)(struct lynx_accel *);
> 
> That's ok, but:
> 
> >  
> >  	int (*de_wait)(void);/* see if hardware ready to work */
> >  
> > @@ -34,8 +34,8 @@ struct lynx_accel{
> >  						u32,u32,u32,u32,
> >  						u32,u32,u32,u32);
> >  
> > -	int (*de_imageblit)(struct lynx_accel *,const char *,u32,u32,u32,
> > -						u32,u32,u32,u32,u32,u32,u32,u32,u32);
> > +	int (*de_imageblit)(struct lynx_accel *, const char *, u32, u32, u32,
> > +			    u32, u32, u32, u32, u32, u32, u32, u32, u32);
> >  
> 
> 
> This isn't fixing an error.
> 
> >  };
> >  
> > @@ -120,8 +120,9 @@ struct lynxfb_crtc{
> >  	int(*proc_setColReg)(struct lynxfb_crtc*,ushort,ushort,ushort,ushort);
> >  	void (*clear)(struct lynxfb_crtc*);
> >          /* pan display */
> > -        int(*proc_panDisplay)(struct lynxfb_crtc*, struct fb_var_screeninfo*,
> > -                struct fb_info*);
> > +	int (*proc_panDisplay)(struct lynxfb_crtc*,
> > +			       const struct fb_var_screeninfo*,
> > +			       const struct fb_info*);
> 
> That's a nice cleanup, but it's not even the correct cleanup.

Oops, sorry, it is the correct cleanup, I was looking at the '*'
placement, not the const part.

but the patch needs to be redone, I'll just go fix up the build warnings
for now...

greg k-h
