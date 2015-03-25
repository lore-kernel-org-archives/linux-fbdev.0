From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 25 Mar 2015 16:02:43 +0000
Subject: Re: [PATCH 5/8] fbdev: ssd1307fb: Add module parameter bitsperpixel.
Message-Id: <20150325160243.GI23664@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="WR+jf/RUebEcofwt"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1423261694-5939-6-git-send-email-niederp@physik.uni-kl.de>
 <20150207112043.GO2079@lukather>
 <20150207170503.045490aa@maestro.intranet>
 <20150214155415.GC25269@lukather>
 <54FECB5D.1020908@ti.com>
 <55129466.4060000@schinagl.nl>
In-Reply-To: <55129466.4060000@schinagl.nl>
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>, linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, linux-kernel@vger.kernel.org


--WR+jf/RUebEcofwt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2015 at 11:56:38AM +0100, Olliver Schinagl wrote:
> Hey all,
>=20
> On 10-03-15 11:45, Tomi Valkeinen wrote:
> >On 14/02/15 17:54, Maxime Ripard wrote:
> >>On Sat, Feb 07, 2015 at 05:05:03PM +0100, Thomas Niederpr=FCm wrote:
> >>>Am Sat, 7 Feb 2015 12:20:43 +0100
> >>>schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:
> >>>
> >>>>On Fri, Feb 06, 2015 at 11:28:11PM +0100, niederp@physik.uni-kl.de
> >>>>wrote:
> >>>>>From: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
> >>>>>
> >>>>>This patch adds a module parameter 'bitsperpixel' to adjust the
> >>>>>colordepth of the framebuffer. All values >1 will result in memory
> >>>>>map of the requested color depth. However only the MSB of each
> >>>>>pixel will be sent to the device. The framebuffer identifies itself
> >>>>>as a grayscale display with the specified depth.
> >>>>
> >>>>I'm not sure this is the right thing to do.
> >>>>
> >>>>The bits per pixel for this display is rightfully defined, used and
> >>>>reported to the userspace, why would you want to change that?
> >>>
> >>>You are right of course. The display is 1bpp and it reports to be 1
> >>>bpp. The problem is that there is almost no userspace library that can
> >>>handle 1 bit framebuffers correctly. So it is nice if the framebuffer
> >>>(optionally) can expose itself as 8 bits per pixel grayscale to the
> >>>userspace program. As an example this allows to run DirectFB on the
> >>>framebuffer, which is not possible out of the box for 1bpp.
> >>>
> >>>Also note that if do not set the module parameter at load time
> >>>the framebuffer will be 1bpp. So you have to actively set that module
> >>>parameter to make the framebuffer pretend to be more than 1bpp.
> >>>
> >>>In any case I don't cling to that patch, I just thought it was a nice
> >>>feature.
> >>
> >>I'd say that the right fix would be to patch DirectFB, instead of
> >>faking that in the kernel.
> >>
> >>But again, that's probably Tomi's call, not mine.
> >
> >Right, I'm not thrilled =3D). I don't think it's a good idea to lie to t=
he
> >userspace (except when fixing regressions).
>=20
> I've done the same thing actually in a local patchset and while you are
> right, we shouldn't lie to userspace, my choice was a performance one.

Userspace drivers can be more performant than the kernel ones. That
doesn't mean that it's a good choice, let alone the right choice.

> Right now, in the driver we already have to convert from a regular packed
> pixel framebuffer, to the format that supports the page layout of the act=
ual
> chip. Especially on slow hardware, doing the math within this conversion
> just adds a few multiplications.

And how does implementing monochrome operations in directfb would make
things worse from a performance point of view?

Are you really using performance as an argument for a device that is
driven through i2c?

> Also, there is indeed a lot of userspace out there which doesn't expect
> single bit displays.

And so just because *they* don't expect it and are not supporting
every case they should, *we* should do something about it?

A lot of userspace applications don't check syscall errors. Does that
mean that we should never return an error?

> Having said that, what about actually faking grayscale? If we toggle a pi=
xel
> fast enough (we can achieve 40ish fps right now with a 400 kHz I2C bus) it
> appears to a user as gray. This can't easily be done in user space, would
> that be acceptable?

You can't make the assumption that the bus is fast enough. It's your
case, it might not be the case for everyone.

Seriously, the device is monochrome, deal with it. If you wanted a
grayscale screen, you should have chosen better.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--WR+jf/RUebEcofwt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVEtwjAAoJEBx+YmzsjxAggTUP/1xNwR/+GJOPAaWvu7Kf6+Gn
J9bQUKWlQj2veexIB/q01T/N0st92IuE8NaxOQoj0AWfYbpwMQZhW2/rpBjE7S5I
1N9bN7kSDxsNmCoVyNIOGxSWvaYu4SYa2LXdHcSM+ML5Ve+n+kt4ZF88xK5UTb2u
VeWObw0Josgkb+CUjLwBSMzqBHyQo9xSiK0peaxJqJxpT+mdJnaMKQRf2YRRu1G5
nF9j5mSWTcqBXsVIaVJm5H5po61FtvwV37VW/lYaZRJpSM4bqmzReQ9SZQwnqIyz
55ZcYSMZ66hLmqzu1PkdcDgidig0PVTeaxi2H4hWCZeanYeOfrhklP5CSGPft6rF
4CO2bv0QqVZaH661HsBFzqKptP3bNX2j07MqeZYTFMJsUyLqm2UYZI3MTpp/bnpV
/Hr/2u9o1zlL+3L8AO6xCdeJcJr6sj5749p9m3Rpk3niVgW9AZJaDxBtgCplyv9F
Lkr49vTnSJmxY1FxbgGg1XIgYABNBDAILnHbWv8rQcb9TIZj2QokWhtqjCHCffOU
c9lO07UkEhACWENp4hAV62yq8vKgmAkj/HgQTWiaWgpbD9apo3Hxgfa4zzfXY7bd
zD8t9QCV6KraQYu5xZCmqEoptN8Vtc6WoGJa3D+p6kOtLGwvM2ip7w6K5ahBUwOE
jiXKzmZszi1laSA/KQXW
=l6Gw
-----END PGP SIGNATURE-----

--WR+jf/RUebEcofwt--
