From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 01 Aug 2012 10:28:27 +0000
Subject: Re: [PATCH 1/4] video: Add support for the Solomon SSD1307 OLED Controller
Message-Id: <501904CB.9040104@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343730576-20494-1-git-send-email-maxime.ripard@free-electrons.com>
 <1343730576-20494-2-git-send-email-maxime.ripard@free-electrons.com>
 <20120801052424.GD1672@S2100-06.ap.freescale.net>
In-Reply-To: <20120801052424.GD1672@S2100-06.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Shawn,

Le 01/08/2012 07:24, Shawn Guo a =E9crit :
> On Tue, Jul 31, 2012 at 12:29:33PM +0200, Maxime Ripard wrote:
>> +Optional properties:
>> +  - oled-reset-active-low: Is the reset gpio is active on physical low?
>=20
> You may want to take a look at commit c1cb438 (bindings: update imx and
> mxs #gpio-cells) which got merged recently.  In case the driver will
> only work on mxs, this optional property can just be dropped.

Thanks for the tip.
However, I'm not sure this device will be mxs specific, since this
controller is used on some other devices as well (I know for example
that some uses it with the Arduino, even though it's not related to
Linux), so relying on mxs-specific capabilities here might not be that
great.

But since it's only for a mxs board for now, maybe we can rely on this
and add a dt parameter if we need it in the future. I don't know, both
make sense I guess.

Maxime

--=20
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
