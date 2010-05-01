From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 01 May 2010 15:02:30 +0000
Subject: Re: [PATCH 12/30] viafb: Move core stuff into via-core.c
Message-Id: <4BDC4286.4070703@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272493051-25380-1-git-send-email-corbet@lwn.net> <1272493051-25380-13-git-send-email-corbet@lwn.net>
In-Reply-To: <1272493051-25380-13-git-send-email-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn

Jonathan Corbet schrieb:
> The first step toward turning viafb into a multifunction driver.  This
> patch creates a new via-core.c file which serves as the main PCI driver;
> everything else comes below that.  Some work has been done to rationalize
> the i2c drivers in this new scheme.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---

> -obj-$(CONFIG_FB_VIA) += viafb.o
> +obj-$(CONFIG_FB_VIA) += viafb.o 

Huh? (the space is not really a problem)

>  struct fb_info *viafbinfo;
> +EXPORT_SYMBOL_GPL(viafbinfo);
>  struct fb_info *viafbinfo1;
>  struct viafb_par *viaparinfo;
> +EXPORT_SYMBOL_GPL(viaparinfo);
>  struct viafb_par *viaparinfo1;

Ugh, I really hope you introduce those only as temporary exports until 
the split is finished. It's ugly enough that viafb uses these internally 
as global variables which will vanish in some time but for a 
multifunction driver having those sounds even more ridiculous. If we 
agree that it's only a temporary solution I'll take this bitter pill.

> @@ -1764,6 +1765,7 @@ static int __devinit via_pci_probe(struct pci_dev *pdev,
>  		&viaparinfo->shared->lvds_setting_info2;
>  	viaparinfo->crt_setting_info = &viaparinfo->shared->crt_setting_info;
>  	viaparinfo->chip_info = &viaparinfo->shared->chip_info;
> +	spin_lock_init(&viaparinfo->reg_lock);

I think the initialization of the lock that is made for synchronization 
of hardware access should be in the via-core.c you just introduce. (and 
  the lock itself in a structure or something outside the framebuffer 
flow). Just saw that you did so in your next patch, so there is no 
reason to needlessly introduce the spinlock now.


Thanks,

Florian Tobias Schandinat
