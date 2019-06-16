From: Shobhit Kukreti <shobhitkukreti@gmail.com>
Date: Sun, 16 Jun 2019 05:54:26 +0000
Subject: Re: [PATCH] staging: fbtft: Fix checkpatch ERROR: space prohibited before that close parenthesis ')'
Message-Id: <20190616055425.GA6051@t-1000>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190614023225.GA27938@t-1000> <20190615173302.GB4914@kroah.com>
In-Reply-To: <20190615173302.GB4914@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Sat, Jun 15, 2019 at 07:33:02PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jun 13, 2019 at 07:32:28PM -0700, Shobhit Kukreti wrote:
> > Cleaned up code to resolve  the checkpatch error
> > ERROR: space prohibited before that close parenthesis ')'
> > from the file:
> > 
> > fbtft/fbtft-bus.c
> > 
> > Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
> > ---
> >  drivers/staging/fbtft/fbtft-bus.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
> > index 2ea814d..2b43bc2 100644
> > --- a/drivers/staging/fbtft/fbtft-bus.c
> > +++ b/drivers/staging/fbtft/fbtft-bus.c
> > @@ -62,9 +62,9 @@ out:									      \
> >  }                                                                             \
> >  EXPORT_SYMBOL(func);
> >  
> > -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> > +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8,)
> >  define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
> > -define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
> > +define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16,)
> 
> Will this still build?  I thought I remember some old versions of gcc
> not liking this...
I was able to build it with Ubuntu/Linaro GCC-5.4.0
> 
> Did you test this patch out?
I booted the kernel on qemu-2.12 and insmod of fbtft drivers did not 
return any errors. I did not test on actual display hardware. 
If that is mandatory, I can drop the patch. 
> 
> thanks,
> 
> greg k-h

Thank you for your patience and feedback.

Shobhit Kukreti
