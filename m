From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 12 Sep 2017 13:12:04 +0000
Subject: Re: [PATCH] backlight: s6e63m0: make const arrays static, reduces object code size
Message-Id: <5f9c04a8-8162-8ddd-caf2-e734a14a2ee3@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170912114545.2131-1-colin.king@canonical.com>
In-Reply-To: <20170912114545.2131-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Colin King <colin.king@canonical.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/09/17 12:45, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate const arrays on the stack, instead make them
> static.  Makes the object code smaller by nearly 400 bytes:
> 
> Before:
>     text	   data	    bss	    dec	    hex	filename
>    15164	   6336	      0	  21500	   53fc	drivers/video/backlight/s6e63m0.o
> 
> After:
>     text	   data	    bss	    dec	    hex	filename
>    14669	   6432	      0	  21101	   526d	drivers/video/backlight/s6e63m0.o

For future records, can you record the compiler version, architecture 
and optimization level (-O2 or -Os) to the patch header?


> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/video/backlight/s6e63m0.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/s6e63m0.c b/drivers/video/backlight/s6e63m0.c
> index 3c4a22a3063a..965c660b2f6b 100644
> --- a/drivers/video/backlight/s6e63m0.c
> +++ b/drivers/video/backlight/s6e63m0.c
> @@ -446,7 +446,7 @@ static int s6e63m0_gamma_ctl(struct s6e63m0 *lcd, int gamma)
>   static int s6e63m0_ldi_init(struct s6e63m0 *lcd)
>   {
>   	int ret, i;
> -	const unsigned short *init_seq[] = {
> +	static const unsigned short *init_seq[] = {

I'd be inclined to throw in an extra const to help the compile spot any 
negligent maintenance in the future:

static const unsigned short * const init_seq[];


>   		seq_panel_condition_set,
>   		seq_display_condition_set,
>   		seq_gamma_setting,
> @@ -467,7 +467,7 @@ static int s6e63m0_ldi_init(struct s6e63m0 *lcd)
>   static int s6e63m0_ldi_enable(struct s6e63m0 *lcd)
>   {
>   	int ret = 0, i;
> -	const unsigned short *enable_seq[] = {
> +	static const unsigned short *enable_seq[] = {
>   		seq_stand_by_off,
>   		seq_display_on,
>   	};
> 

