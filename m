From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [Linux-fbdev-devel] [PATCH] viafb: Use sizeof struct rather	than
 pointer
Date: Sun, 22 Nov 2009 00:59:06 +0100
Message-ID: <4B087ECA.1070109@gmx.de>
References: <4B0838F1.4090202@gmail.com> <4B083957.3040500@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753984AbZKUX7H@vger.kernel.org>
In-Reply-To: <4B083957.3040500@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Roel Kluin <roel.kluin@gmail.com>
Cc: Joseph Chan <JosephChan@via.com.tw>, Andrew Morton <akpm@linux-foundation.org>, Scott Fang <ScottFang@viatech.com.cn>, linux-fbdev-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

Hi,

Roel Kluin schrieb:
> diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
> index 56ec696..7b181e7 100644
> --- a/drivers/video/via/viafbdev.c
> +++ b/drivers/video/via/viafbdev.c
> @@ -680,7 +680,7 @@ static int viafb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
>  		if (!viafb_gamma_table)
>  			return -ENOMEM;
>  		if (copy_from_user(viafb_gamma_table, argp,
> -				sizeof(viafb_gamma_table))) {
> +				sizeof(*viafb_gamma_table))) {
>  			kfree(viafb_gamma_table);
>  			return -EFAULT;
>  		}
> @@ -694,7 +694,7 @@ static int viafb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
>  			return -ENOMEM;
>  		viafb_get_gamma_table(viafb_gamma_table);
>  		if (copy_to_user(argp, viafb_gamma_table,
> -			sizeof(viafb_gamma_table))) {
> +			sizeof(*viafb_gamma_table))) {
>  			kfree(viafb_gamma_table);
>  			return -EFAULT;
>  		}

I'm sorry but I fear your fix isn't correct. The reason is a few lines 
above:

u32 *viafb_gamma_table;
...
viafb_gamma_table = kmalloc(256 * sizeof(u32), GFP_KERNEL);

so probably the right solution would look like this:

copy_from_user(viafb_gamma_table, argp, 256 * sizeof(u32))
copy_to_user(argp, viafb_gamma_table, 256 * sizeof(u32))

However viafb has way too many private ioctls. I would be curious 
whether there exists any program that uses any of them so that they 
could be tested. As this ioctl didn't work very well I vote to remove it 
at least temporarily.

Thanks for highlighting this problem,


Florian Tobias Schandinat
