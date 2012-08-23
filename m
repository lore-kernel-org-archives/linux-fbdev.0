From: Shawn Guo <shawn.guo@linaro.org>
Date: Thu, 23 Aug 2012 14:33:48 +0000
Subject: Re: [PATCH 2/4] ARM: dts: mxs: Add alternative I2C muxing options for imx28
Message-Id: <20120823143344.GJ24242@S2101-09.ap.freescale.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345711351-16367-1-git-send-email-maxime.ripard@free-electrons.com>
 <1345711351-16367-3-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1345711351-16367-3-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Aug 23, 2012 at 10:42:29AM +0200, Maxime Ripard wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Brian Lilly <brian@crystalfontz.com>
> ---
>  arch/arm/boot/dts/imx28.dtsi |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 787efac..f6ffcd9 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -410,6 +410,17 @@
>  					fsl,pull-up = <1>;
>  				};
>  
> +				i2c0_pins_b: i2c0@1 {
> +					reg = <1>;
> +					fsl,pinmux-ids = <
> +						0x3001 /* MX28_PAD_AUART0_RX__DUART_CTS */
> +						0x3011 /* MX28_PAD_AUART0_TX__DUART_RTS */

The comments are wrong.  I fixed them as below and applied the patch.

						0x3001 /* MX28_PAD_AUART0_RX__I2C0_SCL */
						0x3011 /* MX28_PAD_AUART0_TX__I2C0_SDA */

Regards,
Shawn


> +					>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};
> +
>  				saif0_pins_a: saif0@0 {
>  					reg = <0>;
>  					fsl,pinmux-ids = <
> -- 
> 1.7.9.5
> 
