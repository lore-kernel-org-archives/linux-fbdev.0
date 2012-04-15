From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 15 Apr 2012 21:49:48 +0000
Subject: Re: [PATCH] skeletonfb: fixed module exit function typo.
Message-Id: <4F8B427C.6000603@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

[Cc'ing linux-fbdev@vger.kernel.org]

You should always send patches also to the relevant mailing list.

On 04/12/2012 07:26 PM, Alexander Guy wrote:
> From 915c83ad50fe381661d8eebd6280a275d8dd6ac9 Mon Sep 17 00:00:00 2001
> From: Alexander Guy <alexander.guy@guy-engineering.com>
> Date: Thu, 12 Apr 2012 11:59:36 -0700
> Subject: [PATCH] skeletonfb: fixed module exit function typo.
> 
> 
> Signed-off-by: Alexander Guy <alexander.guy@guy-engineering.com>
> ---
>  drivers/video/skeletonfb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/skeletonfb.c b/drivers/video/skeletonfb.c
> index 30f7a81..5b6abc6 100644
> --- a/drivers/video/skeletonfb.c
> +++ b/drivers/video/skeletonfb.c
> @@ -1036,6 +1036,6 @@ static void __exit xxxfb_exit(void)
>       */
> 
>  module_init(xxxfb_init);
> -module_exit(xxxfb_remove);
> +module_exit(xxxfb_exit);
> 
>  MODULE_LICENSE("GPL");
> --
> 1.7.9.5

Looks correct to me, applied.


Thanks,

Florian Tobias Schandinat
