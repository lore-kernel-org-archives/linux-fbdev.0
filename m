From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Mon, 15 Jul 2013 10:35:13 +0000
Subject: Re: [BUG] radeon: suspend resume
Message-Id: <1373884513.17776.71.camel@thor.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAG27Bk2NzdZELTeByjH5Sj_NbB+TOhYDK66aX1-9e=W_LT39Hg@mail.gmail.com>
In-Reply-To: <CAG27Bk2NzdZELTeByjH5Sj_NbB+TOhYDK66aX1-9e=W_LT39Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: kerolasa@gmail.com
Cc: dri-devel@lists.freedesktop.org


[ The radeon driver is discussed on the dri-devel mailing list, moving
there ]

On Son, 2013-07-14 at 13:26 +0100, Sami Kerola wrote:
>=20
> Jul 14 12:51:31 kerolasa-home kernel: radeon 0000:00:01.0: GPU lockup
> CP stall for more than 10000msec
> Jul 14 12:51:31 kerolasa-home kernel: radeon 0000:00:01.0: GPU lockup
> (waiting for 0x0000000000000004 last fence id 0x0000000000000002)
> Jul 14 12:51:31 kerolasa-home kernel: [drm:r600_uvd_ib_test] *ERROR*
> radeon: fence wait failed (-35).
> Jul 14 12:51:31 kerolasa-home kernel: [drm:radeon_ib_ring_tests]
> *ERROR* radeon: failed testing IB on ring 5 (-35).

Looks like the patch from
https://bugs.freedesktop.org/show_bug.cgi?idf425 might help.


--=20
Earthling Michel D=C3=A4nzer           |                   http://www.amd.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
