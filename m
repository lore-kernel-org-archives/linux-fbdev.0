From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 29 Oct 2012 09:56:58 +0000
Subject: Re: [PATCH 04/20] OMAPDSS: DISPC: fix dispc_mgr_lclk_rate for DIGIT output
Message-Id: <508E52EA.4030606@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enigE1D13BC62EAC80ABA4BC8A0B"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com> <1351070951-18616-5-git-send-email-tomi.valkeinen@ti.com> <508E5161.2060202@ti.com>
In-Reply-To: <508E5161.2060202@ti.com>
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enigE1D13BC62EAC80ABA4BC8A0B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-10-29 11:50, Archit Taneja wrote:
> On Wednesday 24 October 2012 02:58 PM, Tomi Valkeinen wrote:
>> dispc_mgr_lclk_rate() cannot currently be called with DIGIT channel
>> parameter, even if dispc_ovl_lclk_rate() can. Fix this by making
>=20
> It's called dispc_plane_lclk_rate() right now.

Right, that was a typo on the description.

>> dispc_mgr_lclk_rate() handle DIGIT channel also.
>=20
> Did you see a bug with this? Or is this just a cleanup?

Yes, I had a crash when I was implementing a function to check the
scaling and overlay parameters in such a way that all the parameters are
given to the function, i.e. the func doesn't get any config from the
hardware registers. So not a bug that happens in the current driver.

 Tomi



--------------enigE1D13BC62EAC80ABA4BC8A0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQjlLqAAoJEPo9qoy8lh719f4P/0Q8mVZbtuCM9kBuNjhnoZ0T
yc6dq37SNiC2vEE0zV2hQBoyOruwRbl3Ukn5tS76RwdRj2bTHBq1tO/kcFrLgnf2
8hBIBpHX4zFwXvJGIYCeiLaqIk1bsVvwIlGQ75P/Rktxso+zTALAAA5hiqW51RzX
VucUhf3SxhAfB9vmPddYkWtEGHDlRtnmZySNmtCriTIFrC/7eUo/kvV6RPm5QxLm
2Ifukiirtpx9W0os2Tf0ToOWg1eZPvACDx5hVCFScHrbovn08nHspETkmgE2In2k
rII/MROF/mk3K0eI6AKhHFm7WgrcSmkUO8lGqmE2IhfEIS66ryq2+kPCrxswwA3i
IIpCrM4LBG3ln8Hj/pGQjDqhArLWhz2YH5qsPfQp5Tur3TNNURSqdB9E7ywefpL1
2VdczhITECsjNzqmSkcSKC296DgzpslIvEhdRE+edMK85A3WzJbmueknaNVSkkSw
2FJrz6ZoACQmiSrLa5IhMXUOwxPG9TAQyh5Tr9H2vLXvrurv5FskZSGt28zEZKQg
Uu+SlGGe11DmMnuPZ0nlXrBaDsWXsmeNyr90Z1W2lP4u1bK/HEKi6NTnme4NEiGe
jqsbGX+jOKDDRuHLRh2q78SBuFNxbmXsHWvXBGugJxGj+9gzfMIE/h3VSuVm9dVo
H7BeRpnwJEkC1oq/3kFW
=oNNb
-----END PGP SIGNATURE-----

--------------enigE1D13BC62EAC80ABA4BC8A0B--
