From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Tue, 14 Aug 2012 06:31:16 +0000
Subject: RE: [PATCH v3] video: da8xx-fb: add 24bpp LCD configuration support
Message-Id: <A73F36158E33644199EB82C5EC81C7BC3E9A4C28@DBDE01.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1342712266-4381-1-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1342712266-4381-1-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

On Mon, Jul 23, 2012 at 13:56:42, Manjunathappa, Prakash wrote:
> Hi,
> 
> On Thu, Jul 19, 2012 at 21:07:46, Manjunathappa, Prakash wrote:
> > LCD controller on am335x supports 24bpp raster configuration in addition
> > to ones on da850. LCDC also supports 24bpp in unpacked format having
> > ARGB:8888 32bpp format data in DDR, but it doesn't interpret alpha
> > component of the data.
> > 
> > Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> > Cc: Anatolij Gustschin <agust@denx.de>
> > ---
[...]
> > @@ -546,6 +559,8 @@ static int lcd_cfg_frame_buffer(struct da8xx_fb_par *par, u32 width, u32 height,
> >  	return 0;
> >  }
> >  
> > +
> > +#define CNVT_TOHW(val, width) ((((val)<<(width))+0x7FFF-(val))>>16)
> 
> since multiple FB drivers have re-defined this macro, I will move this to common place(linux/fb.h) and
> convert it as inline function.
> 

This macro has lot of variations in various hardware and as I do not have bigger picture to address them
all, so for now I will be dropping the attempt of moving it to common place. This will be taken up later
point of time.

Thanks,
Prakash
> 
> >  static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
> [...]
> 

