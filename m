From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 31 Jul 2012 12:02:04 +0000
Subject: Re: [PATCH 2/4] ARM: dts: mxs: Add alternative I2C muxing options for imx28
Message-Id: <CAOMZO5AaLB5m7TYPC03wTSFTDUTFrtV4Xr6gHrvKuGnpyUsf8Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343730576-20494-1-git-send-email-maxime.ripard@free-electrons.com>
 <1343730576-20494-3-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1343730576-20494-3-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jul 31, 2012 at 7:29 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> +                               i2c0_pins_b: i2c0@1 {
> +                                       reg = <1>;
> +                                       fsl,pinmux-ids = <0x3001 0x3011>;

Can you please also list the name of the pin as comment (just like you
did for pwm4)?

This would allow us to quickly identify the muxing option without the
need of looking at the mxs pinctrl doc.

Regards,

Fabio Estevam
