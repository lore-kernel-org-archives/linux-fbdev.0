From: Joe Perches <joe@perches.com>
Date: Wed, 23 Aug 2017 21:32:42 +0000
Subject: Re: [PATCH] drivers: video: Fix 80 character limit and remove unnecessary space
Message-Id: <1503523962.6933.15.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170821140419epcas1p44df6f964a3977e1305cd4845cfcef783@epcas1p4.samsung.com>
         <1503324231-10675-1-git-send-email-himanshujha199640@gmail.com>
         <5135691.E4iXgiitH9@amdc3058>
In-Reply-To: <5135691.E4iXgiitH9@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Himanshu Jha <himanshujha199640@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wed, 2017-08-23 at 18:12 +0200, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> Please use a more descriptive patch subject, i.e.
> "fbdev: vgastate: fix checkpatch.pl reported warnings".
> 
> Please also cc: fbdev mailing list (linux-fbdev@vger.kernel.org
> on fbdev patches).
> 
> On Monday, August 21, 2017 07:33:51 PM Himanshu Jha wrote:
> > Fixes the following checkpatch warnings:
> > WARNING: line over 80 characters
> > WARNING: space prohibited between function name and open parenthesis '('
> > WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
[]
> > diff --git a/drivers/video/vgastate.c b/drivers/video/vgastate.c
[]
> > @@ -31,8 +31,9 @@ struct regstate {
> >  	__u8 misc;
> >  };
> >  
> > -static inline unsigned char vga_rcrtcs(void __iomem *regbase, unsigned short iobase,
> > -				       unsigned char reg)
> > +static inline unsigned char vga_rcrtcs(void __iomem *regbase,
> > +						unsigned short iobase,
> > +							unsigned char reg)
> 
> This is not an improvement and doesn't conform to the kernel CodingStyle.
> 
> It should be:
> 
> static inline unsigned char vga_rcrtcs(void __iomem *regbase,
> 				       unsigned short iobase,
> 				       unsigned char reg)
> 
> >  {
> >  	vga_w(regbase, iobase + 0x4, reg);
> >  	return vga_r(regbase, iobase + 0x5);

Better to remove the inline and let the compiler decide too.

Perhaps:

static unsigned char vga_rcrtcs(void __iomem *regbase, unsigned short iobase,
				unsigned char reg)

