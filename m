From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 01 Jun 2020 10:37:00 +0000
Subject: Re: [PATCH] video: uvesafb: use true,false for bool variables
Message-Id: <4b460d82-b23c-f6ce-6593-735a726e4d8a@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200422071952eucas1p219bc9ef0a74220149966ecb03688681c@eucas1p2.samsung.com>
 <20200422071845.403-1-yanaijie@huawei.com>
In-Reply-To: <20200422071845.403-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jason Yan <yanaijie@huawei.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: spock@gentoo.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org


Hi,

On 4/22/20 9:18 AM, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> drivers/video/fbdev/uvesafb.c:48:12-17: WARNING: Assignment of 0/1 to
> bool variable
> drivers/video/fbdev/uvesafb.c:1827:3-13: WARNING: Assignment of 0/1 to
> bool variable
> drivers/video/fbdev/uvesafb.c:1829:3-13: WARNING: Assignment of 0/1 to
> bool variable
> drivers/video/fbdev/uvesafb.c:1835:3-9: WARNING: Assignment of 0/1 to
> bool variable
> drivers/video/fbdev/uvesafb.c:1837:3-9: WARNING: Assignment of 0/1 to
> bool variable
> drivers/video/fbdev/uvesafb.c:1839:3-8: WARNING: Assignment of 0/1 to
> bool variable
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/video/fbdev/uvesafb.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
> index 1b385cf76110..bee29aadc646 100644
> --- a/drivers/video/fbdev/uvesafb.c
> +++ b/drivers/video/fbdev/uvesafb.c
> @@ -45,7 +45,7 @@ static const struct fb_fix_screeninfo uvesafb_fix = {
>  };
>  
>  static int mtrr		= 3;	/* enable mtrr by default */
> -static bool blank	= 1;	/* enable blanking by default */
> +static bool blank	= true;	/* enable blanking by default */
>  static int ypan		= 1;	/* 0: scroll, 1: ypan, 2: ywrap */
>  static bool pmi_setpal	= true; /* use PMI for palette changes */
>  static bool nocrtc;		/* ignore CRTC settings */
> @@ -1824,19 +1824,19 @@ static int uvesafb_setup(char *options)
>  		else if (!strcmp(this_opt, "ywrap"))
>  			ypan = 2;
>  		else if (!strcmp(this_opt, "vgapal"))
> -			pmi_setpal = 0;
> +			pmi_setpal = false;
>  		else if (!strcmp(this_opt, "pmipal"))
> -			pmi_setpal = 1;
> +			pmi_setpal = true;
>  		else if (!strncmp(this_opt, "mtrr:", 5))
>  			mtrr = simple_strtoul(this_opt+5, NULL, 0);
>  		else if (!strcmp(this_opt, "nomtrr"))
>  			mtrr = 0;
>  		else if (!strcmp(this_opt, "nocrtc"))
> -			nocrtc = 1;
> +			nocrtc = true;
>  		else if (!strcmp(this_opt, "noedid"))
> -			noedid = 1;
> +			noedid = true;
>  		else if (!strcmp(this_opt, "noblank"))
> -			blank = 0;
> +			blank = true;

The above conversion is incorrect.

The follow-up fix is included below (the original patch has been
already applied).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] video: fbdev: uvesafb: fix "noblank" option handling

Fix the recent regression.

Fixes: dbc7ece12a38 ("video: uvesafb: use true,false for bool variables")
Cc: Jason Yan <yanaijie@huawei.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Michal Januszewski <spock@gentoo.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/uvesafb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/video/fbdev/uvesafb.c
=================================--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1836,7 +1836,7 @@ static int uvesafb_setup(char *options)
 		else if (!strcmp(this_opt, "noedid"))
 			noedid = true;
 		else if (!strcmp(this_opt, "noblank"))
-			blank = true;
+			blank = false;
 		else if (!strncmp(this_opt, "vtotal:", 7))
 			vram_total = simple_strtoul(this_opt + 7, NULL, 0);
 		else if (!strncmp(this_opt, "vremap:", 7))
