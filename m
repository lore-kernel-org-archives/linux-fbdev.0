From: Dejin Zheng <zhengdejin5@gmail.com>
Date: Thu, 23 Apr 2020 14:52:40 +0000
Subject: Re: [PATCH v1] fbdev: sm712fb: fix an issue about iounmap for a wrong address
Message-Id: <20200423145239.GC1562@nuc8i5>
List-Id: <linux-fbdev.vger.kernel.org>
References: <bb6ba7c9-ad92-9c54-e1c4-91d2f7d0f5f8@web.de>
In-Reply-To: <bb6ba7c9-ad92-9c54-e1c4-91d2f7d0f5f8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

On Thu, Apr 23, 2020 at 02:14:48PM +0200, Markus Elfring wrote:
> > the sfb->fb->screen_base is not save the value get by iounmap() when
> > the chip id is 0x720.
> 
> I suggest to improve this change description.
> How did you determine relevant differences for the mentioned chip model?
>
Read and check its codes。

smtcfb_pci_probe() --> smtc_map_smem()

smtcfb_pci_probe()
switch (sfb->chip_id) {
        case 0x710:
        case 0x712:
		sfb->lfb = ioremap(mmio_base, mmio_addr);
	case 0x720:
		sfb->dp_regs = ioremap(mmio_base, 0x00200000 + smem_size);
                sfb->lfb = sfb->dp_regs + 0x00200000;
	}
smtc_map_smem()
	sfb->fb->screen_base = sfb->lfb;


smtcfb_pci_remove() --> smtc_unmap_smem()

smtc_unmap_smem()
	iounmap(sfb->fb->screen_base);

> 
> > so iounmap() for address sfb->fb->screen_base is not right.
> 
> Will another imperative wording become helpful here?
> 
yes, this is why need to change this code.

> 
> …
> > +++ b/drivers/video/fbdev/sm712fb.c
> > @@ -1429,6 +1429,8 @@  static int smtc_map_smem(struct smtcfb_info *sfb,
> >  static void smtc_unmap_smem(struct smtcfb_info *sfb)
> >  {
> >  	if (sfb && sfb->fb->screen_base) {
> > +		if (sfb->chip_id = 0x720)
> > +			sfb->fb->screen_base -= 0x00200000;
> >  		iounmap(sfb->fb->screen_base);
> 
> How do you think about to use descriptive identifiers for
> the shown constants?
>
These two constants are originally in the driver, I don't know enough
about its meaning, There are a lot of constants in this driver. If I
replace it with the macro, I worry that the name of the macro may not
be accurate.

> Would you like to clarify any related software analysis approaches?
>
just read coedes and check it.

> Regards,
> Markus
