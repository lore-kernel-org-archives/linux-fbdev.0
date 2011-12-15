From: Anatolij Gustschin <agust@denx.de>
Date: Thu, 15 Dec 2011 21:26:39 +0000
Subject: Re: [PATCH v4 3/5] powerpc/mpc5121: shared DIU framebuffer support
Message-Id: <20111215222639.58822252@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1279893639-24333-4-git-send-email-agust@denx.de>
In-Reply-To: <1279893639-24333-4-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Thu, 15 Dec 2011 17:27:53 +0000
Tabi Timur-B04825 <B04825@freescale.com> wrote:

> On Fri, Jul 23, 2010 at 9:00 AM, Anatolij Gustschin <agust@denx.de> wrote:
>=20
> > @@ -1471,7 +1476,9 @@ static int __devinit fsl_diu_probe(struct of_devi=
ce *ofdev,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto error2;
> > =A0 =A0 =A0 =A0}
> >
> > - =A0 =A0 =A0 out_be32(&dr.diu_reg->diu_mode, 0); =A0 =A0 =A0 =A0 =A0 =
=A0 /* disable DIU anyway*/
> > + =A0 =A0 =A0 diu_mode =3D in_be32(&dr.diu_reg->diu_mode);
> > + =A0 =A0 =A0 if (diu_mode !=3D MFB_MODE1)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&dr.diu_reg->diu_mode, 0); =A0 =
=A0 /* disable DIU */
>=20
> Anatolij,
>=20
> I know this patch is old, but I just noticed something odd about it
> that I need your help with.
>=20
> In the above snippet, you test for !=3D MFB_MODE1.  My understanding is
> that U-boot only supports modes 0 and 1, never modes 2 or 3.  So
> diu_mode can only ever be 0 or 1.  That means that that the above code
> is equivalent to:
>=20
> diu_mode =3D in_be32(&dr.diu_reg->diu_mode);
> if (diu_mode =3D 0)
>         out_be32(&dr.diu_reg->diu_mode, 0);     /* disable DIU */
>=20
> which is silly, because now we're writing 0 to diu_mode only if it's alre=
ady 0.
>=20
> Am I missing something?

the intention of the above code snippet was:
not to disable DIU if it is in mode 1 (displaying splash screen)
and to disable DIU if it is in modes 2, 3 or 4 for some reason.

We cannot guarantee that the DIU is not in these modes. Even
if U-Boot didn't set these modes there is still a possibility
that such mode is configured. E.g. I've seen U-Boot binary
standalone applications for other display controllers initializing
the display controller.

But you are right. With this snippet, if the DIU is already
disabled, there will be not needed mode register access. So
the code should better look like:

diu_mode =3D in_be32(&dr.diu_reg->diu_mode);
if (diu_mode && diu_mode !=3D MFB_MODE1)
	out_be32(&dr.diu_reg->diu_mode, 0);

Anatolij
