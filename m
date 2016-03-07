From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Mon, 07 Mar 2016 20:10:16 +0000
Subject: Re: [PATCH 0/3] video: fbdev: imxfb: make it work again
Message-Id: <20160307201016.GB31868@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAOMZO5BxrVHNq8BdOqAqkaOqC905+AOSkFtsrWFHbz4cfN=Kaw@mail.gmail.com>
In-Reply-To: <CAOMZO5BxrVHNq8BdOqAqkaOqC905+AOSkFtsrWFHbz4cfN=Kaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Mon, Mar 07, 2016 at 05:03:53PM -0300, Fabio Estevam wrote:
> Hi Uwe,
>=20
> On Mon, Mar 7, 2016 at 4:53 PM, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > Hello,
> >
> > it seems the imxfb driver stopped working quite some time ago. Here come
>=20
> Yes, I noticed it has been broken for a long time.
>=20
> After this fix I managed to get it working again:
>=20
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/dr=
ivers/video/fbdev/imxfb.c?id=B82fe6ddd782f847332aeabf8cab980852f61629

I missed this one, but it works for me also without this patch (maybe
because my bootloader is aware of the display?).

My problem was that the handling for the optional regulator was
wrong/nonexistent. imx25-pdk.dts doesn't use it and so doesn't suffer
the corresponding problems.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
