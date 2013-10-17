From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 17 Oct 2013 10:22:21 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <525FBA5D.9000001@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="km0e5VblGtXHD4uXuAvcI1tdNmpOr0L85"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com> <1381947912-11741-3-git-send-email-treding@nvidia.com> <1695169.rzbDl9PeRX@avalon> <20131017085342.GB2502@ulmo.nvidia.com>
In-Reply-To: <20131017085342.GB2502-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--km0e5VblGtXHD4uXuAvcI1tdNmpOr0L85
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17/10/13 11:53, Thierry Reding wrote:

> I keep wondering why we absolutely must have compatibility between CDF
> and this simple panel binding. DT content is supposed to concern itself=

> with the description of hardware only. What about the following isn't a=
n
> accurate description of the panel hardware?
>=20
> 	panel: panel {
> 		compatible =3D "cptt,claa101wb01";
>=20
> 		power-supply =3D <&vdd_pnl_reg>;
> 		enable-gpios =3D <&gpio 90 0>;
>=20
> 		backlight =3D <&backlight>;
> 	};
>=20
> 	dsi-controller {
> 		panel =3D <&panel>;
> 	};

That's quite similar to how my current out-of-mainline OMAP DSS DT
bindings work. The difference is that I have a reference from the panel
node to the video source (dsi-controller), instead of the other way
around. I just find it more natural. It works the same way as, say,
regulators, gpios, etc.

However, one thing unclear is where the panel node should be. You seem
to have a DSI panel here. If the panel is truly not controlled in any
way, maybe having the panel as a normal platform device is ok. But if
the DSI panel is controlled with DSI messages, should it be a child of
the dsi-controller node, the same way i2c peripherals are children of
i2c master?

>>> +static const struct drm_display_mode auo_b101aw03_mode =3D {
>>> +	.clock =3D 51450,
>>> +	.hdisplay =3D 1024,
>>> +	.hsync_start =3D 1024 + 156,
>>> +	.hsync_end =3D 1024 + 156 + 8,
>>> +	.htotal =3D 1024 + 156 + 8 + 156,
>>> +	.vdisplay =3D 600,
>>> +	.vsync_start =3D 600 + 16,
>>> +	.vsync_end =3D 600 + 16 + 6,
>>> +	.vtotal =3D 600 + 16 + 6 + 16,
>>> +	.vrefresh =3D 60,
>>> +};
>>
>> Instead of hardcoding the modes in the driver, which would then requir=
e to be=20
>> updated for every new simple panel model (and we know there are lots o=
f them),=20
>> why don't you specify the modes in the panel DT node ? The simple pane=
l driver=20
>> would then become much more generic. It would also allow board designe=
rs to=20
>> tweak h/v sync timings depending on the system requirements.
>=20
> Sigh... we keep second-guessing ourselves. Back at the time when power
> sequences were designed (and NAKed at the last minute), we all decided
> that the right thing to do would be to use specific compatible values
> for individual panels, because that would allow us to encode the power
> sequencing within the driver. And when we already have the panel model
> encoded in the compatible value, we might just as well encode the mode
> within the driver for that panel. Otherwise we'll have to keep adding
> the same mode timings for every board that uses the same panel.

Oh, I didn't feel "we all decided that the right thing..." =3D).

> I do agree though that it might be useful to tweak the mode in case the=

> default one doesn't work. How about we provide a means to override the
> mode encoded in the driver using one specified in the DT? That's
> obviously a backwards-compatible change, so it could be added if or whe=
n
> it becomes necessary.

This sounds good to me.

Although maybe it'd be good to have the driver compatible with something
like "generic-panel", so that you could have:

compatible =3D "foo,specific-panel", "generic-panel";

and if there's no need for any power/gpio setup for your board, you may
skip adding "foo,specific-panel" support to the panel driver. Later,
somebody else may need to implement fine grained power/gpio support for
"foo,specific-panel", and it would just work.

Maybe that would help us with the problem of adding support in the
driver for a hundred different simple panels each used only once on a
specific board.

 Tomi



--km0e5VblGtXHD4uXuAvcI1tdNmpOr0L85
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSX7pdAAoJEPo9qoy8lh71zQwP/jilE0u25Mh9fRY6Xcz+PZ+d
cZyx6gKx8We6VzS9vXEeg4L5lQJmNRKF361SyRuQ+gCQBYtheYgt/0mEv9WBXzMf
x3K/DJn7pLXo0D+hHGegpET2X/RwgnCDs3iA8IGCnvBwwqrpNCyasv2VfJJjDLBd
527pLtUAiq/yjn4OFU72acpJvlHHGrMbyJdNoOpifjiGoor5+iTj3OM3Vzn87/Un
2b5mPR6l/jp7ou9tMurFOFMFbm5t64kV3AIL8yDY0i4ctzYU8/E+XxiPbg9+fTUm
klLrHJtQ4LW9oyBUt6ANOBRzqxDWttb/K9SLXAfF/Nj555iaauJ7cXDRnY4IEnZ7
8QI4wFFJZx+vyH4/KalhuKKch+g5YvsD5Iwh+pczw9diwauQyC8ITjrhx2POa+0x
B0bC3f93UEDff9TZ5hBW5YM8nLYPx9le5w39YsIdWqGoOqI/hzu4PYooQ0RwE+RH
K1aX+HhD4kuH8FU5Nlotg5vk8lIkoF0HFDEbk2FXL/vj/zwMsBqeK3Ze10iGTZ3w
Yg4s4LaGFs5ZjoL8aIb+XORnxGYUNv2pwl8gtFg7CLGHhdMHJ7Bi3ohUKiNXteQe
SZeTjpdVseY2qcSrQDm/q0wNO9h8e1dV85kOmonfXZqehg4LMOU3FC7DJQu0asNO
+tiOnoOCXZ8UrxeP2w1x
=SxvT
-----END PGP SIGNATURE-----

--km0e5VblGtXHD4uXuAvcI1tdNmpOr0L85--
