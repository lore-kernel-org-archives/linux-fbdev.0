From: Ondrej Zary <linux@rainbow-software.org>
Date: Mon, 20 Feb 2012 20:49:47 +0000
Subject: Re: [PATCH] i740fb: fix compile error when CONFIG_MTRR is not selected
Message-Id: <201202202149.52869.linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120216162900.e2dd164732084f48e5b239f0@canb.auug.org.au> <1329687211-6545-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1329687211-6545-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org

On Sunday 19 February 2012 22:33:31 Florian Tobias Schandinat wrote:
> Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> ---
>  drivers/video/i740fb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/video/i740fb.c b/drivers/video/i740fb.c
> index 8be0302..fe574d8 100644
> --- a/drivers/video/i740fb.c
> +++ b/drivers/video/i740fb.c
> @@ -1179,9 +1179,9 @@ static void __devexit i740fb_remove(struct pci_dev
> *dev) struct fb_info *info = pci_get_drvdata(dev);
>
>  	if (info) {
> -#ifdef CONFIG_MTRR
>  		struct i740fb_par *par = info->par;
>
> +#ifdef CONFIG_MTRR
>  		if (par->mtrr_reg >= 0) {
>  			mtrr_del(par->mtrr_reg, 0, 0);
>  			par->mtrr_reg = -1;

Thanks for fixing my stupid bug. I thought that I tested it without 
CONFIG_MTRR. But obviously didn't.

-- 
Ondrej Zary
