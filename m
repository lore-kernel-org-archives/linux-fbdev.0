From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 07 Mar 2014 11:35:28 +0000
Subject: Re: [PATCH v5 1/2] video: ARM CLCD: Add DT support
Message-Id: <5319AF00.5030602@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="RK31kf5Uw4XD9Sj4fPNJ2pnPI2av8oGQJ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394036606-17784-1-git-send-email-pawel.moll@arm.com>	
 <53184C2E.3000807@ti.com> <1394119431.4160.84.camel@hornet>
In-Reply-To: <1394119431.4160.84.camel@hornet>
To: linux-arm-kernel@lists.infradead.org

--RK31kf5Uw4XD9Sj4fPNJ2pnPI2av8oGQJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/03/14 17:23, Pawel Moll wrote:
> On Thu, 2014-03-06 at 10:21 +0000, Tomi Valkeinen wrote:
>> Is this an old HW, and presumably there won't be new users for it? If
>> yes, this is probably fine.=20
>=20
> There is a DRM driver in the works, actually...
>=20
>> If not, you might want to look at the video
>> ports and endpoints, which is used by at least three not-yet-merged se=
ries:
>>
>> [PATCHv3 00/41] OMAPDSS: DT support v3
>> [PATCH v5 00/11] imx-drm dt bindings
>> [RFC PATCH v2 00/21] Add DSI display support for Exynos based boards
>>
>> Using bindings like that would be more future proof, even if the curre=
nt
>> driver doesn't use them.
>=20
> ... and this makes me try to get out of its way. In other words, I full=
y
> agree with you, but I don't think this applies to this particular patch=
,
> as I'm not even trying to represent the display pipeline. The (optional=
)

Right, you are not, at the moment. My point was, if the driver is
extended later to support pipelines, or common panel/encoder drivers,
you (most likely) need to have similar bindings than the other people use=
=2E

Note that the same DT bindings you add here should also work for the DRM
driver in the future. So, in fact, the question is extended to: will the
fbdev or drm driver support common panels/encoders?

 Tomi



--RK31kf5Uw4XD9Sj4fPNJ2pnPI2av8oGQJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTGa8AAAoJEPo9qoy8lh71zqAP/2d7iCTeww05RBVzIrz+gV8n
ZWjIgvJbqHbVEm6q71k2I07hoI28MbX8tURmti0O7YG5PD4CU+nQf00yd4LyWr+Z
Ub3QkCv2/YrcGz0rj6AveQ8hMJJ4eT9Q24doQ3YvifmhSof3o0bxf/Dl+0yWN7iO
WDidZGmHkYhJdzdrLBTeF1ayDn3OcV1i45pZDYkcSFNnvH1WOZqmvz++/xDQGrJv
KlJXcV6CxjSWLfqokGYIRO2GB3meN5PvIvZ/qBZmxuRsd5S2znfOV7NX7kox4hhk
nFwS+7Jbnbou71WARPS8Cc4NyAtMzeyVWU1kD5N9C8TklS3aGaD6ljClRzrphY2G
B3sIvSOGNtkspFRBFQUpk/9NDUQrbZGdfAUaja/L2gBHgeoJ2ISQRWJYk92zK4i9
gKOe44In4wETV0Ezj67016fs6s2gDEQi5vXOrn5su5dGQX97XfIPPpDFTn2m/Puv
P2QPunOg1ZBadAAqTYNxsTmZQgz3Y3yAJXCGcPbSeFfXx5iNyo83B4k4jWjWHdwA
g1iEQsc4EWDs++5QSfjihWKQOJ5v2yFYRJHB8Swtgt/pIF8vxEDMpkep3bLH5xcy
rdNpCxaUJ+kbIUYv08eNVg29ODQAwkGWbJNGfRCNR2NKJPJJJDdzHDmanPbAUYOE
Y4FJpSlvaKXqCygKt7r3
=qDlP
-----END PGP SIGNATURE-----

--RK31kf5Uw4XD9Sj4fPNJ2pnPI2av8oGQJ--
