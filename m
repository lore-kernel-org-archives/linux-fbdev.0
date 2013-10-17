From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 17 Oct 2013 11:50:31 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <525FCF07.6070006@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MELbcFXQD6rXXPv908W1WN1fuvGBFAJu1"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com> <1381947912-11741-3-git-send-email-treding@nvidia.com> <1695169.rzbDl9PeRX@avalon> <20131017085342.GB2502@ulmo.nvidia.com> <525FBA5D.9000001@ti.com> <20131017110517.GC10993@ulmo.nvidia.com>
In-Reply-To: <20131017110517.GC10993-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--MELbcFXQD6rXXPv908W1WN1fuvGBFAJu1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17/10/13 14:05, Thierry Reding wrote:

>> That's quite similar to how my current out-of-mainline OMAP DSS DT
>> bindings work. The difference is that I have a reference from the pane=
l
>> node to the video source (dsi-controller), instead of the other way
>> around. I just find it more natural. It works the same way as, say,
>> regulators, gpios, etc.
>=20
> I suppose that depends on the way you look at it. In the above proposal=

> I consider the output (DSI controller) to use the panel as a resource
> that provides a certain set of services (query mode timings, provide a
> way to enable or disable the panel). Similarly the panel uses the
> backlight as a resource that provides a certain set of services (such a=
s
> changing the brightness).
>=20
> The above also follows the natural order of control. The panel has no
> way to control the DSI output. However, it is the output that controls
> when a panel is required and turn it on as appropriate.

I've discussed this issue to death with other people, and for some
reason I still see this the other way =3D).

I see the panel using the DSI controller as a resource. The panel driver
uses the DSI controller to send the video data to the panel device.
Compare this to, say, i2c client driver, which uses i2c master to send
data to the i2c device.

In the OMAP DSS driver model, the panel driver is in control. The panel
driver tells the DSI controller which kind of video timings to use, or
which bus speed to use, or whether to use low-power or high-speed mode,
when to enable the DSI clock or DSI video stream, etc.

With a simple panel the model you describe works usually fine. The
reason I went with the different model is that we had rather complex
display peripherals, that needed more specific control of the bus.

A simple example could be the enable sequence. I presume in your model
the DSI controller's enable would be maybe something like:

configure_dsi_timings(panel->get_timings());
enable_dsi_output();
panel->enable();

What if the DSI peripheral requires an enable sequence of, say:

- enable DSI clock
- use LP mode
- send some config messages
- re-configure DSI clock to higher speed
- send some more config messages
- enable HS mode
- send some more config messages
- enable DSI video stream

It gets a bit difficult to manage that kind of setup in a generic way in
the DSI controller driver. As I see it, the DSI peripheral driver has to
be in control of the nuances. The same goes for other video buses also,
but DSI is perhaps one of the most complex ones to support.

 Tomi



--MELbcFXQD6rXXPv908W1WN1fuvGBFAJu1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSX88HAAoJEPo9qoy8lh71PYUP/3f/oxbd0GopjL7IWukGayrE
zcXY8+DgmTVrmfEAvnLsrc0R6Bn5kbNnhU5aszE5iIJLtxzNUV8X0RPvVVQg2O/3
4CJrMfizhRklTtwEUrjWe5DmxTAV40uNTf48Bj2uky+u/Bbk6xHCYO0JUmiqlqer
FAiwF6UDLui10BE+1RihDyVaJ77hHLHRSi8iHFZJt200DSpQNdPwKsjU9wG1MEvT
Nak4cyZp/p7qRV5MRu/XulFGMlSSWO/mcDTAwnhpBDbTYfNx/GQItKzP/IqJKw+a
ocmtouWx+2a6/KItU+DQJ+k/cIVrDihvflK6Kgh34zAijlWlum4jMKc0vJUDb76d
ghMR1yuMAbaF90fGiXo1bI7UrYrOfAFpGjav59gGu7hvq08l82laQqu9I83eNDE1
GNtB148P+gr9aoqYrczxcUU0/ZjfZV6j094XgqD3n1qiM6mXYyTo3Ldm1DW2Yz22
5gogBPsttK1A4M+nmWMDx3TF52BtIuHKT0FgzWD2FBHlpNFx8mO3IuPzcrsapEIr
o0mGJoFESSUYfchx8DwhfN321Hc3PCBQyBJi/NEWEe0d7ZayRs66GQKqZPKzu87K
5j7M6tEtqoRjf4qQQhTtYhQCoO/ycwzSzs19hXlvbJjHeTygxpKfnPbBg8Q0oMaJ
x+wb+rjdIy6jXITTTYGC
=C6qO
-----END PGP SIGNATURE-----

--MELbcFXQD6rXXPv908W1WN1fuvGBFAJu1--
