From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 02 Dec 2011 08:49:16 +0000
Subject: Re: backlight/ld9040.c: regulator control in the lcd driver
Message-Id: <CACRpkdbRdtsw-3FXtevuJL7G=tcE+1s11iRw=zou1G25hufBSA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000c01ccb0c6$697c2aa0$3c747fe0$%lee@samsung.com>
In-Reply-To: <000c01ccb0c6$697c2aa0$3c747fe0$%lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Fri, Dec 2, 2011 at 8:45 AM, leedonghwa <dh09.lee@samsung.com> wrote:

[From your mail headers]
> X-Mailer: Microsoft Office Outlook 12.0

No please. That mailer does not work, all your whitespace is screwed up.
Consult: Documentation/email-clients.txt

> This patch supports regulator power control in the driver.

Always CC the regulator maintainers on patches like this please.

> +=A0=A0=A0=A0=A0=A0=A0=A0 lcd->reg_vdd3 =3D regulator_get(lcd->dev, "vdd"=
);
> +=A0=A0=A0=A0=A0=A0=A0=A0 if (IS_ERR(lcd->reg_vdd3)) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_info(lcd->dev=
, "no %s regulator found\n", "vdd");
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 lcd->reg_vdd3 =3D=
 NULL;
> +=A0=A0=A0=A0=A0=A0=A0=A0 }
> +
> +=A0=A0=A0=A0=A0=A0=A0=A0 lcd->reg_vci =3D regulator_get(lcd->dev, "vci");
> +=A0=A0=A0=A0=A0=A0=A0=A0 if (IS_ERR(lcd->reg_vci)) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_info(lcd->dev=
, "no %s regulator found\n", "vci");
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 lcd->reg_vci =3D =
NULL;
> +=A0=A0=A0=A0=A0=A0=A0=A0 }

As explained in earlier discussion with Mark regarding the SMSC911x
driver regulator, treat these as errors and do not fail
"gracefully" like this.

Reference:
http://marc.info/?l=3Dlinux-netdev&m=131914562120725&w=3D2

Yours,
Linus Walleij
