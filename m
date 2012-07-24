From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Tue, 24 Jul 2012 07:17:05 +0000
Subject: RE: [PATCH v2] da8xx-fb: allow frame to complete after disabling LCDC
Message-Id: <A73F36158E33644199EB82C5EC81C7BC3E99C802@DBDE01.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343102984-6056-1-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1343102984-6056-1-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Sriram,

On Tue, Jul 24, 2012 at 10:11:55, Madhvapathi Sriram wrote:
> On Tue, Jul 24, 2012 at 9:39 AM, Manjunathappa, Prakash
> <prakash.pm@ti.com> wrote:
[...]
> >  /* Disable the Raster Engine of the LCD Controller */
> > -static inline void lcd_disable_raster(void)
> > +static inline void lcd_disable_raster(bool wait_for_frame_done)
> >  {
> >         u32 reg;
> > +       u32 loop_cnt = 0;
> > +       u32 stat;
> > +       u32 i = 0;
> > +
> > +       /* 50 milli seconds should be sufficient for a frame to complete
> > */
> > +       if (wait_for_frame_done)
> > +               loop_cnt = 50;
> >
> >         reg = lcdc_read(LCD_RASTER_CTRL_REG);
> >         if (reg & LCD_RASTER_ENABLE)
> >                 lcdc_write(reg & ~LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
> > +
> > +       /* Wait for the current frame to complete */
> > +       do {
> > +               if (lcd_revision = LCD_VERSION_1)
> > +                       stat = lcdc_read(LCD_STAT_REG);
> > +               else
> > +                       stat = lcdc_read(LCD_RAW_STAT_REG);
> > +               mdelay(1);
> > +       } while (!(stat & LCD_FRAME_DONE) && (i++ < loop_cnt));
> 
> Are you sure it should be do while? You call it from interrupt handler
> too (sync lost handling). In that case mdelay() from interrupt
> context..not a good idea I feel.
> 

Ok. I will change it as below:

while (1) {
               if (lcd_revision = LCD_VERSION_1)
                       stat = lcdc_read(LCD_STAT_REG);
               else
                       stat = lcdc_read(LCD_RAW_STAT_REG);
               if((stat & LCD_FRAME_DONE) || (i++ > loop_cnt))
                    break;
               mdelay(1);
}

> > +
> > +       if (lcd_revision = LCD_VERSION_1)
> > +               lcdc_write(stat, LCD_STAT_REG);
> > +       else
> > +               lcdc_write(stat, LCD_MASKED_STAT_REG);
> > +
> > +       if ((loop_cnt != 0) && (i >= loop_cnt)) {
> > +               pr_err("LCD Controller timed out\n");
> > +               return;
> 
> return may not be necessary?
> 

Agree, I will remove it.

Thanks,
Prakash

> > +       }
> >  }

[...] 

