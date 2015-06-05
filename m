From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 05 Jun 2015 20:08:37 +0000
Subject: Re: [PATCH -next] fbdev: radeon: Avoid 64 bit divide
Message-Id: <1433534917.4526.105.camel@kernel.crashing.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1433527521-5384-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1433527521-5384-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Tina Ruchandani <ruchandani.tina@gmail.com>

On Fri, 2015-06-05 at 11:05 -0700, Guenter Roeck wrote:
> A 64 bit divide causes build failures with 32 bit builds, such as
> 
> ERROR: "__divdi3" [drivers/video/fbdev/aty/radeonfb.ko] undefined!
> 
> or
> 
> drivers/built-in.o: In function `radeon_probe_pll_params':
> radeon_base.c:(.text+0x16608b): undefined reference to `__divdi3'

What about using do_div() instead ?

> Fixes: ce8f4069dce8 ("fbdev: radeon: Remove 'struct timeval' usage")
> Cc: Tina Ruchandani <ruchandani.tina@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/video/fbdev/aty/radeon_base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
> index b3612e30d74f..374e47532035 100644
> --- a/drivers/video/fbdev/aty/radeon_base.c
> +++ b/drivers/video/fbdev/aty/radeon_base.c
> @@ -492,7 +492,7 @@ static int radeon_probe_pll_params(struct radeonfb_info *rinfo)
>  	/* Return -1 if more than 10 seconds have elapsed */
>  	if (delta > (10*1000000))
>  		return -1;
> -	hz = 1000000/delta;
> +	hz = 1000000 / (int)delta;
>  
>  	hTotal = ((INREG(CRTC_H_TOTAL_DISP) & 0x1ff) + 1) * 8;
>  	vTotal = ((INREG(CRTC_V_TOTAL_DISP) & 0x3ff) + 1);


