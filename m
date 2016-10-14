From: Edward Lipinsky <ellipinsky@gmail.com>
Date: Fri, 14 Oct 2016 05:18:25 +0000
Subject: Re: [PATCH] staging: sm750fb: Fix printk() style warning
Message-Id: <20161014051825.GA22102@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161002180505.GA19813@gmail.com>
 <20161002181301.GA22637@kroah.com>
 <20161007042736.GA18046@gmail.com>
 <20161007091204.GA29629@rapoport-lnx>
 <20161010143146.GA8218@gmail.com>
 <20161013143922.GA17656@rapoport-lnx>
In-Reply-To: <20161013143922.GA17656@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <mike.rapoport@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, sudip@vectorindia.org, teddy.wang@siliconmotion.com, linux-kernel@vger.kernel.org, sudipm.mukherjee@gmail.com

On Thu, Oct 13, 2016 at 05:39:22PM +0300, Mike Rapoport wrote:
> On Mon, Oct 10, 2016 at 07:31:46AM -0700, Edward Lipinsky wrote:
> > 
> > Thanks, that makes sense.  I tried deleting the if statement and printk()
> > from ddk750_help.c, and adding the following in lynxfb_pci_probe() after
> > calling hw_sm750_map() and checking for errors:
> > 
> > if (sm750_dev->revid = 0xfe)
> > 	dev_info(&pdev->dev, "found sm750le\n");
> > 
> > The driver compiles, loads and unloads ok with this code.
> > 
> > Does this look correct?
> 
> Yep, seems just right.
>  
> > Regards,
> > Ed L.

Good, thanks.  I will submit an updated patch.

Regards,
Ed L.
