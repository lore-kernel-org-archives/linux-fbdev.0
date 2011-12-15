From: Tabi Timur-B04825 <B04825@freescale.com>
Date: Thu, 15 Dec 2011 17:27:53 +0000
Subject: Re: [PATCH v4 3/5] powerpc/mpc5121: shared DIU framebuffer support
Message-Id: <CAOZdJXUC2ir1QV320HH4LPHp_6EO6kvEST0vAno6y379BtxU1w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1279893639-24333-4-git-send-email-agust@denx.de>
In-Reply-To: <1279893639-24333-4-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Fri, Jul 23, 2010 at 9:00 AM, Anatolij Gustschin <agust@denx.de> wrote:

> @@ -1471,7 +1476,9 @@ static int __devinit fsl_diu_probe(struct of_device=
 *ofdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto error2;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 out_be32(&dr.diu_reg->diu_mode, 0); =A0 =A0 =A0 =A0 =A0 =A0=
 /* disable DIU anyway*/
> + =A0 =A0 =A0 diu_mode =3D in_be32(&dr.diu_reg->diu_mode);
> + =A0 =A0 =A0 if (diu_mode !=3D MFB_MODE1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&dr.diu_reg->diu_mode, 0); =A0 =A0=
 /* disable DIU */

Anatolij,

I know this patch is old, but I just noticed something odd about it
that I need your help with.

In the above snippet, you test for !=3D MFB_MODE1.  My understanding is
that U-boot only supports modes 0 and 1, never modes 2 or 3.  So
diu_mode can only ever be 0 or 1.  That means that that the above code
is equivalent to:

diu_mode =3D in_be32(&dr.diu_reg->diu_mode);
if (diu_mode =3D 0)
        out_be32(&dr.diu_reg->diu_mode, 0);     /* disable DIU */

which is silly, because now we're writing 0 to diu_mode only if it's alread=
y 0.

Am I missing something?

--=20
Timur Tabi
Linux kernel developer at Freescale
