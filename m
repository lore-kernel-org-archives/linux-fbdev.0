From: Inki Dae <inki.dae@samsung.com>
Date: Mon, 22 Nov 2010 02:01:41 +0000
Subject: RE: [PATCH 2/3] S5PV210: added parameters for CPU interface to
Message-Id: <007c01cb89e9$34c6f330$9e54d990$%dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1290130171-7856-1-git-send-email-inki.dae@samsung.com>
In-Reply-To: <1290130171-7856-1-git-send-email-inki.dae@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org



> -----Original Message-----
> From: Kukjin Kim [mailto:kgene.kim@samsung.com]
> Sent: Monday, November 22, 2010 10:29 AM
> To: 'Inki Dae'; linux-fbdev@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Cc: kyungmin.park@samsung.com; lethal@linux-sh.org; akpm@linux-
> foundation.org; ben-linux@fluff.org
> Subject: RE: [PATCH 2/3] S5PV210: added parameters for CPU interface to
> plat-samsung/fb.h
> 
> Inki Dae wrote:
> >
> > S5PV210: added parameters for CPU interface to plat-samsung/fb.h
> >
> > MIPI-DSI driver would use s3c-fb driver so I added some parameters
> > because MIPI-DSI driver supports CPU interface also.
> >
> > Signed-off-by: Inki Dae <inki.dae@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  arch/arm/plat-samsung/include/plat/fb.h |   11 ++++++++++-
> >  1 files changed, 10 insertions(+), 1 deletions(-)
> >
> Please add Ben and my e-mail in Cc next time.
> Ben and me are
> 
> > diff --git a/arch/arm/plat-samsung/include/plat/fb.h b/arch/arm/plat-
> > samsung/include/plat/fb.h
> > index cb3ca3a..1ba0ae0 100644
> > --- a/arch/arm/plat-samsung/include/plat/fb.h
> > +++ b/arch/arm/plat-samsung/include/plat/fb.h
> > @@ -22,14 +22,21 @@
> >   */
> >  #define S3C_FB_MAX_WIN	(5)
> >
> > +enum {
> > +	FIMD_VIDEO_MODE = 0,
> > +	FIMD_CPU_MODE
> > +};
> > +
> 
> Could you please explain about above modes?
> 

The way of transferring vido data consists of VIDEO(RGB) and CPU(I80 or
COMMAND) mode.
VIDEO mode transfers automatically video data(framebuffer) to LCD Panel
through RGB Interface in 60fps.
On the other hand, in case of CPU mode, video data are transferred by ARM
processor or
any hardware supporting CPU mode emulation such as FIMD hardware for
S5PC110, S5PC210 and so on.
A difference between VIDEO and CPU mode is that CPU mode needs trigger
signal.
(video data isn't transferred automatically)

MIPI-DSI driver uses s3c-fb driver so this driver should consider CPU mode
also.
Now, s3c-fb driver is just considering only RGB interface.

Thank you.

> >  /**
> >   * struct s3c_fb_pd_win - per window setup data
> > - * @win_mode: The display parameters to initialise (not for window 0)
> > + * @win_mode: The display parameters to RGB interface
> > + * @cpu_mode: The display parameters to CPU interface
> >   * @virtual_x: The virtual X size.
> >   * @virtual_y: The virtual Y size.
> >   */
> >  struct s3c_fb_pd_win {
> >  	struct fb_videomode	win_mode;
> > +	struct fb_cpumode	cpu_mode;
> >
> What's difference between win_mode and cpu_mode?
> 
> >  	unsigned short		default_bpp;
> >  	unsigned short		max_bpp;
> > @@ -43,6 +50,7 @@ struct s3c_fb_pd_win {
> >   *		the data from the display system to the connected display
> >   *		device.
> >   * @default_win: default window layer number to be used for UI layer.
> > + * @interface_mode: cpu mode or rgb mode.
> >   * @vidcon0: The base vidcon0 values to control the panel data format.
> >   * @vidcon1: The base vidcon1 values to control the panel data output.
> >   * @win: The setup data for each hardware window, or NULL for unused.
> > @@ -59,6 +67,7 @@ struct s3c_fb_platdata {
> >
> >  	struct s3c_fb_pd_win	*win[S3C_FB_MAX_WIN];
> >
> > +	u32			interface_mode;
> 
> Hmm...mode, mode, mode...:-(
> 
> >  	u32			 default_win;
> >
> >  	u32			 vidcon0;
> > --
> > 1.5.4.3
> >
> 
> 
> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.

