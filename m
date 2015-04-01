From: Rob Herring <robherring2@gmail.com>
Date: Wed, 01 Apr 2015 20:33:16 +0000
Subject: Re: [PATCHv6 03/10] of: Add Solomon Systech vendor prefix.
Message-Id: <CAL_Jsq+OTsvLkOn1oR_JYnb=UdyW3LFQ5wwqFU0-L6J_f1gi7Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1427826436-21783-1-git-send-email-niederp@physik.uni-kl.de> <1427826436-21783-4-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1427826436-21783-4-git-send-email-niederp@physik.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Thomas_Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Rob Herring <robh+dt@kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Mar 31, 2015 at 1:27 PM, Thomas Niederprüm
<niederp@physik.uni-kl.de> wrote:
> This patch adds the solomon prefix for Solomon Systech Limited.
>
> Signed-off-by: Thomas Niederprüm <niederp@physik.uni-kl.de>

In the future, please copy devicetree list.

Acked-by: Rob Herring <robh@kernel.org>


> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index d3f4809..933c8f5 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -169,6 +169,7 @@ sitronix    Sitronix Technology Corporation
>  smsc   Standard Microsystems Corporation
>  snps   Synopsys, Inc.
>  solidrun       SolidRun
> +solomon        Solomon Systech Limited
>  sony   Sony Corporation
>  spansion       Spansion Inc.
>  sprd   Spreadtrum Communications Inc.
> --
> 2.3.0
>
