From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 10 Feb 2014 11:13:49 +0000
Subject: Re: [PATCH] backlight: replace kfree with put_device
Message-Id: <20140210111349.GA21522@lee--X1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1391762601-4560-1-git-send-email-levex@linux.com>
 <003701cf25f6$3807c6d0$a8175470$%han@samsung.com>
In-Reply-To: <003701cf25f6$3807c6d0$a8175470$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>, 'Levente Kurusa' <levex@linux.com>, 'LKML' <linux-kernel@vger.kernel.org>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'FBDEV list' <linux-fbdev@vger.kernel.org>, 'Bryan Wu' <cooloney@gmail.com>

> > As per the comments on device_register, we shouldn't call kfree()
> > right after a device_register() failure. Instead call put_device(),
> > which in turn will call bl_device_release resulting in a kfree to the
> > full structure.
> >=20
> > Signed-off-by: Levente Kurusa <levex@linux.com>
>=20
> (+cc Bryan Wu, Lee Jones)
>=20
> Acked-by: Jingoo Han <jg1.han@samsung.com>

Applied to temporary Backlight repo [1], thanks.

[1] git://git.linaro.org/people/lee.jones/backlight.git

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
