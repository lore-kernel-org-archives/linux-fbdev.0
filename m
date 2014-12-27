From: Jingoo Han <jg1.han@samsung.com>
Date: Sat, 27 Dec 2014 01:29:23 +0000
Subject: Re: [patch] fbdev: off by one test (harmless)
Message-Id: <000101d02174$8bcee760$a36cb620$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20141226172657.GA14762@mwanda>
In-Reply-To: <20141226172657.GA14762@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Saturday, December 27, 2014 2:27 AM, Dan Carpenter wrote:
> 
> ARRAY_SIZE(cea_modes) is 64 so the "idx > 63" test earlier means this

Good.
'cea_modes' is defined as below. So, ARRAY_SIZE(cea_modes) is 64.
extern const struct fb_videomode cea_modes[64];

> test is really a no-op.  But it's still off by one and upsets the static
> checkers so we may as well correct it.

'idx' should be 0~63, because cea_modes array is defined as 'cea_modes[64]'.

> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> 
> diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
> index 5b0e313..3030269 100644
> --- a/drivers/video/fbdev/core/fbmon.c
> +++ b/drivers/video/fbdev/core/fbmon.c
> @@ -1061,7 +1061,7 @@ void fb_edid_add_monspecs(unsigned char *edid, struct fb_monspecs *specs)
>  		int idx = svd[i - specs->modedb_len - num];
>  		if (!idx || idx > 63) {
>  			pr_warning("Reserved SVD code %d\n", idx);
> -		} else if (idx > ARRAY_SIZE(cea_modes) || !cea_modes[idx].xres) {
> +		} else if (idx >= ARRAY_SIZE(cea_modes) || !cea_modes[idx].xres) {
>  			pr_warning("Unimplemented SVD code %d\n", idx);
>  		} else {
>  			memcpy(&m[i], cea_modes + idx, sizeof(m[i]));

