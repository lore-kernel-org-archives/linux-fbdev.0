From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 14 Aug 2012 09:58:58 +0000
Subject: Re: [PATCH 1/6] OMAPDSS: DISPC: cleanup cpu_is_xxxx checks
Message-Id: <1344938338.2345.20.camel@deskari>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-6ExtNbK0U9z9/O71WLFD"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344425874-28222-1-git-send-email-cmahapatra@ti.com>
	 <1344859135-4470-1-git-send-email-cmahapatra@ti.com>
In-Reply-To: <1344859135-4470-1-git-send-email-cmahapatra@ti.com>
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-6ExtNbK0U9z9/O71WLFD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-08-13 at 17:28 +0530, Chandrabhanu Mahapatra wrote:
> All the cpu_is checks have been moved to dispc_init_features function pro=
viding
> a much more generic and cleaner interface. The OMAP version and revision
> specific functions and data are initialized by dispc_features structure w=
hich is
> local to dispc.c.

The comments I gave for the dss.c patch apply to this one also, about
devm_free, __initdata, and the names of the feat arrays.

Otherwise, looks good.

 Tomi


--=-6ExtNbK0U9z9/O71WLFD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQKiFiAAoJEPo9qoy8lh71ZdgP/jZ7mMKzkMkEJk3I4DVTwGkt
GlbmIb/y1Ln9FqMP7sUxEkWwjCXT5mzQGEGw0eiZEnL0169qmCDlNh8zWbPc72bg
sK/Vi49ryAY6yW+zl5tdVh0dmu0W3TsjT/nCENA+XkZRB7O+53t7WKMYUzlRHzjg
pHcUuUYd7QJq7XKN8uA5G9MFbz7TVOtriJxEcpYrLsR3o3czhXT3dVboI1nqz3My
/u9/0lMyzq3vHo/xrgTNAXjnBulK1tnc8azAqa3ZvukCGV39dBavnScs7A/6VbzB
cOs9n+q3aWkHoGFkUF6nloOCHQYa0b4ldJ+KKRSP+r2Mp4W4VE7CyixqjezeRcps
hE8zc2jpckNrfPlELabHpx3XsWlYRmG0C1jN9wKNqt9BQj6y9EVwmuYJnhpaeBTO
Bm/xWFyp9SwiDEqyuCFGxJsO4brN4lXXrGNCBZGTmB63T5p1NLS1liLMk3U2s0Jb
ZW8weDZKerRWeH0eAO63CZWlCtELjb+pVXdKZQhmWgVt5Jwd3Hr1e4Sllnf9GqCv
H1Ilvvzg65WPbsCSeZhXUjSKNP2pk0ah72+IRkDOVvJOsHVxCtXggef/sYbT+ROP
ZM2uJOkDyYqaFZY6/GWSBwp3L0E14q2lFh3PK/sqZEHsGXYaQS/bh/YYUT02KmhM
VRDQhDSHJu2RBDUfKqri
=tMx4
-----END PGP SIGNATURE-----

--=-6ExtNbK0U9z9/O71WLFD--

