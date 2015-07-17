From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Fri, 17 Jul 2015 05:34:59 +0000
Subject: Re: [PATCH] coding style: Fix 1 error and 5 warnings
Message-Id: <20150717052258.GC3422@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437062154-29181-1-git-send-email-antoine.blin@lip6.fr>
In-Reply-To: <1437062154-29181-1-git-send-email-antoine.blin@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Jul 16, 2015 at 05:55:54PM +0200, antoine wrote:
> This is a patch to the ddk750_power.c file that fixes up five "line over 80
> characters" warnings and one "return is not a function, parentheses are not
> required" error found by the checkpatch.pl script.
That becomes two different change. Please only do one type of change in
one patch.
> 
> Signed-off-by: Antoine BLIN <antoine.blin@lip6.fr>
Your Signed-off-by name should match your email From: header. Please
make the required changed in your .gitconfig file.
> ---
>  drivers/staging/sm750fb/ddk750_power.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
> index c8c51be..42961ea 100644
> --- a/drivers/staging/sm750fb/ddk750_power.c
> +++ b/drivers/staging/sm750fb/ddk750_power.c
> @@ -8,7 +8,8 @@ void ddk750_setDPMS(DPMS_t state)
>  
>  	if (getChipType() = SM750LE) {
>  		value = PEEK32(CRT_DISPLAY_CTRL);
> -		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(value, CRT_DISPLAY_CTRL, DPMS, state));
> +		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(value, CRT_DISPLAY_CTRL,
> +		DPMS, state));
Check your patch with --strict option of checkpatch and it will say
"alignment not matching"

regards
sudip
