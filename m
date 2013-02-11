From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 11 Feb 2013 10:14:22 +0000
Subject: Re: [RFC PATCH 0/4] Common Display Framework-TF
Message-Id: <5118C47E.3070306@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig5F3AA91DB96CC28F8833ADB7"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359560343-31636-1-git-send-email-t.figa@samsung.com> <4292748.rtElrP8BXd@avalon> <3272191.03RiBNfhoM@flatron> <5114E412.5030806@ti.com> <5114F224.6010201@stericsson.com> <5114F7C9.4040803@ti.com> <5114FD86.2020400@stericsson.com> <5115055B.2080509@ti.com> <511511B3.3060404@stericsson.com> <5118AA00.2000505@ti.com> <5118BA80.1020604@stericsson.com>
In-Reply-To: <5118BA80.1020604@stericsson.com>
To: Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomasz Figa <t.figa@samsung.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, Daniel Vetter <daniel@ffwll.ch>, Vikas Sajjan <vikas.sajjan@linaro.org>, "inki.dae@samsung.com" <inki.dae@samsung.com>, "dh09.lee@samsung.com" <dh09.lee@samsung.com>, "ville.syrjala@intel.com" <ville.syrjala@intel.com>, "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>

--------------enig5F3AA91DB96CC28F8833ADB7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-02-11 11:31, Marcus Lorentzon wrote:

> Ok, so what about a compromise which I think would work for "both" HWs
> ... we allow the "configure" operation during video on, then each HW
> driver could decide if this means you have to stop or not to do the
> changes required. But then it is also important that we keep all config=

> in one struct and not split it up. Otherwise HW like ours that has so b=
e
> stopped could need to stop once for each setting/operation called.
> So in short, allow configure(bus_params) during video on, keep all
> bus_params in the struct. It is in kernel struct so it can easily be
> changed/refactored.

Right, we need some way to group the configuration parameters. Either
one big struct, or something like start_config() and end_config(). I
think we could also think what parameters make no sense to be configured
on the fly, and possibly have those separately. Although it may be a bit
difficult to think of all the (weird) use cases.

> Again, this probing and bus muxing is platform/bus specific and not
> panel specific. Any panel of that type will only ever work on Omap (or

The parameters used for configuration itself is platform specific, and
that's why it needs to be defined in the DT data. But the API itself is
not platform specific. The parameters are information about how the
panel is connected, just like, say, number of data lines is for DPI.
Which is also something I think should be configured by the panel.

> someone else implementing the same muxing features) as I see it. So why=


No, it works for everyone. Well, at least I still don't see anything
omap or platform specific in the API. Of course, if the platform/device
doesn't support modifying the pin functions, then the function does nothi=
ng.

> not just put that config on the bus master, dispc? I still can't see ho=
w
> this is panel config. You are only pushing CDF API and meta data to
> describe something that is only needed by one bus master. I have never

The information about how the panel is connected (the wiring) has to be
somewhere in the DT data. We could have the info in the DSI master or in
the DSI slave. Or, in some platforms where the DSS is not involved in
the muxing/config, the info could be totally separate, in the boards
pinmuxing data.

I think all those work ok for normal cases without hotplug. But if you
have hotplug, then you need separate pinmuxing/config data for each panel=
=2E

You could possibly have a list of panels in your DSI master node,
containing the muxing data, but that sounds rather hacky, and also very
hardcoded, i.e. you need to know each panel that is ever going to be
connected.

If, on the other hand, you have the info in the panel node, it "just
works". When a new panel is connected, the relevant panel DT data comes
from somewhere (it's not relevant where), and it tells the DSI master
how it's connected.

Something like this is probably needed for the BeagleBone capes, if you
have happened to follow the discussion. Although it could be argued that
the capes may perhaps be not runtime hotswappable, and thus the
configuration can be done only once during boot after the cape has been
probed. But I'd rather not design the API so that we prevent hot swapping=
=2E

> seen any DSI slave that can change their pin config. And since there is=


Well, if omap is the only SoC/device out there that supports configuring
the pin functions, and everybody is against the API, I'm not going to
press it.

But then again, I think similar configuration support may be needed even
for the normal pinmuxing, even in the case where you can't reconfigure
the DSI pin functions. You still need to mux the pins (perhaps, say,
between DSI and a GPIO), depending on how many lanes the panel uses.

In fact, speaking about all pins in general, I'm not very fond of having
a static pinmuxing in the board DT data, handled by the board setup
code. I think generally the pins should be muxed to safe-mode by the
board setup code, and then configured to their proper function by the
driver when it is initializing.

> no generic hot plug detect of DSI panels, at least not before DSI bus i=
s
> available, I have to assume this probing it very platform specific. We
> have some products that provide 1-2 gpios to specify what panel is
> available, some use I2C sensor probing to then assume the panel plugged=
=2E

Yes, the hotplug mechanism is platform/board specific. But that's not
relevant here.

> At least in the first step I don't think this type of hot plug should b=
e
> in the API. Then once the base panel driver is in we could discuss
> different solutions for you hot plug scenario.

Yes, as I said, I also think we shouldn't aim for hotplug in the v1. But
we also shouldn't prevent it.

 Tomi



--------------enig5F3AA91DB96CC28F8833ADB7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRGMR+AAoJEPo9qoy8lh71kTgP/0/TqqxOxZpD1HvvXeRKJ8Aa
CSoX1/HgNNMWYaec1DDx5h1PMtBZjxVBX2fU+i7/GdlWa3fxGOPou0lLn5bU3SZL
Vyr2uFNooYt7UjAP8d7zUJOuRn4yqMa7n16JUn/MqO9QgGpffCZN62u1arx0kzXz
qMnrDLidrRoqgxpkZo/XP/VU5gsgQaqyuCnPku4oP4oEUBdkGs1Vv4h11w8JmIN/
bAr1N80d1lRFGn21mCe3gDSFStOxL23niwaxgj0F1pOf+KBI6FXv3HcEWXrOFPI5
vtvD/ucgWDOXCTN5aJ9ag+kzAs3u7P/gh301NPerNQ794JLbvdhSAOYivz6r3n6x
rukX32dFxL+w1XT0bGTprrzPKPFYjkrbvFrtssmmSphNWeUPJhWHJZ6IxlA9JCRS
RzdpXWHzYQJk+fup/oHAZscfSfQkd++nhnjwnaDQ7vMNv2iIj+ohnal2PlGGzMQp
E+OuongvolRhjGPVIIyI7xblEi5ail5IyI8fEDNAkhFM7jU6pc+vRFs+5D3SZdnA
gusGAbz2JBA79fcUD4QzFa9hoxEp4p/v65Iby99AE62cgtr4Hm+rtSTHepc1IsQz
DtKKR+wHnriX9lynKJO9XUVef4l3a966H+XXBPWglIij82ppgaBWtLQv4lSHQ3cU
/E4VCCv8dMEHA33IGCoe
=uYRQ
-----END PGP SIGNATURE-----

--------------enig5F3AA91DB96CC28F8833ADB7--
