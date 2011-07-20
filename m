From: Greg Dietsche <gregory.dietsche@cuw.edu>
Date: Wed, 20 Jul 2011 02:09:06 +0000
Subject: Re: [PATCH] video: backlight: fix const array syntax
Message-Id: <4E2638C2.1010609@cuw.edu>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1309560431-17389-1-git-send-email-Gregory.Dietsche@cuw.edu>
In-Reply-To: <1309560431-17389-1-git-send-email-Gregory.Dietsche@cuw.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org



On 07/01/2011 05:47 PM, Greg Dietsche wrote:
> Correct the syntax so that both array and pointer are const.
>
> Signed-off-by: Greg Dietsche<Gregory.Dietsche@cuw.edu>
> ---
>   drivers/video/backlight/backlight.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 80d292f..4bda2e7 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -19,7 +19,7 @@
>   #include<asm/backlight.h>
>   #endif
>
> -static const char const *backlight_types[] = {
> +static const char * const backlight_types[] = {
>   	[BACKLIGHT_RAW] = "raw",
>   	[BACKLIGHT_PLATFORM] = "platform",
>   	[BACKLIGHT_FIRMWARE] = "firmware",
>    

adding trivial@kernel.org to the cc list since this is trivial and no 
one has picked up this patch to date.

Greg

