From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 29 Apr 2014 16:19:23 +0000
Subject: Re: [PATCH 06/23] ARM: OMAP: add OMAP5 DSI muxing
Message-Id: <535FD10B.4020108@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="xF0NqvUiaJaMqxBegi3r4xiE7FIFhWnja"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
 <1398334639-14172-7-git-send-email-tomi.valkeinen@ti.com>
 <535A42D6.5090107@ti.com> <535A4470.2000509@ti.com> <535A5C0A.7040808@ti.com>
 <535A6C40.10609@ti.com> <20140425153150.GA20807@atomide.com>
 <535DFAAE.1010606@ti.com> <20140428164528.GM20807@atomide.com>
 <535F37E9.8090609@ti.com> <20140429150529.GA27571@atomide.com>
In-Reply-To: <20140429150529.GA27571@atomide.com>
To: linux-arm-kernel@lists.infradead.org

--xF0NqvUiaJaMqxBegi3r4xiE7FIFhWnja
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 29/04/14 18:05, Tony Lindgren wrote:

>> omap4_padconf_global is a syscon node, not pinctrl. As syscon just giv=
es
>> a raw regmap to its memory area, the driver needs to know about the OM=
AP
>> control registers to use it.
>=20
> That would be probably best set up the same way we have already set up
> for example omap4_padconf_global: tisyscon@4a1005a0. Then drivers can
> access it using regmap, see how drivers/regulator/pbias-regulator.c
> sets up the pbias regulator with regmap for MMC.

Right, but it means that the driver will contain platform specific code
for all the omap revisions it supports. Isn't that wrong?

I already have a patch for DSI that uses the syscon-method, and it works
fine. But it's quite ugly, imo, to fiddle with the OMAP control
registers in a driver.

 Tomi



--xF0NqvUiaJaMqxBegi3r4xiE7FIFhWnja
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTX9ELAAoJEPo9qoy8lh71kxwP/2p6LVJhgXbyVN9+uNABipuF
RRMsrZCrInT1Ql44Hk5HFQJKLVbBsXtqP5k7wR7MCU3KoOjAq/rcK77ZP1X0ovWT
QfEoWZBSpgp1yjWPyoZPMiLzGyCZ+w0eDSZtOE23SQ1feoZAzDYWaoxJ/2SImic0
HUDNGOccsiUMDOvJkRCSPTTFl+E1p/QAUfnbGVO7V2QTk2SFGd5CKdiJ0L2wIYxi
OWTpOXLPjrun7p0Z8gzD45AMWaFvO15joUvd+HcAB1Jt1zzjUj8cH/a8Sf3GC0Ka
Un5BsoeZN/R0mxnhRyXrM6+jr4APJjeFnLXYL1k0fa75JdXkvdb72VloEQr/CU9S
YVdnj6P8CNWb4ftDhkGnkGgOQBLxaYxbVPFRPmu6HQ+JxfZzrRhSgL+LAJxzOIxq
/RK7kYbRzTJdNfpZGMFUNMQGg+lC1vePE0l8NtFKttg4i6I/qOqV/1OkYxHzv88W
zi6kjUeEbb2znYqufuoIs22VdFbSN/xrCVJnZlRENc9Haoe1fRa22Xt+0hsN5rGZ
UDSCCmU7VTNSvmNfdVQ1SKzHeTG97kJi+V1okj+RhXdAC2suiKIAF2tobTqXQ22r
iHVtweAnQh3TxqCX0gWd1hhGqGqVCdae5lY5YxOy2mVw2yeej7o0qw7ZPII9OBRL
eDJ80zrtove2cLmysld5
=YEar
-----END PGP SIGNATURE-----

--xF0NqvUiaJaMqxBegi3r4xiE7FIFhWnja--
