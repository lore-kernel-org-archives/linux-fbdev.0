From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 20 Mar 2015 11:26:11 +0000
Subject: Re: [PATCH v2] video: mxsfb: Make sure axi clock is enabled when accessing registers
Message-Id: <550C03D3.7090504@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="smL6di4AhuMOu6qSTImHrJscViDVTGWxU"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425452771-19313-1-git-send-email-Ying.Liu@freescale.com> <54FEDD5D.4000104@ti.com> <20150311030327.GA3724@victor>
In-Reply-To: <20150311030327.GA3724@victor>
To: Liu Ying <Ying.Liu@freescale.com>
Cc: linux-fbdev@vger.kernel.org, Peter Chen <peter.chen@freescale.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Fabio Estevam <fabio.estevam@freescale.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org

--smL6di4AhuMOu6qSTImHrJscViDVTGWxU
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/03/15 05:03, Liu Ying wrote:

>> Why do you check for host->enabled here, but not elsewhere?
>=20
> We need this check here to make sure the axi clock reference count is n=
o greater
> than 1.  Looking at the context of mxsfb_set_par(), mxsfb_restore_mode(=
) and

Why is that? The clock framework handles ref counting for you. All the
driver needs to take care of is to call as many times disable as it
calls enable.

 Tomi



--smL6di4AhuMOu6qSTImHrJscViDVTGWxU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVDAPTAAoJEPo9qoy8lh71IlAP/jF6GfgI4r5nagf7bnPjIazS
iOt94VO6VFpK5IcUUi/OrTtVCQtDxT04zrmpJ8BUXQ/JW8/UkOA0fLZgezIXPhQC
cLZrLEhz7PcUMAv0DUYZ7srip7yO+eNuSzxETFPMfX14bkjdck6EPFoKws/z0UL/
vq/gR7WOII85bH0kJC5RXprCm8RTRmwOxetSZ0p/zT5j7m10PxVCG6icNlrK09YG
LaSKI/fmsGr80quM/et8FZw6U4UWYw3JAjdE1sTNtb4HAzySnp6qdSbnSxEz6IfO
PO/QwWg5T4SLe+B4Rmd2lGxQ0y6xGDlTDQ7x5hU3nSI1ESN8LSjyqHehywb4l7zc
NlerEDUpg9jua+yh26gNomejD29uKVNHkzqz3evyq4tcTDtvNJX27BkE/ShZYOLN
iLswvl6CmmhiqRXhMtVl0XuY39TSZRS7p60w9jMRhsmgnThfY6qXgQUQkPGqvOzh
ewsud9LDbmWL6lZSesmBmxFCV4JeBZg9KYNZH6T8FdTC1OqMsKut2iZX8+p1+fL5
87GEqpoQs10od9p4Z6xGjAl+mLmb4FJj0+PH4oUo4d9g+OEEnNaNWGBzonxOg/1r
rQ2j3kpSm796qugwHiqjq6Uu48yaCJ+g+zt8I2ybtw+kaQ22B6bkORm+U71DrbTJ
dSADIUUWpE5Qbj7qzmBh
=KTNT
-----END PGP SIGNATURE-----

--smL6di4AhuMOu6qSTImHrJscViDVTGWxU--
