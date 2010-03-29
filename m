From: "Ambrose, Martin" <martin@ti.com>
Date: Mon, 29 Mar 2010 12:48:17 +0000
Subject: RE: [PATCH] DA8XX/OMAP-L1XX: FB: Implement double buffering
Message-Id: <A24693684029E5489D1D202277BE894454567E23@dlee02.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4BAA2758.8060105@mvista.com>
In-Reply-To: <4BAA2758.8060105@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Sergei,

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov@mvista.com]
> Sent: Wednesday, March 24, 2010 9:53 AM
> 
> Martin Ambrose wrote:
> 
> >  This work includes the following:
> >  . Implement handler for FBIO_WAITFORVSYNC ioctl.
> >
> >  . Allocate the data and palette buffers separately.
> >    A consequence of this is that the palette and data loading is now
> >    done in different phases. And that the LCD must be disabled
> >    temporarily after the palette is loaded but this will only happen
> >    once after init and each time the palette is changed. I think this
> >    is OK.
> >
> >  . Allocate two (ping and pong) framebuffers from memory.
> >
> >  . Add pan_display handler which toggles the LCDC DMA registers between
> >    the ping and pong buffers.
> >
> > Signed-off-by: Martin Ambrose <martin@ti.com>
> >
> 
>   Just a quick comment on code formatting...
> 
> > diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> > index 369a5b3..7e192e2 100644
> > --- a/drivers/video/da8xx-fb.c
> > +++ b/drivers/video/da8xx-fb.c
> > @@ -35,7 +35,9 @@
> >  #define DRIVER_NAME "da8xx_lcdc"
> >
> >  /* LCD Status Register */
> > +#define LCD_END_OF_FRAME1		BIT(9)
> >  #define LCD_END_OF_FRAME0		BIT(8)
> > +#define LCD_PL_LOAD_DONE                BIT(6)
> >
> 
>    Could you use tabs consistently?
> 
> >  #define LCD_FIFO_UNDERFLOW		BIT(5)
> >  #define LCD_SYNC_LOST			BIT(2)
> >
> > @@ -57,11 +59,13 @@
> >  #define LCD_PALETTE_LOAD_MODE(x)	((x) << 20)
> >  #define PALETTE_AND_DATA		0x00
> >  #define PALETTE_ONLY			0x01
> > +#define DATA_ONLY			0x02
> >
> >  #define LCD_MONO_8BIT_MODE		BIT(9)
> >  #define LCD_RASTER_ORDER		BIT(8)
> >  #define LCD_TFT_MODE			BIT(7)
> >  #define LCD_UNDERFLOW_INT_ENA		BIT(6)
> > +#define LCD_PL_ENABLE                   BIT(4)
> >
> 
>    Same here...

Thanks. I fixed and I'll be sending out a rev 2 shortly.

Regards,
Martin
 
> WBR, Sergei

