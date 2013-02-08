From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 08 Feb 2013 14:02:03 +0000
Subject: Re: [RFC PATCH 0/4] Common Display Framework-TF
Message-Id: <5115055B.2080509@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enigBF4FACC97D8B78BA51265506"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359560343-31636-1-git-send-email-t.figa@samsung.com> <4292748.rtElrP8BXd@avalon> <3272191.03RiBNfhoM@flatron> <5114E412.5030806@ti.com> <5114F224.6010201@stericsson.com> <5114F7C9.4040803@ti.com> <5114FD86.2020400@stericsson.com>
In-Reply-To: <5114FD86.2020400@stericsson.com>
To: Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomasz Figa <t.figa@samsung.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, Daniel Vetter <daniel@ffwll.ch>, "rob@ti.com" <rob@ti.com>, Vikas Sajjan <vikas.sajjan@linaro.org>, "inki.dae@samsung.com" <inki.dae@samsung.com>, "dh09.lee@samsung.com" <dh09.lee@samsung.com>, "ville.syrjala@intel.com" <ville.syrjala@intel.com>, "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>

--------------enigBF4FACC97D8B78BA51265506
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-02-08 15:28, Marcus Lorentzon wrote:

> When we do that we stop->setup->start during blanking. So our "DSS" is
> optimized to be able to do that without getting blocked. All DSI video
> mode panels (and DPI) products we have done so far have not had any
> issue with that (as long as DSI HS clock is set to continuous). I think=

> this approach is less platform dependant, as long as there is no SoC
> that take more than a blanking period to reconfigure.

So do you stop, setup and start the link with CPU, and this has to be
happen during blanking? Isn't that prone to errors? Or did you mean that
the hardware handles that automatically?

In OMAP DSS there are so called shadow registers, that can be programmed
at any time. The you set a bit (GO bit), which tells the hardware to
take the new settings into use at the next vblank.

=46rom DSI driver's perspective the link is never stopped when
reconfiguring the video timings. However, many other settings have to be
configured when the link is disabled.

>>>> In OMAP you can configure the DSI pins quite freely. We have the
>>>> following struct:
>>>>
>>>> struct omap_dsi_pin_config {
>>>>      int num_pins;
>>>>      /*
>>>>       * pin numbers in the following order:
>>>>       * clk+, clk-
>>>>       * data1+, data1-
>>>>       * data2+, data2-
>>>>       * ...
>>>>       */
>>>>      int pins[OMAP_DSS_MAX_DSI_PINS];
>>>> };
>>>>

> I think it still is OMAP specifics and doesn't belong in the panel
> drivers any longer. If you revisit this requirement in the CDF context
> where DSI ifc parameters should describe how to interface with a panel
> outside the SoC, there can't really be any dependencies on SoC internal=

> routing. As you say, this is inside pinmux, so how can that affect the
> SoC external interface? I would suggest moving this to dispc-dsilink DT=

> settings that are activated on dsilink->enable/disable. At least that i=
s
> how I plan to solve similar STE SoC specific DSI config settings that
> are not really CDF panel generic, like some DPhy trim settings. They do=

> depend on the panel and clock speed, but they are more product specific=

> than panel driver specific. Then if there are these type of settings
> that every SoC have, then we could look at standardize those. But for
> starters I would try to keep it in product/board-DT per DSI link. So we=

> should try to differentiate between DSI host and slave bus params and
> keep slave params in panel driver.

Ok, I think I was being a bit vague here. I explained the OMAP DSI
routing not because I meant that this API is specific to that, but
because it explains why this kind of routing info is needed, and a
bitmask is not enough.

If you look at the omap_dsi_pin_config struct, there's nothing OMAP
specific there (except the names =3D). All it tells is that this device
uses N DSI pins, and the device's clk+ function should be connected to
pin X on the DSI master, clk- should be connected to pin Y, etc. X and Y
are integers, and what they mean is specific to the DSI master.

When the DSI master is OMAP's DSI, the OMAP DSI driver does the pin
configuration as I explained. When the DSI master is something else,
say, a DSI bridge, it does whatever it needs to do (which could be
nothing) to assign a particular DSI function to a pin.

 Tomi



--------------enigBF4FACC97D8B78BA51265506
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRFQVbAAoJEPo9qoy8lh71J5oP/jBhZJqL49v1gzzKr9XtBLLG
GkXoO7OzAONJ65Y0Ow8M4inZ9fZ65YFOIk/e3eKD9jnXbu6Fi/83QsH/8n2PrXtH
1k/gCNqba+q5yqKhJ3P0CG1SxwmVxFgIq1O18ni24h5jc1qi5KndZw7ojGfAp7+d
n/L/OZF7LBeQG8kzfP2MNR2svmndwjcP/1UTtbXR1qFCOqn/+r0vOncpwiCCnvTK
Of/zNgnTnkzxd4ITkqObA7M09jbTh98v1QO9MQEewcWnBRVtlSSgd823oH7ZdM1T
47kMTO9YwdcaDOcWLyroOW8t0Ghgg+KrQMUn/m2WS/TZlHYz5eWZbq6etgsb4BhH
6D7RrVA/+49FJlJ+I08mOkt+4sO7+qO88By+3my/oqXJZsTU40LFRguo+ukbCC1F
Xzn2MtGKbvIwNTmnH6OMWEG5cnaSKoQ6PdzIWtdQrBpS29+/hDo1aKtnXigV5ldP
lLPxzbPOf/PjQvcNQ+40rutyXfxY1LRADYsBtZHRv3262PKWV4f27G9BGt0CaCbw
y0jEvppnwobdeDVZgzlTtciZ/w4a7fHQUMHe5d6ZqIN5UTdmjCAWLpW/pUd7Cm9d
6veMj8mm2IVH/rKQ9VHIleVbJAtDkXQ4lH+k6RU20LLvRpI3NI3Byebj/dBkvI1d
Vyui7bJpeqIrBLIEn4dt
=05Jr
-----END PGP SIGNATURE-----

--------------enigBF4FACC97D8B78BA51265506--
