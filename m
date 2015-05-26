From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 26 May 2015 08:39:31 +0000
Subject: Re: [PATCH 15/21] backlight: Probe backlight devices on demand
Message-Id: <20150526083931.GC11677@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <1432565608-26036-16-git-send-email-tomeu.vizoso@collabora.com>
 <20150526071850.GA11677@x1> <20150526072526.GB6325@pengutronix.de>
In-Reply-To: <20150526072526.GB6325@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Tue, 26 May 2015, Sascha Hauer wrote:
> On Tue, May 26, 2015 at 08:18:50AM +0100, Lee Jones wrote:
> > On Mon, 25 May 2015, Tomeu Vizoso wrote:
> >=20
> > > When looking up a backlight device through its DT node, ensure that t=
he
> > > corresponding device has been registered.
> > >=20
> > > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > > ---
> > >  drivers/video/backlight/backlight.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> >=20
> > Looks reasonable.
> >=20
> > Until anyone screams at me, applied thanks.
>=20
> The compiler will scream at you when it realizes that
> of_platform_device_ensure() doesn't exist in your kernel...

Yup, indeed it did.

I assumed this was *only* enabling subsystems and that the
framework/API was already accepted.

So the advice I'd give to Tomeu when sending full enablement
patch-sets i.e. ones which provide the framework/API *and* enable
subsystems in the same set, is to send the entire set to everyone, so
we can see what the aim of the set is and how to deal with it.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
