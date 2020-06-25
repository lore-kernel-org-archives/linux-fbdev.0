From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 25 Jun 2020 18:57:46 +0000
Subject: Re: [PATCH 0/8] Fix a bunch of W=1 warnings in Backlight
Message-Id: <20200625185746.GA1875182@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
 <20200624153216.GA1814806@ravnborg.org>
 <20200624154321.GH954398@dell>
 <20200624162446.GA1815586@ravnborg.org>
 <20200625080337.GN954398@dell>
In-Reply-To: <20200625080337.GN954398@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Lee Jones <lee.jones@linaro.org>
Cc: daniel.thompson@linaro.org, jingoohan1@gmail.com, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Lee.

On Thu, Jun 25, 2020 at 09:03:37AM +0100, Lee Jones wrote:
> On Wed, 24 Jun 2020, Sam Ravnborg wrote:
> 
> > Hi Lee.
> > 
> > On Wed, Jun 24, 2020 at 04:43:21PM +0100, Lee Jones wrote:
> > > On Wed, 24 Jun 2020, Sam Ravnborg wrote:
> > > 
> > > > Hi Lee.
> > > > 
> > > > On Wed, Jun 24, 2020 at 03:57:13PM +0100, Lee Jones wrote:
> > > > > Attempting to clean-up W=1 kernel builds, which are currently
> > > > > overwhelmingly riddled with niggly little warnings.
> > > > > 
> > > > > Lee Jones (8):
> > > > >   backlight: lms501kf03: Remove unused const variables
> > > > >   backlight: lcd: Add missing kerneldoc entry for 'struct device parent'
> > > > 
> > > > 
> > > > >   backlight: ili922x: Add missing kerneldoc descriptions for
> > > > >     CHECK_FREQ_REG() args
> > > > >   backlight: ili922x: Remove invalid use of kerneldoc syntax
> > > > >   backlight: ili922x: Add missing kerneldoc description for
> > > > >     ili922x_reg_dump()'s arg
> > > > I wonder why these warnings show up as nothing pulls in this .c file.
> > > > Anyway I would suggest to drop using kerneldoc syntax for single drivers
> > > > like this - and the benefit here is low.
> > > > Now they are typed, otherwise this ahd been fine in a single patch.
> > > 
> > > What do you mean by 'nothing pulls it in'?
> > There are no .rst files that includes any:
> > .. kernel-doc:: drivers/video/backlight/ili922x.c
> > 
> > so I do not see how the kernel-doc comments will be used by any
> > of the generated kernel-docs.
> 
> Looks like a common problem (if it is actually a problem):
> 
>  $ ./scripts/find-unused-docs.sh . | wc -l
>  1476
> 
> The role of this patch-set is not to eradicate unused kerneldoc
> headers, but to ensure they are formatted correctly.  W=1 builds
> currently complain of ill formatted kerneldocs, which is currently
> littering the build-log and masking some more important issues (which
> I'm also trying to fix en route).

My point is that I do not see why we should maintain correct kernel-doc
style comments for files that are not used to to generate kernel-doc.
It would serve us better to drop the kernel-doc style comments.
But thats just my opinion, feel free to ignore.

I digged a little and can see we run kernel-doc on all .c files
when we specify W=1 - which was a suprise to me.
That explains why I had not seen said warnings in my regular make
htmldocs runs.

	Sam

> 
> > > > >   backlight: backlight: Supply description for function args in existing
> > > > >     Kerneldocs
> > > > >   backlight: lm3630a_bl: Remove invalid checks for unsigned int < 0
> > > > >   backlight: qcom-wled: Remove unused configs for LED3 and LED4
> > > > 
> > > > The other fixes looks good.
> > > > They are all:
> > > > Acked-by: Sam Ravnborg <sam@ravnborg.org>
> > > 
> > > Thanks (although this should be Reviewed-by).
> > > 
> > > > >  drivers/video/backlight/backlight.c  | 2 ++
> > > > >  drivers/video/backlight/ili922x.c    | 8 ++++++--
> > > > >  drivers/video/backlight/lcd.c        | 1 +
> > > > >  drivers/video/backlight/lm3630a_bl.c | 4 ++--
> > > > >  drivers/video/backlight/lms501kf03.c | 8 --------
> > > > >  drivers/video/backlight/qcom-wled.c  | 8 --------
> > > > >  6 files changed, 11 insertions(+), 20 deletions(-)
> > > > > 
> > > 
> 
> -- 
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
