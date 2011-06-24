From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 24 Jun 2011 05:34:05 +0000
Subject: Re: [PATCH 1/5 v3] fbdev: sh_mobile_meram: Add enable/disble hooks for LCDC
Message-Id: <20110624053405.GA26414@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308728992-9660-2-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1308728992-9660-2-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Jun 22, 2011 at 04:49:48PM +0900, Damian Hobson-Garcia wrote:
> +static int sh_mobile_meram_pm_get_sync(struct sh_mobile_meram_info *pdata)
> +{
> +	if (!pdata || !pdata->pdev)
> +		return -EINVAL;
> +
> +	dev_dbg(&pdata->pdev->dev, "Enabling sh_mobile_meram clock.");
> +	pm_runtime_get_sync(&pdata->pdev->dev);
> +	return 0;
> +}
> +

On Wed, Jun 22, 2011 at 04:49:49PM +0900, Damian Hobson-Garcia wrote:
> @@ -259,6 +259,11 @@ static void sh_mobile_lcdc_clk_on(struct sh_mobile_lcdc_priv *priv)
>  		pm_runtime_get_sync(priv->dev);
>  		if (priv->dot_clk)
>  			clk_enable(priv->dot_clk);
> +		if (priv->meram_dev && priv->meram_dev->ops) {
> +			struct sh_mobile_meram_info *mdev;
> +			mdev = priv->meram_dev;
> +			mdev->ops->meram_pm_get_sync(mdev);
> +		}
>  	}
>  }
>  
I'm not sure that I really see the point in the callbacks. The callbacks
would make sense in the case where you're dealing with opaque types that
you don't wish to have knowledge of in the other drivers, but when all
you're doing is fetching the pointer and wrapping verbatim in to the
runtime pm calls, it just seems like a pointless layer of indirection.

You could easily just do this as:

	if (priv->meram_dev)
		pm_runtime_get_sync(&priv->meram_dev->pdev->dev);

and be done with it.

This will also save you from having to add additional callbacks should
you decide that you suddenly require async behaviour or so in other
cases, too.
