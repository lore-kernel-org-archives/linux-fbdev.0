From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 13 Nov 2014 11:31:43 +0000
Subject: Re: [PATCH 4/4] arm: dts: omap3-gta04: Add static configuration for devconf1 register
Message-Id: <5464969F.30708@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="DMCMabk2ehAkTPpWcefgGcbx1ANQjpQ4x"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415051968-4878-1-git-send-email-marek@goldelico.com>
 <1415051968-4878-5-git-send-email-marek@goldelico.com>
 <5463585D.9070209@ti.com> <20141112150210.GC26481@atomide.com>
In-Reply-To: <20141112150210.GC26481@atomide.com>
To: linux-arm-kernel@lists.infradead.org

--DMCMabk2ehAkTPpWcefgGcbx1ANQjpQ4x
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 12/11/14 17:02, Tony Lindgren wrote:

>> And, with a quick grep, I see CONTROL_DEVCONF1 touched in multiple
>> places in the kernel. I wonder if adding a pinmux entry for it could
>> cause some rather odd problems.
>=20
> They can all use pinctrl-single no problem.

Can, but don't. That's my worry. If we touch the DEVCONF1 via pinmux,
and we have code in mach-omap2 that also touch DEVCONF1, without any
knowledge (and locking) between those...

So _maybe_ that's not an issue, as the pinmux config we have here is
fixed, and done once at boot time, and maybe the code in mach-omap2 that
touch DEVCONF1 is also ran just once and not at the same time as the
pinmux. But I don't know if that's so.

 Tomi



--DMCMabk2ehAkTPpWcefgGcbx1ANQjpQ4x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZJafAAoJEPo9qoy8lh71jJgP/3qSP8qsUyziPLpWjcX37leM
NlMTt9xjQ6B8aNIUWDaso5CpfJmsO47I5S5coKcCDAtnyyRZdp1bGg6MtEhxWOoy
mP0WfoZDzMrQh/j7IASwHe8R9MlHPCSa/+IBmG5BsqRCPaxrDULM8E6aGn3noKo1
uI7XCossptOUjKhR6NxXaXKR0uqDZfkmCHvsVwNLj1mQiQAuns271AGkCVSUHlWN
SN+gzxpg367m5DSAXuodLJZ8Vv+fC7Bkl1iDYrSO6zHAPlcPchxCeM9/iFZRzC12
EAeSYTEQ1jrxiE3XReqNcqDP+/Pb2PDL6lapPMdawhuuFVRKF5X4yKpiNsdMQ8Uf
qz1uiJN9E+fvewd0AVcndkLhkqwrWDDsFlgNHXM4xIpUHlSofurAhUMOtsy3OTse
FErYnbNwz5Ls0XWta1OYmXUpwlc6Uy0JFaXdpCiIEpryzqbqYoVpuVuFreciFuGk
VkoD1n1UkYRqaJW+phdfQxn+OFW/MO/m496rYvoQtCRqd4GRrh5mCVePYQ5ALZD2
TUwtC+b41ynOO41SBMMAIHLMF0b8nxv4jv6fm1HXT1OI45ba6wxN8UTz0rzat5nE
UQuvXYRDu+cssCiZq2OXRndj46cai21CZ8w6xpaaQDWbnBNKc3RRTjHHeHc1uKWu
Xh0V0i2cC29uQe+PqAcE
=U/8Y
-----END PGP SIGNATURE-----

--DMCMabk2ehAkTPpWcefgGcbx1ANQjpQ4x--
