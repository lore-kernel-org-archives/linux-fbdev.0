From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 10 Feb 2014 17:47:30 +0000
Subject: Re: [PATCH] backlight: replace kfree with put_device
Message-Id: <20140210174730.GE26997@lee--X1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1391762601-4560-1-git-send-email-levex@linux.com>
 <003701cf25f6$3807c6d0$a8175470$%han@samsung.com>
 <20140210111349.GA21522@lee--X1>
 <CAK5ve-L54nmDX_HLPpfWQrTe=n11RFr5hyUFFcc-1otWPQde7Q@mail.gmail.com>
In-Reply-To: <CAK5ve-L54nmDX_HLPpfWQrTe=n11RFr5hyUFFcc-1otWPQde7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Bryan Wu <cooloney@gmail.com>
Cc: Jingoo Han <jg1.han@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Levente Kurusa <levex@linux.com>, LKML <linux-kernel@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, FBDEV list <linux-fbdev@vger.kernel.org>

> >> > As per the comments on device_register, we shouldn't call kfree()
> >> > right after a device_register() failure. Instead call put_device(),
> >> > which in turn will call bl_device_release resulting in a kfree to the
> >> > full structure.
> >> >
> >> > Signed-off-by: Levente Kurusa <levex@linux.com>
> >>
> >> (+cc Bryan Wu, Lee Jones)
> >>
> >> Acked-by: Jingoo Han <jg1.han@samsung.com>
> >
> > Applied to temporary Backlight repo [1], thanks.
> >
> > [1] git://git.linaro.org/people/lee.jones/backlight.git
> >
>=20
> Great, I think we can put the Git URL into the MAINTAINS file for
> Backlight subsystem after your finalize the git repo.

Right, I plan do to this for MFD too. Before doing so I need to load
my GPG Key with lots of signatures, at Linus' request. I'm aiming for
the end of the month(ish).

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
