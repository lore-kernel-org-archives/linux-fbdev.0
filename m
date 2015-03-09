From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 09 Mar 2015 09:47:12 +0000
Subject: Re: [PATCH 1/4] staging: sm750fb: wrong type for print
Message-Id: <20150309093511.GA9566@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425817886-14387-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20150309092209.GB10964@mwanda>
In-Reply-To: <20150309092209.GB10964@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 09, 2015 at 12:22:09PM +0300, Dan Carpenter wrote:
> On Sun, Mar 08, 2015 at 06:01:23PM +0530, Sudip Mukherjee wrote:
> > diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
> > index 711676c..2ab7b74 100644
> > --- a/drivers/staging/sm750fb/sm750.h
> > +++ b/drivers/staging/sm750fb/sm750.h
> > @@ -59,10 +59,10 @@ struct lynx_share{
> >  		}mtrr;
> >  #endif
> >  	/* all smi graphic adaptor got below attributes */
> > -	resource_size_t vidmem_start;
> > -	resource_size_t vidreg_start;
> > -	resource_size_t vidmem_size;
> > -	resource_size_t vidreg_size;
> > +	unsigned long vidmem_start;
> > +	unsigned long vidreg_start;
> > +	unsigned long vidmem_size;
> > +	unsigned long vidreg_size;
> >  	volatile unsigned char __iomem * pvReg;
> >  	unsigned char __iomem * pvMem;
> >  	/* locks*/
> 
> This seems like a very risky sort of change.  It's not explained very
> well in the changelog.  What's the deal?
it mainly started with the build warnings of incorrect format specifier.

v2 gives a little more details in the comments section. copying that here for your convenience:

"V2: Giedrius commented resource_size_t can be either u64 or u32
depending on if CONFIG_PHYS_ADDR_T_64BIT. based on his comments i
should have kept the datatype as resource_size_t and  used %pa as the
format specifier. But since this is a framebuffer device and it
should follow what the framebuffer layer is suggesting in
struct fb_fix_screeninfo at smem_start and mmio_start."

so accoringly, like all other framebuffer devices, vidmem_start and vidreg_start should be unsigned long and vidmem_size and vidreg_size should be __u32.


regards
sudip
> 
> regards,
> dan carpenter
> 
