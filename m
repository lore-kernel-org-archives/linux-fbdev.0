From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Date: Wed, 13 May 2020 17:20:17 +0000
Subject: Re: [PATCH v2] video: fbdev: ssd1307fb: Added support to Column offset
Message-Id: <CACk9uef9zY_cEVhhSdnYfSf-XZxrwU+V+eLUz5-N=U9DRtVp4g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1589388975-15499-1-git-send-email-alencar.fmce@imbel.gov.br> <CAHp75VeycGutrfTCrVP-9V61ag-KbNHfykQXHWU-8hwEFOerMQ@mail.gmail.com>
In-Reply-To: <CAHp75VeycGutrfTCrVP-9V61ag-KbNHfykQXHWU-8hwEFOerMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, devicetree <devicetree@vger.kernel.org>, Rodrigo Rolim Mendes de Alencar <alencar.fmce@imbel.gov.br>

Em qua., 13 de mai. de 2020 =C3=A0s 14:13, Andy Shevchenko
<andy.shevchenko@gmail.com> escreveu:
>
> On Wed, May 13, 2020 at 7:56 PM Rodrigo Rolim Mendes de Alencar
> <455.rodrigo.alencar@gmail.com> wrote:
> >
> > This patch provides support for displays like VGM128064B0W10,
> > which requires a column offset of 2, i.e., its segments starts
> > in SEG2 and ends in SEG129.
>
> Also, include Rob as well into Cc.
>
> ...
>
> > +       if (device_property_read_u32(node, "solomon,col-offset", &par->=
col_offset))
> > +               par->col_offset =3D 0;
> > +
> >         if (device_property_read_u32(dev, "solomon,com-offset", &par->c=
om_offset))
> >                 par->com_offset =3D 0;
>
> Have you ever compile it?

hmm I did it now. Sorry... found another issue. I'll fix it again

>
> --
> With Best Regards,
> Andy Shevchenko
