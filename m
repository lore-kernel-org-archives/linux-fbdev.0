From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 02 Aug 2012 13:35:22 +0000
Subject: Re: [PATCH 1/4] video: Add support for the Solomon SSD1307 OLED Controller
Message-Id: <501A821A.2060209@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343730576-20494-1-git-send-email-maxime.ripard@free-electrons.com>
 <1343730576-20494-2-git-send-email-maxime.ripard@free-electrons.com>
 <20120801052424.GD1672@S2100-06.ap.freescale.net>
 <501904CB.9040104@free-electrons.com>
 <20120802003422.GA2253@S2101-09.ap.freescale.net>
In-Reply-To: <20120802003422.GA2253@S2101-09.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Le 02/08/2012 02:34, Shawn Guo a =E9crit :
> On Wed, Aug 01, 2012 at 12:28:27PM +0200, Maxime Ripard wrote:
>> Thanks for the tip.
>> However, I'm not sure this device will be mxs specific, since this
>> controller is used on some other devices as well (I know for example
>> that some uses it with the Arduino, even though it's not related to
>> Linux), so relying on mxs-specific capabilities here might not be that
>> great.
>>
> Ok, agreed.  In that case, putting "1" in last cell of oled-reset-gpio
> does not make any point then.
>=20
> +Examples:
> +ssd1307: oled@3c {
> +        compatible =3D "solomon,ssd1307fb-i2c";
> +        reg =3D <0x3c>;
> +        pwms =3D <&pwm 4 3000>;
> +        oled-reset-gpio =3D <&gpio2 7 1>;
> +        oled-reset-active-low;
> +};
>=20
Ok, I will do that then.

Maxime

--=20
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
