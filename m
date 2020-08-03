From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 03 Aug 2020 20:12:09 +0000
Subject: Re: [PATCH][next] fbdev: Use fallthrough pseudo-keyword
Message-Id: <20200803201209.GA579791@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200707210539.GA12530@embeddedor>
 <20200803194024.GA525506@ravnborg.org>
 <101585b1d3c2a9db8fe394c51f64115e8bfc1754.camel@perches.com>
In-Reply-To: <101585b1d3c2a9db8fe394c51f64115e8bfc1754.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Joe Perches <joe@perches.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Timur Tabi <timur@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, dri-devel@lists.freedesktop.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 12:52:40PM -0700, Joe Perches wrote:
> On Mon, 2020-08-03 at 21:41 +0200, Sam Ravnborg wrote:
> > On Tue, Jul 07, 2020 at 04:05:39PM -0500, Gustavo A. R. Silva wrote:
> > > Replace the existing /* fall through */ comments and its variants with
> > > the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> > > fall-through markings when it is the case.
> > >=20
> > > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?hi=
ghlight=FAllthrough#implicit-switch-case-fall-through
> > >=20
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> >=20
> > Thanks.
> >=20
> > Fixed indent in arcfb.c while applying.
> > Applied to drm-misc-next and it will appear in 5.10
>=20
> Perhaps better would be to fix all the switch / case
> brace uses so that it looks more typical kernel style.

falltrhough seems like an OK thing to do even if fbdev is in pure
maintenance mode. Mostly so tools do not stumble upon this and
we continue to see patches.

But larger refactorings seems a little pointless.

If we do this change, should we then also start to accept indent fixes
for the other switch () cases in the fbdev drivers.

My initial reaction is therefore thanks, but no thanks.

	Sam

>=20
> > > diff --git a/drivers/video/fbdev/arcfb.c b/drivers/video/fbdev/arcfb.c
> > > index 6f7838979f0a..ae3d8e8b8d33 100644
> > > --- a/drivers/video/fbdev/arcfb.c
> > > +++ b/drivers/video/fbdev/arcfb.c
> > > @@ -419,7 +419,7 @@ static int arcfb_ioctl(struct fb_info *info,
> > >  			schedule();
> > >  			finish_wait(&arcfb_waitq, &wait);
> > >  		}
> > > -		/* fall through */
> > > +			fallthrough;
> > > =20
> > >  		case FBIO_GETCONTROL2:
> > >  		{
>=20
> ---
>  drivers/video/fbdev/arcfb.c | 52 ++++++++++++++++++++++-----------------=
------
>  1 file changed, 25 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/arcfb.c b/drivers/video/fbdev/arcfb.c
> index 6f7838979f0a..4419655e3e58 100644
> --- a/drivers/video/fbdev/arcfb.c
> +++ b/drivers/video/fbdev/arcfb.c
> @@ -403,35 +403,33 @@ static int arcfb_ioctl(struct fb_info *info,
>  	unsigned long flags;
> =20
>  	switch (cmd) {
> -		case FBIO_WAITEVENT:
> -		{
> -			DEFINE_WAIT(wait);
> -			/* illegal to wait on arc if no irq will occur */
> -			if (!par->irq)
> -				return -EINVAL;
> -
> -			/* wait until the Arc has generated an interrupt
> -			 * which will wake us up */
> -			spin_lock_irqsave(&par->lock, flags);
> -			prepare_to_wait(&arcfb_waitq, &wait,
> -					TASK_INTERRUPTIBLE);
> -			spin_unlock_irqrestore(&par->lock, flags);
> -			schedule();
> -			finish_wait(&arcfb_waitq, &wait);
> -		}
> -		/* fall through */
> +	case FBIO_WAITEVENT: {
> +		DEFINE_WAIT(wait);
> +		/* illegal to wait on arc if no irq will occur */
> +		if (!par->irq)
> +			return -EINVAL;
> =20
> -		case FBIO_GETCONTROL2:
> -		{
> -			unsigned char ctl2;
> +		/* wait until the Arc has generated an interrupt
> +		 * which will wake us up */
> +		spin_lock_irqsave(&par->lock, flags);
> +		prepare_to_wait(&arcfb_waitq, &wait, TASK_INTERRUPTIBLE);
> +		spin_unlock_irqrestore(&par->lock, flags);
> +		schedule();
> +		finish_wait(&arcfb_waitq, &wait);
> +		fallthrough;
> +	}
> =20
> -			ctl2 =3D ks108_readb_ctl2(info->par);
> -			if (copy_to_user(argp, &ctl2, sizeof(ctl2)))
> -				return -EFAULT;
> -			return 0;
> -		}
> -		default:
> -			return -EINVAL;
> +	case FBIO_GETCONTROL2: {
> +		unsigned char ctl2;
> +
> +		ctl2 =3D ks108_readb_ctl2(info->par);
> +		if (copy_to_user(argp, &ctl2, sizeof(ctl2)))
> +			return -EFAULT;
> +		return 0;
> +	}
> +
> +	default:
> +		return -EINVAL;
>  	}
>  }
> =20
>=20
