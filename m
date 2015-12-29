From: Rob Herring <robh@kernel.org>
Date: Tue, 29 Dec 2015 20:54:58 +0000
Subject: Re: [PATCH v2 1/3] devicetree/bindings: add reset-gpios and vcc-supply for panel-dpi
Message-Id: <20151229205458.GA31241@rob-hp-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1450610002-10531-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1450610002-10531-2-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1450610002-10531-2-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sun, Dec 20, 2015 at 12:13:20PM +0100, Uwe Kleine-K=F6nig wrote:
> Some displays have a reset input and/or need a regulator to function
> properly. Allow to specify them for panel-dpi devices.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/display/panel/panel-dpi.txt | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-dpi.tx=
t b/Documentation/devicetree/bindings/display/panel/panel-dpi.txt
> index 216c894d4f99..b52ac52757df 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-dpi.txt
> +++ b/Documentation/devicetree/bindings/display/panel/panel-dpi.txt
> @@ -7,6 +7,8 @@ Required properties:
>  Optional properties:
>  - label: a symbolic name for the panel
>  - enable-gpios: panel enable gpio
> +- reset-gpios: GPIO to control the RESET pin

The problem with this in a generic binding is what if the panel has=20
ordering requirements like enable gpio has to be inactive when reset=20
is deasserted?

> +- vcc-supply: phandle of regulator that will be used to enable power to =
the display

What if there are 2 supplies?

While there are limits to what can be described here, I'm okay with=20
allowing these, so:

Acked-by: Rob Herring <robh@kernel.org>

Rob
