From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 23 Nov 2011 06:53:42 +0000
Subject: Re: [PATCH] viafb: correct sync polarity for OLPC DCON
Message-Id: <4ECC9876.3030701@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20111121150557.9EB9D9D401E@zog.reactivated.net>
In-Reply-To: <20111121150557.9EB9D9D401E@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 11/21/2011 03:05 PM, Daniel Drake wrote:
> While the OLPC display appears to be able to handle either positive
> or negative sync, the Display Controller only recognises positive sync.
> 
> This brings viafb (for XO-1.5) in line with lxfb (for XO-1) and
> fixes a recent regression where the XO-1.5 DCON could no longer be
> frozen. Thanks to Florian Tobias Schandinat for helping identify
> the fix.
> 
> Test case: from a vt,
> 	echo 1 > /sys/devices/platform/dcon/freeze
> should cause the current screen contents to freeze, rather than garbage being
> displayed.
> 
> Signed-off-by: Daniel Drake <dsd@laptop.org>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/via/share.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/via/share.h b/drivers/video/via/share.h
> index 69d882c..c01c1c1 100644
> --- a/drivers/video/via/share.h
> +++ b/drivers/video/via/share.h
> @@ -559,8 +559,8 @@
>  #define M1200X720_R60_VSP       POSITIVE
>  
>  /* 1200x900@60 Sync Polarity (DCON) */
> -#define M1200X900_R60_HSP       NEGATIVE
> -#define M1200X900_R60_VSP       NEGATIVE
> +#define M1200X900_R60_HSP       POSITIVE
> +#define M1200X900_R60_VSP       POSITIVE
>  
>  /* 1280x600@60 Sync Polarity (GTF Mode) */
>  #define M1280x600_R60_HSP       NEGATIVE

