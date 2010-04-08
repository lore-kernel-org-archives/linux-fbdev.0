From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [PATCH 03/16] viafb: Unmap the frame buffer on initialization
 error
Date: Thu, 08 Apr 2010 20:55:59 +0200
Message-ID: <4BBE26BF.3000404@gmx.de>
References: <1270746946-12467-1-git-send-email-corbet@lwn.net> <1270746946-12467-4-git-send-email-corbet@lwn.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1270746946-12467-4-git-send-email-corbet@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev-devel@lists.sourceforge.net

Jonathan Corbet schrieb:
> This was part of Harald's "make viafb a first-class citizen using
> pci_driver" patch, but somehow got dropped when that patch went into
> mainline.

Well it was dropped because the patch introducing the goto_error_out 
logic wasn't backported that time because I planned to rewrite the 
framebuffer initialization to use a common function for multiple 
framebuffers.
As we now (due to your previous patches) have this logic it looks good 
to me.


Thanks,

Florian Tobias Schandinat

> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  drivers/video/via/viafbdev.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
> index 91bfe6d..4a34d4f 100644
> --- a/drivers/video/via/viafbdev.c
> +++ b/drivers/video/via/viafbdev.c
> @@ -1991,7 +1991,7 @@ static int __devinit via_pci_probe(struct pci_dev *pdev,
>  		if (!viafbinfo1) {
>  			printk(KERN_ERR
>  			"allocate the second framebuffer struct error\n");
> -			goto out_delete_i2c;
> +			goto out_unmap_screen;
>  		}
>  		viaparinfo1 = viafbinfo1->par;
>  		memcpy(viaparinfo1, viaparinfo, viafb_par_length);
> @@ -2086,6 +2086,8 @@ out_dealloc_cmap:
>  out_fb1_release:
>  	if (viafbinfo1)
>  		framebuffer_release(viafbinfo1);
> +out_unmap_screen:
> +	iounmap(viafbinfo->screen_base);
>  out_delete_i2c:
>  	viafb_delete_i2c_buss(viaparinfo);
>  out_fb_release:
