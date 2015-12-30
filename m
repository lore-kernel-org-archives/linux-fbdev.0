From: Michael Turquette <mturquette@baylibre.com>
Date: Wed, 30 Dec 2015 21:05:11 +0000
Subject: Re: [PATCH v4 14/24] clk: pwm: use pwm_get/set_default_xxx() helpers where appropriate
Message-Id: <20151230210511.19557.73321@quark.deferred.io>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
 <1447664207-24370-15-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1447664207-24370-15-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Boris,

Quoting Boris Brezillon (2015-11-16 00:56:37)
> pwm_set/get_default_xxx() helpers have been introduced to differentiate
> the default PWM states (those retrieved through DT, PWM lookup table or
> statically assigned by the driver) and the current ones.
> Make use of those helpers where appropriate.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/clk/clk-pwm.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
> index b6306a2..642a49a 100644
> --- a/drivers/clk/clk-pwm.c
> +++ b/drivers/clk/clk-pwm.c
> @@ -71,23 +71,23 @@ static int clk_pwm_probe(struct platform_device *pdev)
>         if (IS_ERR(pwm))
>                 return PTR_ERR(pwm);
>  
> -       if (!pwm_get_period((pwm))) {
> +       if (!pwm_get_default_period((pwm))) {

The change itself looks fine, but the semantic patch added extra parens.
Can you remove them? After doing so feel free to add:

Acked-by: Michael Turquette <mturquette@baylibre.com>
