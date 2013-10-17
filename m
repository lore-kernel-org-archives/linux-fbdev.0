From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 17 Oct 2013 12:32:29 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <525FD8DD.3090509@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="EK0SoG6Lsvtu2xP4qkNCaNQ1tJB2hEKqi"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com> <4885946.7Zgjf9zNXx@avalon> <525FD12D.3000200@ti.com> <3768216.eiA2v5KI6a@avalon>
In-Reply-To: <3768216.eiA2v5KI6a@avalon>
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--EK0SoG6Lsvtu2xP4qkNCaNQ1tJB2hEKqi
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17/10/13 15:17, Laurent Pinchart wrote:
> Hi Tomi,
>=20
> On Thursday 17 October 2013 14:59:41 Tomi Valkeinen wrote:
>> On 17/10/13 14:51, Laurent Pinchart wrote:
>>>> I'm not sure if there's a specific need for the port or endpoint nod=
es
>>>> in cases like the above. Even if we have common properties describin=
g
>>>> the endpoint, I guess they could just be in the parent node.
>>>>
>>>> panel {
>>>> 	remote =3D <&dc>;
>>>> 	common-video-property =3D <asd>;
>>>> };
>>>>
>>>> The above would imply one port and one endpoint. Would that work? If=
 we
>>>> had a function like parse_endpoint(node), we could just point it to
>>>> either a real endpoint node, or to the device's node.
>>>
>>> You reference the display controller here, not a specific display
>>> controller output. Don't most display controllers have several output=
s ?
>>
>> Sure. Then the display controller could have more verbose description.=

>> But the panel could still have what I wrote above, except the 'remote'=

>> property would point to a real endpoint node inside the dispc node, no=
t
>> to the dispc node.
>>
>> This would, of course, need some extra code to handle the different
>> cases, but just from DT point of view, I think all the relevant
>> information is there.
>=20
> There's many ways to describe the same information in DT. While we coul=
d have=20
> DT bindings that use different descriptions for different devices and s=
till=20
> support all of them in our code, why should we opt for that option that=
 will=20
> make the implementation much more complex when we can describe connecti=
ons in=20
> a simple and generic way ?

My suggestion was simple and generic. I'm not proposing per-device
custom bindings.

My point was, if we can describe the connections as I described above,
which to me sounds possible, we can simplify the panel DT data for 99.9%
of the cases.

To me, the first of these looks much nicer:

panel {
	remote =3D <&remote-endpoint>;
	common-video-property =3D <asd>;
};

panel {
	port {
		endpoint {
			remote =3D <&remote-endpoint>;
			common-video-property =3D <asd>;
		};
	};
};

If that can be supported in the SW by adding complexity to a few
functions, and it covers practically all the panels, isn't it worth it?

Note that I have not tried this, so I don't know if there are issues.
It's just a thought. Even if there's need for a endpoint node, perhaps
the port node can be made optional.

 Tomi



--EK0SoG6Lsvtu2xP4qkNCaNQ1tJB2hEKqi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSX9jdAAoJEPo9qoy8lh71330P/3VatL1x4D0biYYagST3RVbx
uwxA1dY8ktlLtlD4FR0Yzb7iQqrgIR7xvTXVfnHD5ARcdgj3Dnm8p0TohyhkE6zl
l2l1c3VuqXMHYpS7i89pQC3bm2UcZKik16I070lXHCVoOUfXEtaZLoA6x/mywfUn
u4dxWVik3ScM+T0EY/N1it4K9pRDtcL4WR+CgzlzTgrCa3t+lLizLCA6/8ZgnBtk
51eBH8oe7OK7+PfWtkWMApqclBisr4ycwnkYymFjxQyM42awu5kaVqWp2LGNYZE/
X7LLyqC9RLRPqNc1oqBDnT2AJ+u2dTWVBUHBRisUKqIATXFBswnPSgrjzdoqgLCe
Jsa+yBhLdRiQu9e/AiiHdJPkU/r7Sf866prBTznCadxEsfk+Mox7TTznnmvlFM6G
XTKyRF8RYG4sPlcuRDSRT3yPRd2ZwGwirIJyVbK03p5NFRG0nsJ4gf8k6gKvzlnN
R8DZxOpH2HntL14Af+4gQVl5GEWKAlbVEkKe6rVrZPLGZr51SDt5MqQkRyPcdJLl
3mHrXbizBCA20x2Vj6bkwRLQKg+FzdLEErlLHtyKWpdUeQq/WzKXPe0XxMh1byRa
iCIkAefiYnlzQj/QqgNhNcWsdPJD5Hi1eXlqv5CF3YLAWXcsw4nKMkeJwI8YxJyf
aXgVfmf04iMXTwqdxxiP
=kpdy
-----END PGP SIGNATURE-----

--EK0SoG6Lsvtu2xP4qkNCaNQ1tJB2hEKqi--
