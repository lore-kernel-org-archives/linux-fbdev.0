From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 25 Sep 2013 09:30:31 +0000
Subject: Re: [patch 1/2] backlight: lm3630: signedness bug in lm3630a_chip_init()
Message-Id: <002301ceb9d1$e0e3ec20$a2abc460$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130925085451.GA6661@elgon.mountain>
In-Reply-To: <20130925085451.GA6661@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wednesday, September 25, 2013 5:55 PM, Dan Carpenter wrote:
> 
> "rval" needs to be signed for the error handling to work.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

CC'ed Andrew Morton, Daniel Jeong,

Acked-by: Jingoo Han <jg1.han@samsung.com>

> 
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> index c63f918..65392f9 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -105,7 +105,7 @@ static int lm3630a_chip_init(struct lm3630a_chip *pchip)
>  /* interrupt handling */
>  static void lm3630a_delayed_func(struct work_struct *work)
>  {
> -	unsigned int rval;
> +	int rval;
>  	struct lm3630a_chip *pchip;
> 
>  	pchip = container_of(work, struct lm3630a_chip, work.work);

