From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 17 Oct 2013 11:35:49 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <525FCB95.6070401@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="hHDutNNBDh2ik3OnIBdnooNspJEANeaf1"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com> <1695169.rzbDl9PeRX@avalon> <20131017085342.GB2502@ulmo.nvidia.com> <12566222.aRYc4MDoOm@avalon>
In-Reply-To: <12566222.aRYc4MDoOm@avalon>
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--hHDutNNBDh2ik3OnIBdnooNspJEANeaf1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17/10/13 14:02, Laurent Pinchart wrote:

>> Okay, so if I understand correctly, translating those bindings to pane=
l
>> nodes would look somewhat like this:
>>
>> 	dc: display-controller {
>> 		ports {
>> 			port@0 {
>> 				remote-endpoint =3D <&panel>;
>> 			};
>> 		};
>> 	};
>>
>> 	panel: panel {
>> 		ports {
>> 			port@0 {
>> 				remote-endpoint =3D <&dc>;
>> 			};
>> 		};
>> 	};
>>
>> The above leaves out any of the other, non-relevant properties. Does
>> that sound about right?
>=20
> Yes it does.

It does?

Shouldn't it be something like:

panel {
	ports {
		port@0 {
			endpoint@0 {
				remote =3D <&dc>;
			};
		};
	};
};

And simplified:

panel {
	port {
		endpoint@0 {
			remote =3D <&dc>;
		};
	};
};

You do need a node for the endpoint, a remote-endpoint property is not
enough.

> Please note that, when a device has as single port, the ports node can =
be=20
> omitted, and the port doesn't need to be numbered. You would then end u=
p with
>=20
>  	dc: display-controller {
> 		port {
> 			remote-endpoint =3D <&panel>;
>  		};
>  	};
> =20
>  	panel: panel {
>  		port {
>  			remote-endpoint =3D <&dc>;
>  		};
>  	};
>=20
> I don't think there's a way to simplify it further.

I'm not sure if there's a specific need for the port or endpoint nodes
in cases like the above. Even if we have common properties describing
the endpoint, I guess they could just be in the parent node.

panel {
	remote =3D <&dc>;
	common-video-property =3D <asd>;
};

The above would imply one port and one endpoint. Would that work? If we
had a function like parse_endpoint(node), we could just point it to
either a real endpoint node, or to the device's node.

 Tomi



--hHDutNNBDh2ik3OnIBdnooNspJEANeaf1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSX8uVAAoJEPo9qoy8lh71v8gQAJE+RtSkb7VB7Q08VhBkadIo
WFyk6iqs2u/R7PaUfoHET+m2e+aAiaVopyat5Jfh7fYWIxQ8m/6Qwm7+mLLN4tzN
+uKlMdXnm6WqmfDMpz6DKM2Ruhi+zaikseMIcNE7tRAqyUx4TWUuCkHfMn/hFz0L
4M4AGJoJC4FkL1/ZykBHyk5uZ2nRXcUAsTf9fHApsLoQpogpmFOn7ZK/kI54IoAe
W2UgOyeZBiLlLyl4WX0SzF6qdLIgfUMDE7HJ0dsP5Ldvcy+etfeTijHq6CKH7tqB
7/1WdjjKe4pWfYCEAX1Iqgt9g3RgeX9UJ7kM9319Vk+ahH4dtVuxX8uQLC4RmJRd
I0rF13Y7QK55iAZAcmymnUMvyk1jXrCoc+v/IW7MHgRfvTV0dfx7XIP/178zQrWG
lutx6S9mzI+tTT2QOxvi3Ybh2WRRH6pkuotNkqaMjPmAyulz+XbBrGZOl888PTc3
xOR9lghdF+s5NyKgomWRRWpXOeGvV0Ld8bV1Q50U1xMulgfzbp40r3BBOxL6DjJj
ODF+Z+rPoYB/yy7/Y+p1RqJYqr7rVt+B02GaH0u3KAJgA90tFYYPmj28gvhGlGk7
vU+IAJJemszB+TCoT7pWHrF6lawqcZNIkRSfd34sHkAMf+yeMaojkw88pgTTsI7E
ZBBrCEPrnL2/jcwqnkkx
=6/2j
-----END PGP SIGNATURE-----

--hHDutNNBDh2ik3OnIBdnooNspJEANeaf1--
