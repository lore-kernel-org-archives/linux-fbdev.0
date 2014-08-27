From: Mark Brown <broonie@kernel.org>
Date: Wed, 27 Aug 2014 07:40:57 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140827074057.GS17528@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="sltC5TYTgaAtOHoi"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825141600.GA14763@ulmo.nvidia.com>
 <53FB46FF.1010208@redhat.com>
 <20140825145303.GC14763@ulmo.nvidia.com>
 <20140825150705.GB15297@lukather> <20140826082626.GE17263@ulmo>
 <20140826090035.GB17528@sirena.org.uk>
 <20140826091853.GI17263@ulmo>
 <20140826100612.GH17528@sirena.org.uk>
 <20140826105451.GD31124@ulmo> <1409078409.2701.17.camel@localhost>
In-Reply-To: <1409078409.2701.17.camel@localhost>
To: linux-arm-kernel@lists.infradead.org


--sltC5TYTgaAtOHoi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2014 at 08:40:09PM +0200, Henrik Nordstr=F6m wrote:

> It is not clear to me where the hardware resources should be listed in
> DT, being it a simplefb node or part of the actual hardware device node
> properly marked as dynamic boot defaults or something else? It's
> somewhere inbetween hardware and virtual device, and somewhat volatile.
> As far as simplefb is concerned it is a hardware desription of the
> framebuffer, but for a kms driver it's no more than firmware handover of
> boottime settings and ceases to exists once the kms driver have
> reconfigured the hardware.

Is simplefb something that should be in the device tree distinctly in
the first place - shouldn't it be a subset of the functionality of the
video nodes?  It's the same hardware being driven differently.

--sltC5TYTgaAtOHoi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/YuGAAoJELSic+t+oim9Q0cP/0eENEv8gBzPI7/AvD9SQK3J
B1pk3XzUGw851uqJTj2euMEq9OTz7l6BHQxwhKFlu7MdB85HILdy9tY/N/9xQcKM
QsgXVEJ0C132LFHVnX9G5UbP71J4tpl52NAVGOK2f2C8ZjAV8hxgGn73eb71DhmN
xg1gzaB475+cjQ/rqEowjNKG4KEVvYNgZ0woBZoiEdv4dOP1qKI4YjBCC9gqRYd3
tqLGHQ5HfkivZ3G9U3/i84uhSgnqz956n3kJUetO84lRnleyRoM8NV1pv0HlQ5Uk
6tZNSdYQqbiyjHbjKJKrXdXfOyYqoIlXfjikQLPD32BKVAFdil9lRIakM8tPmBqx
ofFoMtvbVRhrTLfYeZybDjr7ltbsXf5egPvDzoy1VlaKCIL0Q5VCEAUBp6ffqeBY
ViZnQwo+5BK/PKdLwL9ZcUAVQ+JayvR6b3Dax4tnActVJoASBvtQwwRIhn43W+cp
hr1WwX3FvlJngUPSCGXufMbJ0JLaU1WebJIy4uuJo2GV2hlLdtzuIeNXtuSqmKh6
xD/wlyV8ENoDBk5rAKIcqz/vJPeBjEry/mN96qtqe9lC0vDDtOipTlmBIRxcEMqM
SuZTeInVZWIk5sjoscP09dVCo+NERfR2zsKA+k+9KkkdUg4MXqB0PFjTlzEhAMPY
rkOtBrSkNZ7aYFaYUBUo
=gWN1
-----END PGP SIGNATURE-----

--sltC5TYTgaAtOHoi--
