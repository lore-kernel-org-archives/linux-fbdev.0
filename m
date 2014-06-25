From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 25 Jun 2014 12:03:31 +0000
Subject: Re: [PATCH] pwm-backlight: use devm_gpiod_get_optional()
Message-Id: <20140625120331.GE13518@lee--X1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1403687898-26881-1-git-send-email-acourbot@nvidia.com>
 <20140625095447.GT13803@lee--X1>
 <20140625111346.GB21208@ulmo>
In-Reply-To: <20140625111346.GB21208@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, gnurou@gmail.com

On Wed, 25 Jun 2014, Thierry Reding wrote:
> On Wed, Jun 25, 2014 at 10:54:47AM +0100, Lee Jones wrote:
> > > Make use of the new devm_gpiod_get_optional() to simplify the probe
> > > code.
> > >=20
> > > Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> > > ---
> > >  drivers/video/backlight/pwm_bl.c | 7 ++-----
> > >  1 file changed, 2 insertions(+), 5 deletions(-)
> >=20
> > Looks good.  Applied, thanks.
>=20
> Technically pwm_bl.c is my turf. However I only adopted it way back when
> the backlight subsystem was orphaned, but it seems Jingoo, Bryan and you
> are taking good care of it these days, so perhaps it would be a good
> idea to move it back to your custody?

Yeah, the whole 'driver maintainer' sketch could get pretty complex.
It's pretty clean-cut in the PWM subsystem as only one exists, but
Backlight and MFD have a whole bunch, and I don't usually wait for
them to Ack/Nack before applying or providing review comments.

I'm happy to play it however you like really.  I'm sure the boys and I
can handle it if you so wish.  Even better if you would say in the
MAINTAINERS file and provide review comments when patches are
submitted.  I do think all 'drivers/video/backlight' changes should go
in via the Backlight tree though.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
