From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Thu, 12 Jul 2012 14:13:44 +0000
Subject: RE: [PATCH 1/2] video: da8xx-fb: configure FIFO threshold to reduce underflow errors
Message-Id: <A73F36158E33644199EB82C5EC81C7BC3E9982BA@DBDE01.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4FFECFCE.2000308@mvista.com>
In-Reply-To: <4FFECFCE.2000308@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Sergei,

On Thu, Jul 12, 2012 at 18:53:26, Sergei Shtylyov wrote:
> Hello.
> 
> On 11-07-2012 19:14, Manjunathappa, Prakash wrote:
> 
> > Patch works around the below silicon errata:
> > During LCDC initialization, there is the potential for a FIFO
> > underflow condition to occur. A FIFO underflow condition
> > occurs when the input FIFO is completely empty and the LCDC
> > raster controller logic that drives data to the output pins
> > attempts to fetch data from the FIFO. When a FIFO underflow
> > condition occurs, incorrect data will be driven out on the
> > LCDC data pins.
> 
> > Software should poll the FUF bit field in the LCD_STAT register
> > to check if an error condition has occurred or service the
> > interrupt if FUF_EN is enabled when FUF occurs. If the FUF bit
> > field has been set to 1, this will indicate an underflow
> > condition has occurred and then the software should execute a
> > reset of the LCDC via the LPSC.
> 
> > This problem may occur if the LCDC FIFO threshold size
> > (LCDDMA_CTRL[TH_FIFO_READY]) is left at its default value after
> > reset. Increasing the FIFO threshold size will reduce or
> > eliminate underflows. Setting the threshold size to 256 double
> > words or larger is recommended.
> 
> > Above issue is described in section 2.1.3 of silicon errata
> > http://www.ti.com/lit/er/sprz313e/sprz313e.pdf
> 
> > Signed-off-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
> > Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> > ---
> >   drivers/video/da8xx-fb.c |   15 +++++++++++----
> >   include/video/da8xx-fb.h |    3 +++
> >   2 files changed, 14 insertions(+), 4 deletions(-)
> 
> > diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> > index 47118c7..2010dd7 100644
> > --- a/drivers/video/da8xx-fb.c
> > +++ b/drivers/video/da8xx-fb.c
> > @@ -344,8 +344,8 @@ static void lcd_blit(int load_mode, struct da8xx_fb_par *par)
> >   	lcd_enable_raster();
> >   }
> >
> > -/* Configure the Burst Size of DMA */
> > -static int lcd_cfg_dma(int burst_size)
> > +/* Configure the Burst Size and fifo threhold of DMA */
> > +static int lcd_cfg_dma(int burst_size,  int fifo_th)
> 
>     One space too much.
> 

Yes, I will correct this. Don't know how checkpatch missing it.

> >   {
> >   	u32 reg;
> >
> > @@ -719,8 +722,10 @@ static irqreturn_t lcdc_irq_handler_rev02(int irq, void *arg)
> >
> >   	if ((stat & LCD_SYNC_LOST) && (stat & LCD_FIFO_UNDERFLOW)) {
> >   		lcd_disable_raster();
> > +		clk_disable(par->lcdc_clk);
> >   		lcdc_write(stat, LCD_MASKED_STAT_REG);
> 
>     Will LCDC register wrtite work without LCDC clock?
> 

Yes it cannot happen. I will remove it.

Thanks,
Prakash

