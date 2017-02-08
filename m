From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 08 Feb 2017 14:47:38 +0000
Subject: Re: [PATCH] video: fbdev: offb: switch to using for_each_node_by_type
Message-Id: <1492127.1iJfys0tjB@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170131182541epcas1p402e498825d87444fda8a718daaa59374@epcas1p4.samsung.com>
 <20170131182536.GA30076@dtor-ws>
In-Reply-To: <20170131182536.GA30076@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Yongji Xie <xyjxie@linux.vnet.ibm.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Tuesday, January 31, 2017 10:25:36 AM Dmitry Torokhov wrote:
> Instead of open-coding loops let's switch to a nice macro.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Patch queued for 4.11, thanks.

> ---
>  drivers/video/fbdev/offb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
> index 906c6e75c260..9be884b0c778 100644
> --- a/drivers/video/fbdev/offb.c
> +++ b/drivers/video/fbdev/offb.c
> @@ -668,14 +668,14 @@ static int __init offb_init(void)
>  		offb_init_nodriver(of_chosen, 1);
>  	}
>  
> -	for (dp = NULL; (dp = of_find_node_by_type(dp, "display"));) {
> +	for_each_node_by_type(dp, "display") {
>  		if (of_get_property(dp, "linux,opened", NULL) &&
>  		    of_get_property(dp, "linux,boot-display", NULL)) {
>  			boot_disp = dp;
>  			offb_init_nodriver(dp, 0);
>  		}
>  	}
> -	for (dp = NULL; (dp = of_find_node_by_type(dp, "display"));) {
> +	for_each_node_by_type(dp, "display") {
>  		if (of_get_property(dp, "linux,opened", NULL) &&
>  		    dp != boot_disp)
>  			offb_init_nodriver(dp, 0);

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

