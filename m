From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 17 Oct 2013 08:49:52 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <525FA4B0.8060504@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="HJBx40O4EC6WJtLboI9VXcopssdqb7vRI"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com>	<1381947912-11741-3-git-send-email-treding@nvidia.com>	<1695169.rzbDl9PeRX@avalon> <CAPM=9tzU36cwcM0pH0J_Vgc6UOj5MHdVNDvn3wpGNuihbMqdQQ@mail.gmail.com>
In-Reply-To: <CAPM=9tzU36cwcM0pH0J_Vgc6UOj5MHdVNDvn3wpGNuihbMqdQQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

--HJBx40O4EC6WJtLboI9VXcopssdqb7vRI
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 17/10/13 11:28, Dave Airlie wrote:
>>
>> My biggest concern here is that this will not be compatible with the C=
DF DT
>> bindings. They're not complete yet, but they will require connections =
between
>> entities to be described in DT, in a way very similar (or actually ide=
ntical)
>> to the V4L2 DT bindings, documented in
>> Documentation/devicetree/bindings/media/video-interfaces.txt. Could yo=
u have a
>> look at that ? Please ignore all optional properties beside remote-end=
point,
>> as they're V4L2 specific.
>>
>> I also plan to specify video bus parameters in DT for CDF, but this ha=
sn't
>> been finalized yet.
>>
>=20
> While I understand this, I don't see why CDF can't enhance these
> bindings if it has
> requirements > than they have without disturbing the panel ones,
>=20
> is DT really that inflexible?
>=20
> It seems that have a simple description for basic panels like Thierry w=
ants
> to support, that can be enhanced for the other cases in the future shou=
ld
> suffice, I really don't like blocking stuff that makes things work on t=
he chance
> of something that isn't upstream yet, its sets a bad precedent, its als=
o breaks
> the perfect is the enemy of good rule

Just my opinion, but yes, DT is that inflexible. DT bindings are like a
syscall. Once they are there, you need to support them forever. That
support can, of course, include some kind of DT data converters or such,
that try to convert old bindings to new bindings at kernel boot.

In practice even such converter may be enough, if some important piece
of data in the new bindings is missing, and this data was implicit in a
driver. In that case the conversion, or parts of it, must be done later,
in that specific driver.

Even that may be difficult, if the piece of data should actually be
handled by some other driver. In that case there's probably need for
some kind of global look-up table or such, so that the drivers can work
around the problem of missing information.

I've been working with DT bindings for OMAP display subsystem for
something like 1.5 years. Still not merged, as they are not perfect, and
I'm scared to push them in non-perfect form, as that could result in
some kind of DT-binding-converter-hell described above.

 Tomi



--HJBx40O4EC6WJtLboI9VXcopssdqb7vRI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSX6SwAAoJEPo9qoy8lh71CPUP/ihvhWysnhWMZiCSCIHC3oPg
hu4Czeug94VDQB/BvaZJGd8rTdG6vauBmlPOGwSRxd/MxumKdsCgMLY9hkVqBNA2
3/OeMW+e81OPGmeGD6p32zckS1mpg9WDnLtURTrTawUtAx+VDO8d1W+JxkNZdeUp
72T0pwfstXRSzm/nacS2T2Sgz0/nHKjBuR7goTaiXI6ref6ZRwuNblFONqMitiF+
ObHZCWVvYJzYo633T4BYrKCh2pxk9aSHgjwhw4HYqNOwFLgc0oSOCz9gy+fPHo6Q
NkifzpE8rs7TnGWoWMH2HIjzdKd0O15kwBdoMxDSe8yuvTg5Q2U/99SXGD10YoY9
Q5BQQyWMQQP5gVYHKAWYBbMZBUDWGbDg277Kh+7RnJ+TtbrQuZuU38I9EN+A5GIy
+GajEB0Fv+Y1e7wsoJniaiLDu8WIRzQ4UZ2Ke0K+yEPeXkl853w94HAvKUMOlxQ1
55OVFhyJZPZMhHsMpMueGRsP0vokxy3lAyo7B2My+F8CP7K8xk9YFIS5vRs0y9BQ
PY3/9sxVS9QcsyACdqIdH91z9yjpzUpbla7lMnw0UvpmRH+EYrB1RBAI/az4owMS
9rGJomdyx5fUWsa+YsRFrolCcf8jHgkI73eH/biZTyJ5CaaanGSCSJvJeSKH7YiY
ejgHHcatIG1+A9NT76Tx
=UXr/
-----END PGP SIGNATURE-----

--HJBx40O4EC6WJtLboI9VXcopssdqb7vRI--
