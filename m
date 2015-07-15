From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 15 Jul 2015 04:58:56 +0000
Subject: Re: [PATCH 4/5] staging: sm7xxfb: define new macros
Message-Id: <20150715044655.GA17865@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436256877-10754-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1436256877-10754-5-git-send-email-sudipm.mukherjee@gmail.com>
 <20150715030508.GA20352@kroah.com>
In-Reply-To: <20150715030508.GA20352@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>

On Tue, Jul 14, 2015 at 08:05:08PM -0700, Greg Kroah-Hartman wrote:
> On Tue, Jul 07, 2015 at 01:44:36PM +0530, Sudip Mukherjee wrote:
> > +#define mmio_addr		0x00c00000
> > +#define seqw17
> 
> Odd, empty macros are not good, because:
> 
> > -#ifdef __BIG_ENDIAN
> >  		if (sfb->fb->var.bits_per_pixel = 32)
> > -			smtc_seqw(0x17, 0x30);
> > -#endif
> > +			seqw17;
> 
> That just looks wrong :(
I think it will look better in c file if I make it as
#define seqw17()
I will respin the patches and send.

regards
sudip 
