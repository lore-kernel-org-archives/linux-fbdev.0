From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 14 Oct 2013 06:22:04 +0000
Subject: Re: [PATCH] do_register_framebuffer() fix potential deadlock
Message-Id: <525B8D8C.2060809@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="uoeFWlrddF2Rx1uRFwJfspp3dv7xkbrBg"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381528835-3351-1-git-send-email-ast@plumgrid.com>
In-Reply-To: <1381528835-3351-1-git-send-email-ast@plumgrid.com>
To: linux-fbdev@vger.kernel.org

--uoeFWlrddF2Rx1uRFwJfspp3dv7xkbrBg
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 12/10/13 01:00, Alexei Starovoitov wrote:
> commit 50e244cc79
> "fb: rework locking to fix lock ordering on takeover"
>=20
> fixed the locking, but in one place the console_lock() and lock_fb_info=
()
> seem to be in the wrong order vs the rest

The order seems to be lock_fb_info(), console_lock() everywhere. Your
change makes it the other way in one function, so I don't understand how
that could be a correct fix...

I wonder if you're seeing the same issue as John Tapsell in "fbcon: fix
deadlock in fbcon_generic_blank()"?

 Tomi



--uoeFWlrddF2Rx1uRFwJfspp3dv7xkbrBg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSW42MAAoJEPo9qoy8lh71R6kP/0H72hG/aGbnSQlxIWvoBI1H
WF7/bgsvB5HOaPlYX89opH5Ap4bVhLNgn+nuW1LQwF7kJ73ygtF9uNQ4KXcNLlrZ
KO4t4KUQ0wGaL7/XARmlrorHSG6mvxfJ8UBQuO+SPYuLUjgldZu6THbfvMFicHlt
CMggLzeti3TGLMjYhoOCgPhomtUtzTRlAiWMcXZMhbWJLG3CNlegJ0A8tBq1GTjm
RD+pHJJjaZaOezRnduus5V84YUcrYRlVQ833H8LV7+gRagdX9u8kD63aY7rOK0Gn
bEwqk3IGmt1g6+WNUuHOt9BuraQ5cr4rOMWVBFHf3PsGH45Q7lHkDbXdgnZHsD1j
ZmHe3XV87gx3ct3ZR8kHs6yrDD1kpfy8mR5AJqdQt+C0joLY5GG+o7idvhqNrAdq
hLgzVAU+FWEUYj3YKBEJ78N2/gAI6gme5Gubkm2oreWocw1sseKwZ0/ZHFnvi4Ce
at9PPZpOeOQnOU0ovEcgL0RMt7YzCwfal7UZLYvFNVzQVwj1aZwKUqUxSDyYaCOe
v8xVb8/uSHZ6/b750VlgQjMs2yrAZdiLrTzPxOx1J3+k/VyzuhbORIYKEP4NcJBu
SlChmlHKu6P8ZOl0A7q2UZ7Vr810gwrDlpIopXTsuQjg4BQ0HfEbPGgDpVXrLWNT
JVT3q+Yjhgbq5f2D2MAx
=3FVt
-----END PGP SIGNATURE-----

--uoeFWlrddF2Rx1uRFwJfspp3dv7xkbrBg--
