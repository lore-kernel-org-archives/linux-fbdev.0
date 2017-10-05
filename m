From: Mauro Salvini <mauro.salvini@smigroup.net>
Date: Thu, 05 Oct 2017 07:43:15 +0000
Subject: Re: [PATCH] video: fbdev: mxsfb: fix pixelclock polarity
Message-Id: <1507189395.2126.18.camel@smigroup.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1453771756-5418-1-git-send-email-stefan@agner.ch>
In-Reply-To: <1453771756-5418-1-git-send-email-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

Hi all,

what is the state of this patch? Two days ago I had trouble running a
TFT panel properly on a iMX6 board because of problem that this patch
aims to solve.

I saw that an affine patch from same author was accepted into drm/fbdev
(commit 53990e416bb7adaa59d045f325a47f31a11b75ee "drm: mxsfb: fix pixel
clock polarity" on mainline branch).

Thanks in advance, regards

Mauro


> Hi Shawn,
> 
> On 2016-01-25 17:29, Stefan Agner wrote:
> > The PIXDATA flags of the display_flags enum are controller centric,
> > e.g. NEGEDGE means the controller shall drive the data signals on
> > pixelclocks negative edge. However, the drivers flag is display
> > centric: Sample the data on negative (falling) edge.
> > 
> > Therefore, change the if statement to check for the POSEDGE flag
> > (which is typically not set):
> > Drive on positive edge => sample on negative edge
> 
> Any comment on that patch?
> 
> --
> Stefan
> 
> 
> > 
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > ---
> > Hi all
> > 
> > Shawn, I would like to have at least your Ack on this before merge.
> > 
> > It seems that this has been wrong since the driver is able to use
> > the timings from the device tree, introduced with 669406534b4a
> > ("video: mxsfb: get display timings from device tree").
> > 
> > Not sure how many device trees actually specify the wrong pixel
> clock
> > polarity due to that. At least the initial flag convertion from the
> > old platform data structures done with 0d9f8217db15 ("ARM: mxs:
> move
> > display timing configurations into device tree") seems to be
> affected
> > and would need to be changed accordingly...
> > 
> > Not sure how we should handle this, maybe just invert all
> > pixelclk-active properties where the mxsfb driver is in use...?
> > 
> > --
> > Stefan
> > 
> >  drivers/video/fbdev/mxsfb.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/mxsfb.c
> b/drivers/video/fbdev/mxsfb.c
> > index 4e6608c..38898a9 100644
> > --- a/drivers/video/fbdev/mxsfb.c
> > +++ b/drivers/video/fbdev/mxsfb.c
> > @@ -150,7 +150,7 @@
> >  #define STMLCDIF_24BIT 3 /** pixel data bus to the display is of
> 24
> > bit width */
> >  
> >  #define MXSFB_SYNC_DATA_ENABLE_HIGH_ACT	(1 << 6)
> > -#define MXSFB_SYNC_DOTCLK_FALLING_ACT	(1 << 7) /* negtive
> edge sampling */
> > +#define MXSFB_SYNC_DOTCLK_FALLING_ACT	(1 << 7) /* negative
> edge sampling */
> >  
> >  enum mxsfb_devtype {
> >  	MXSFB_V3,
> > @@ -788,7 +788,16 @@ static int mxsfb_init_fbinfo_dt(struct
> mxsfb_info *host,
> >  
> >  	if (vm.flags & DISPLAY_FLAGS_DE_HIGH)
> >  		host->sync |= MXSFB_SYNC_DATA_ENABLE_HIGH_ACT;
> > -	if (vm.flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
> > +
> > +	/*
> > +	 * The PIXDATA flags of the display_flags enum are
> controller
> > +	 * centric, e.g. NEGEDGE means drive data on negative
> edge.
> > +	 * However, the drivers flag is display centric: Sample
> the
> > +	 * data on negative (falling) edge. Therefore, check for
> the
> > +	 * POSEDGE flag:
> > +	 * drive on positive edge => sample on negative edge
> > +	 */
> > +	if (vm.flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
> >  		host->sync |= MXSFB_SYNC_DOTCLK_FALLING_ACT;
> >  
> >  put_display_node:
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

On 2016-01-25 17:29, Stefan Agner wrote:
> The PIXDATA flags of the display_flags enum are controller centric,
> e.g. NEGEDGE means the controller shall drive the data signals on
> pixelclocks negative edge. However, the drivers flag is display
> centric: Sample the data on negative (falling) edge.
> 
> Therefore, change the if statement to check for the POSEDGE flag
> (which is typically not set):
> Drive on positive edge => sample on negative edge

Any comment on that patch?

--
Stefan


> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Hi all
> 
> Shawn, I would like to have at least your Ack on this before merge.
> 
> It seems that this has been wrong since the driver is able to use
> the timings from the device tree, introduced with 669406534b4a
> ("video: mxsfb: get display timings from device tree").
> 
> Not sure how many device trees actually specify the wrong pixel clock
> polarity due to that. At least the initial flag convertion from the
> old platform data structures done with 0d9f8217db15 ("ARM: mxs: move
> display timing configurations into device tree") seems to be affected
> and would need to be changed accordingly...
> 
> Not sure how we should handle this, maybe just invert all
> pixelclk-active properties where the mxsfb driver is in use...?
> 
> --
> Stefan
> 
>  drivers/video/fbdev/mxsfb.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/mxsfb.c
b/drivers/video/fbdev/mxsfb.c
> index 4e6608c..38898a9 100644
> --- a/drivers/video/fbdev/mxsfb.c
> +++ b/drivers/video/fbdev/mxsfb.c
> @@ -150,7 +150,7 @@
>  #define STMLCDIF_24BIT 3 /** pixel data bus to the display is of 24
> bit width */
>  
>  #define MXSFB_SYNC_DATA_ENABLE_HIGH_ACT	(1 << 6)
> -#define MXSFB_SYNC_DOTCLK_FALLING_ACT	(1 << 7) /* negtive
edge sampling */
> +#define MXSFB_SYNC_DOTCLK_FALLING_ACT	(1 << 7) /* negative
edge sampling */
>  
>  enum mxsfb_devtype {
>  	MXSFB_V3,
> @@ -788,7 +788,16 @@ static int mxsfb_init_fbinfo_dt(struct
mxsfb_info *host,
>  
>  	if (vm.flags & DISPLAY_FLAGS_DE_HIGH)
>  		host->sync |= MXSFB_SYNC_DATA_ENABLE_HIGH_ACT;
> -	if (vm.flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
> +
> +	/*
> +	 * The PIXDATA flags of the display_flags enum are
controller
> +	 * centric, e.g. NEGEDGE means drive data on negative edge.
> +	 * However, the drivers flag is display centric: Sample the
> +	 * data on negative (falling) edge. Therefore, check for the
> +	 * POSEDGE flag:
> +	 * drive on positive edge => sample on negative edge
> +	 */
> +	if (vm.flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
>  		host->sync |= MXSFB_SYNC_DOTCLK_FALLING_ACT;
>  
>  put_display_node:
