From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 26 Aug 2015 11:58:56 +0000
Subject: Re: [PATCH v2] pwm-backlight: Avoid backlight flicker when probed from DT
Message-Id: <20150826115856.GY19409@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438276973-20920-1-git-send-email-p.zabel@pengutronix.de>
 <1440580842.3190.26.camel@pengutronix.de>
In-Reply-To: <1440580842.3190.26.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Ajay Kumar <ajaykumar.rs@samsung.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de

On Wed, 26 Aug 2015, Philipp Zabel wrote:

> Hi Thierry, Jingoo, Lee,
>=20
> Am Donnerstag, den 30.07.2015, 19:22 +0200 schrieb Philipp Zabel:
> > If the driver is probed from the device tree, and there is a phandle
> > property set on it, and the enable GPIO is already configured as output,
> > and the backlight is currently disabled, keep it disabled.
> > If all these conditions are met, assume there will be some other driver
> > that can enable the backlight at the appropriate time.
>=20
> do you have any comments on this?
>=20
> This patch fixes premature backlight illumination issues for DT probed
> devices with enable gpio or regulator without changing the behavior of
> the non-DT case or DT cases where the enable gpio and regulator are kept
> initially enabled or where no other device node points to the backlight
> via phandle.

I need Thierry's review to move forward on this.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
