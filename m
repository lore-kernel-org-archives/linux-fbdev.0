From: =?iso-8859-15?Q?Lothar_Wa=DFmann?= <LW@KARO-electronics.de>
Date: Mon, 13 Dec 2010 07:23:16 +0000
Subject: Re: [PATCH 5/9] Add i.MX5 framebuffer driver
Message-Id: <19717.51684.567190.925646@ipc1.ka-ro>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
	<1291902441-24712-6-git-send-email-s.hauer@pengutronix.de>
	<AANLkTikZowDCK4JPiCyEou1ekRuYA1qGnKrBPT5dXB+8@mail.gmail.com>
In-Reply-To: <AANLkTikZowDCK4JPiCyEou1ekRuYA1qGnKrBPT5dXB+8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi,

Liu Ying writes:
> 6) I prefer to find the video mode in modedb first, and if we cannot
> find the video mode in common video mode data base, we can find a
> video mode in custom video mode data base which is defined in platform
> data. In this way, we don't need to export common modefb.
>=20
IMO platform specific video modes should take precedence over generic
ones, so the platform data should be evaluated first.


Lothar Wa=DFmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=DFe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=E4ftsf=FChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
