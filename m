From: Liu Ying <liu.y.victor@gmail.com>
Date: Mon, 13 Dec 2010 11:35:08 +0000
Subject: Re: [PATCH 5/9] Add i.MX5 framebuffer driver
Message-Id: <AANLkTi=muPnjbJb9P9XSDnQJNjUSqRf-4F0sTf2WUNqR@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
	<1291902441-24712-6-git-send-email-s.hauer@pengutronix.de>
	<AANLkTikZowDCK4JPiCyEou1ekRuYA1qGnKrBPT5dXB+8@mail.gmail.com>
	<19717.51684.567190.925646@ipc1.ka-ro>
In-Reply-To: <19717.51684.567190.925646@ipc1.ka-ro>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello, Lothar Wa=DFmann,

I think your opinion is reasonable and better.
So, first, we can find the video mode in the video mode data base
defined in platform data, and then, if this fails, we can find it in
common video mode data base.

Best Regards,
Liu Ying

2010/12/13 Lothar Wa=DFmann <LW@karo-electronics.de>:
> Hi,
>
> Liu Ying writes:
>> 6) I prefer to find the video mode in modedb first, and if we cannot
>> find the video mode in common video mode data base, we can find a
>> video mode in custom video mode data base which is defined in platform
>> data. In this way, we don't need to export common modefb.
>>
> IMO platform specific video modes should take precedence over generic
> ones, so the platform data should be evaluated first.
>
>
> Lothar Wa=DFmann
> --
> ___________________________________________________________
>
> Ka-Ro electronics GmbH | Pascalstra=DFe 22 | D - 52076 Aachen
> Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
> Gesch=E4ftsf=FChrer: Matthias Kaussen
> Handelsregistereintrag: Amtsgericht Aachen, HRB 4996
>
> www.karo-electronics.de | info@karo-electronics.de
> ___________________________________________________________
>
