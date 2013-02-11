From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 11 Feb 2013 08:21:20 +0000
Subject: Re: [RFC PATCH 0/4] Common Display Framework-TF
Message-Id: <5118AA00.2000505@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig865B519E65BD0F11BA97861F"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359560343-31636-1-git-send-email-t.figa@samsung.com> <4292748.rtElrP8BXd@avalon> <3272191.03RiBNfhoM@flatron> <5114E412.5030806@ti.com> <5114F224.6010201@stericsson.com> <5114F7C9.4040803@ti.com> <5114FD86.2020400@stericsson.com> <5115055B.2080509@ti.com> <511511B3.3060404@stericsson.com>
In-Reply-To: <511511B3.3060404@stericsson.com>
To: Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomasz Figa <t.figa@samsung.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, Daniel Vetter <daniel@ffwll.ch>, Vikas Sajjan <vikas.sajjan@linaro.org>, "inki.dae@samsung.com" <inki.dae@samsung.com>, "dh09.lee@samsung.com" <dh09.lee@samsung.com>, "ville.syrjala@intel.com" <ville.syrjala@intel.com>, "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>

--------------enig865B519E65BD0F11BA97861F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-02-08 16:54, Marcus Lorentzon wrote:
> On 02/08/2013 03:02 PM, Tomi Valkeinen wrote:
>> On 2013-02-08 15:28, Marcus Lorentzon wrote:
>>
>>> When we do that we stop->setup->start during blanking. So our "DSS" i=
s
>>> optimized to be able to do that without getting blocked. All DSI vide=
o
>>> mode panels (and DPI) products we have done so far have not had any
>>> issue with that (as long as DSI HS clock is set to continuous). I thi=
nk
>>> this approach is less platform dependant, as long as there is no SoC
>>> that take more than a blanking period to reconfigure.
>> So do you stop, setup and start the link with CPU, and this has to be
>> happen during blanking? Isn't that prone to errors? Or did you mean th=
at
>> the hardware handles that automatically?
>>
>> In OMAP DSS there are so called shadow registers, that can be programm=
ed
>> at any time. The you set a bit (GO bit), which tells the hardware to
>> take the new settings into use at the next vblank.
>>
>>  From DSI driver's perspective the link is never stopped when
>> reconfiguring the video timings. However, many other settings have to =
be
>> configured when the link is disabled.
>=20
> Yeah, you lucky guys with the GO bit ;). No, we actually do CPU
> stop,setup,start. But since it is video mode, master is driving the syn=
c
> so it is not a hard deadline. It is enough to restart before pixels
> start to degrade. On an LCD that is not so much time, but on an OLED it=

> could be 10 secs :). Anyway, we have had several mass products with thi=
s
> soft solution and it has worked well.

Ah, ok. But in that case what you said in an earlier mail is not quite
correct: "I think this approach is less platform dependant, as long as
there is no SoC that take more than a blanking period to reconfigure.".
So in your approach the reconfiguration doesn't have to be done inside
the blanking period, but before the panel's picture starts to fade?

I don't know... It's early Monday morning, and not enough coffee yet,
but I get a bit uneasy feeling if I think that your method of
reconfiguring would be the only think allowed by the CDF API.

Some SoCs do support reconfiguring on the fly, without disabling the
link. It would not be nice if we didn't allow this to happen. And
actually, we're not only talking about SoCs here, but also any display
devices, like external buffer chips etc. They may also offer means to
change configs on the fly.

Well, I don't have any hard point about this at the moment, but I think
we should think different approaches how the configuration can be done.

> I understand, but removing the omap prefix doesn't mean it has to go in=

> the panel slave port/bus settings. I still can't see why this should be=

> configuration on the panel driver and not the DSI master driver. Number=

> of pins might be useful since you might start with one lane and then
> activate the rest. But partial muxing (pre pinmux) doesn't seem to be
> something the panel should control or know anything about. Sounds like
> normal platform/DT data per product/board.

I think one case where this kind of pin configuration is needed, and
which also dictates that all panel related configuration has to be in
the panel's data, not in the DSI master's data, is hotplug.

If you have a board that has two panels connected to the same video
output, probably via some kind of mux, at least for the sensitive pins
like DSI, only one of the panels can be enabled at a time. The panels
can have different wiring, and thus the panel driver would need to
configure everything related to the bus when it's starting up.

The same also happens if you have a true hotplug, i.e. you can remove
the panel totally and plug in a new one. Again the wiring can be
different, and needs to be set up.

And, as I said, this means that all relevant data about the video bus
has to be in the panel's data, so that each panel can have its own set
of, say, pin configuration.

Hotplug is not a use case we should aim to support for the CDF v1, but I
think we should strive not to prevent hotplug either. So if we can
design the API so that hotplug is possible, I say let's do that.

 Tomi



--------------enig865B519E65BD0F11BA97861F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRGKoAAAoJEPo9qoy8lh71SbYQAI392d86tkQlV/wt40WpeS9B
8SVV6eXwhyxGjBS76nBPb8YY0YLrpWUMcnL6ODeMy3OfNz9mMZHdjhpZUnOBJVBN
97ZbeFLi2VHmDtclU1kAymn1TyBy5QyPKmNmlXPp97cnm0NB6LYKlqcqAJrb0mGo
AIJvBfLdxSkb8zHCmy05Rj+6xi69Q878VUF7ZbLfehcnKjM2bxcIY8zqWbbx8L81
7i6Y9A3674mst08LTt0XvCFxnYR9KniGh9SMlgjMOy2L9qB1rL7bEYs7STZa5N82
7w5xvqbzoYKW2xSlHPO3hVmJWySsgxTTmoIWmJmRzbZUcdrpM6Caa+IOR8/14kOI
226Cp42JoYo+LXGgJrzDBMMQkasO+QOkj2/+5YWw0UvVAmn7df6FHrwCjA31Z1WH
52o9u82/P8ERL603ysv5wxchgy8mxE08EtsWNMYrrLTSlbpUUV26yICuoZ5A/0UE
TI3DsvLYvtp3bGHBq+l3yY6e6O36mXiL31DbBaHk2Qt0OESpS1pAS1hq2ef2cPYW
KltPhOwTsiKTGVMUVev/f5Z18esJjNF1MMZpTFt/xTeO7DNqn1BYWiKLKO3C7h5J
Q/vbm3Nfs2frE9LqO7bIaRJvrtP6Lr8NuJCDKMKy7fUpKl9imUhbqZ+0z91TDVOM
MQblvwVZFS2CCPzseDl9
=35gR
-----END PGP SIGNATURE-----

--------------enig865B519E65BD0F11BA97861F--
