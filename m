From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 29 Jan 2016 12:20:47 +0000
Subject: Re: [PATCH] video: fbdev: imxfb: Provide a reset mechanism
Message-Id: <56AB591F.2030400@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="dlvbbgSO4M4hLXK8P3EpvANq7jvGO2L99"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1453209057-16444-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1453209057-16444-1-git-send-email-festevam@gmail.com>
To: linux-fbdev@vger.kernel.org

--dlvbbgSO4M4hLXK8P3EpvANq7jvGO2L99
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 19/01/16 15:10, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>=20
> Currently when we boot the kernel on a mx25pdk the LCDC controller
> does not show the Linux logo on boot.
>=20
> This problem is well explained by Sascha Hauer:
>=20
> "Unfortunately this LCD controller does not have an enable bit. The
> controller starts directly when the clocks are enabled. If the clocks
> are enabled when the controller is not yet programmed with proper
> register values then it just goes into some undefined state. What I
> suspect is that the clocks already were enabled before driver probe,
> presumably by the bootloader, so the controller is already in undefined=

> state when entering Linux. Now by dis/enabling the ipg clock you
> effectively reset the controller. Since you have programmed it with
> valid register values in the mean time it starts working after this
> reset."
>=20
> So do as suggested and force a reset of the LCDC hardware by=20
> enabling and disabling the IPG clock.
>=20
> With this change the Linux logo can be seen on boot on a mx25pdk.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  drivers/video/fbdev/imxfb.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Thanks. Queued for 4.5 fixes.

 Tomi


--dlvbbgSO4M4hLXK8P3EpvANq7jvGO2L99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWq1kfAAoJEPo9qoy8lh714WMP/3irfTUzlSnludBvmmXRPf6I
j4BoJhEy5gNbAI5akXWwVzpHVnda3+yGmPeW5FdIwKMzuIGY4X02RQh01TPjUg4/
P/VltCqQMzW7UcLmRGeg/WSrMJMTg7AAqjnUFQ1T79wQ+JVu1bo+PlYJPuP01s1Q
RymX/uXqvx6i8fy22p800sMWsHy3c5DnJbKr71VFRA6ukKIMKidLwFQdczQFK47z
I3Zd60sOojZ3xe82ZoZP0hwtVKGj9rgmgZMsy4ODEdM6ZCkY0Uh0vsN1Kk9f8aj1
xleMinPeLh31WHHui1j0HAOaOsdh+iMFAaF2TPRidO20xHApOeSL/tkcu/PeBMqN
tvOTeV8Y3YwTqL0ZRHeV6L1cUzh59+mr9lTi38YI48YxUxWAeXFYMimgtJVkmllQ
5ir4wTyXDeBVX35r9lOei0nlW76UYsSpLjzr96sdmEqYLzFPtk5ljsTtr8EV4NeZ
WjQk4j7/FrUVRPStQUrJ7PWD3bCr3e5o1M2JdbF7+m38Jql1xE5akQyEl6SuYrRe
4h7aHONfc0afIMMvYsTg8v0L04J1lOuEC7q3rw7cdw6BbIr/79Fc1B9q2xAYXubn
hjvRPdPiQfhUNiKriTE4a2MJAl1Plh4fPzNchkdsJ9CMWeQjmRpDzDI52+6KUU4A
CimNDu09papZkOPN/YWC
=sfXC
-----END PGP SIGNATURE-----

--dlvbbgSO4M4hLXK8P3EpvANq7jvGO2L99--
