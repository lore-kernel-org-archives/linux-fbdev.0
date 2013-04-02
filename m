From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 02 Apr 2013 10:25:45 +0000
Subject: Re: [PATCHv2 6/6] video: fb: vt8500: Convert framebuffer drivers to standardized binding
Message-Id: <515AB229.4050204@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enigB0ABC9968CC44D504946208B"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364878200-26343-1-git-send-email-linux@prisktech.co.nz>
 <1364878200-26343-7-git-send-email-linux@prisktech.co.nz>
In-Reply-To: <1364878200-26343-7-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org

--------------enigB0ABC9968CC44D504946208B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-04-02 07:50, Tony Prisk wrote:
> Now that a display timing binding is available, convert our almost iden=
tical
> binding to use the standard binding.
>=20
> This patch converts the vt8500 and wm8505 framebuffer drivers and
> associated dts/dtsi files to use the standard binding as defined in
> bindings/video/display-timing.txt.
>=20
> There are two side-effects of making this conversion:
>=20
> 1) The fb node should now be in the board file, rather than the soc fil=
e as
> the display-timing node is a child of the fb node.
>=20
> 2) We still require a bits per pixel property to initialize the framebu=
ffer
> for the different lcd panels. Rather than including this as part of the=

> display timing, it is moved into the framebuffer node.

This means that the boards using the current DT bindings won't work with
a kernel with these patches, right? Is that ok?

I don't have any idea how strict we should be with DT bindings in
keeping compatibility...

 Tomi



--------------enigB0ABC9968CC44D504946208B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRWrIpAAoJEPo9qoy8lh717TgP/3lnL5EzmyHmOI6TPyHp2uM/
HeS4pUthDCXEFo1bd9nTVCKTSfWC2a9FZrytxEzAQQPltNJfrpoTXlJpXq6es48k
X+klt3kQt71T2cOENmRxjdTIgv+bf1GzWB7qnvJsaoH6BCleE6oJmjzN+3woB2GL
3Fv+kXWkCvR+INj17wIGOMhiux/G2ir4wdfub6W5A3tcLzoh90NRWcEahUxSJz0a
MMXfDp1Dak0tMaiUvYZABRm1dprjAOiKet76aecoon0r70zKNA+BtqS7xAUiaVcp
PP8DHJGj2Hbft3DMc8+mmiDYuCgFRJ5ne7eb6AUQ5KO6kpIb6iXye/L73hY01ERJ
lOHs3c8karFqILVTZMgVpF+a7c51W7yQ0DzrXtk/epfpQugleFhdlnhiviMKZArv
BQq8ivc+s5pyIGypPBMWykHjbA1NVo4r539cZAJNKSp5HY7KDv+NfQmDL+rrlGRa
RkzMJQU+Cdr5hWnWjcEy0YSb9qk56Et+E75FMgiDLI5adUns12uvvmWHcsesaOnN
HiUV/JhJTVdDeE6n2Wfw1VE0RqFCV7u7y1jk60DfvCIeIhrcwfO0ovoZ4LQcPai2
Xy+tAT6w4XWcXKAkmHW1kW7YSBT024G0gDv8cnqbqu04Qy9baKompO7nx7mWj64Q
t+8fME7t49PTlvvj9OR7
=BXyT
-----END PGP SIGNATURE-----

--------------enigB0ABC9968CC44D504946208B--
