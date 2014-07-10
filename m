From: Lee Jones <lee.jones@linaro.org>
Date: Thu, 10 Jul 2014 07:40:01 +0000
Subject: Re: [PATCH] video: backlight: jornada720_lcd.c: Cleaning up variable that is never used
Message-Id: <20140710074001.GP2635@lee--X1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404763270-24932-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <20140709163050.GM2635@lee--X1>
 <CAFo99gYErPZo_f-5kZkDqZ0YSPirE1fLn2F1odMPSjuUdLUQ8A@mail.gmail.com>
 <003001cf9be6$b45cfcd0$1d16f670$%han@samsung.com>
In-Reply-To: <003001cf9be6$b45cfcd0$1d16f670$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Rickard Strandqvist' <rickard_strandqvist@spectrumdigital.se>, 'Bryan Wu' <cooloney@gmail.com>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Linux Fbdev development list' <linux-fbdev@vger.kernel.org>, linux-kernel@vger.kernel.org

On Thu, 10 Jul 2014, Jingoo Han wrote:

> On Thursday, July 10, 2014 7:08 AM, Rickard Strandqvist wrote:
> > 2014-07-09 18:30 GMT+02:00 Lee Jones <lee.jones@linaro.org>:
> > > On Mon, 07 Jul 2014, Rickard Strandqvist wrote:
> > >
> > >> Variable ar assigned a value that is never used.
> > >> I have also removed all the code that thereby serves no purpose,
> > >> and made same change to clarify the similarities in function.
> > >>
> > >> This was found using a static code analysis program called cppcheck
> > >>
> > >> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigi=
tal.se>
> > >> ---
> > >>  drivers/video/backlight/jornada720_lcd.c |   31 ++++++++++++++-----=
-----------
> > >>  1 file changed, 14 insertions(+), 17 deletions(-)
> > >>
> > >> diff --git a/drivers/video/backlight/jornada720_lcd.c b/drivers/vide=
o/backlight/jornada720_lcd.c
> > >> index da3876c..d16abcf 100644
> > >> --- a/drivers/video/backlight/jornada720_lcd.c
> > >> +++ b/drivers/video/backlight/jornada720_lcd.c
> > >> @@ -36,44 +36,41 @@ static int jornada_lcd_get_power(struct lcd_devi=
ce *ld)
> > >>
> > >>  static int jornada_lcd_get_contrast(struct lcd_device *ld)
> > >>  {
> > >> -     int ret;
> > >> +     int ret =3D -ETIMEDOUT;
> > >>
> > >>       if (jornada_lcd_get_power(ld) !=3D FB_BLANK_UNBLANK)
> > >>               return 0;
> > >>
> > >>       jornada_ssp_start();
> > >>
> > >> -     if (jornada_ssp_byte(GETCONTRAST) !=3D TXDUMMY) {
> > >> +     if (jornada_ssp_byte(GETCONTRAST) !=3D TXDUMMY)
> > >>               dev_err(&ld->dev, "get contrast failed\n");
> > >> -             jornada_ssp_end();
> > >> -             return -ETIMEDOUT;
> > >> -     } else {
> > >> +     else
> > >>               ret =3D jornada_ssp_byte(TXDUMMY);
> > >> -             jornada_ssp_end();
> > >> -             return ret;
> > >> -     }
> > >> +
> > >> +     jornada_ssp_end();
> > >> +
> > >> +     return ret;
> > >>  }
> > >>
> > >>  static int jornada_lcd_set_contrast(struct lcd_device *ld, int valu=
e)
> > >>  {
> > >> -     int ret;
> > >> +     int ret =3D -ETIMEDOUT;
> > >>
> > >>       jornada_ssp_start();
> > >>
> > >>       /* start by sending our set contrast cmd to mcu */
> > >> -     ret =3D jornada_ssp_byte(SETCONTRAST);
> > >> -
> > >> +     if (jornada_ssp_byte(SETCONTRAST) !=3D TXDUMMY)
> > >> +             dev_err(&ld->dev, "set contrast failed\n");
> > >>       /* push the new value */
> > >> -     if (jornada_ssp_byte(value) !=3D TXDUMMY) {
> > >> +     else if (jornada_ssp_byte(value) !=3D TXDUMMY)
> > >>               dev_err(&ld->dev, "set contrast failed\n");
> > >> -             jornada_ssp_end();
> > >> -             return -ETIMEDOUT;
> > >> -     }
> > >> +     else /* if we get here we can assume everything went well */
> > >> +             ret =3D 0;
> > >>
> > >> -     /* if we get here we can assume everything went well */
> > >>       jornada_ssp_end();
> > >>
> > >> -     return 0;
> > >> +     return ret;
> > >>  }
> > >>
> > >>  static int jornada_lcd_set_power(struct lcd_device *ld, int power)
> > >
> > > Counter suggestion.
> > >
> > > What do you think, I think this looks cleaner:
> > >
> > > static int jornada_lcd_get_contrast(struct lcd_device *ld)
> > > {
> > >         int ret;
> > >
> > >         if (jornada_lcd_get_power(ld) !=3D FB_BLANK_UNBLANK)
> > >                 return 0;
> > >
> > >         jornada_ssp_start();
> > >
> > >         if (jornada_ssp_byte(GETCONTRAST) =3D TXDUMMY) {
> > >                 ret =3D jornada_ssp_byte(TXDUMMY);
> > >                 goto success;
> > >         }
> > >
> > >         dev_err(&ld->dev, "failed to set contrast\n");
> > >         ret =3D -ETIMEDOUT;
> > >
> > > success:
> > >         jornada_ssp_end();
> > >         return ret;
> > > }
> > >
> > > static int jornada_lcd_set_contrast(struct lcd_device *ld, int value)
> > > {
> > >         int ret =3D 0;
> > >
> > >         jornada_ssp_start();
> > >
> > >         /* start by sending our set contrast cmd to mcu */
> > >         if (jornada_ssp_byte(SETCONTRAST) =3D TXDUMMY) {
> > >                 /* if successful, push the new value */
> > >                 if (jornada_ssp_byte(value) =3D TXDUMMY)
> > >                         goto success;
> > >         }
> > >
> > >         dev_err(&ld->dev, "failed to set contrast\n");
> > >         ret =3D -ETIMEDOUT;
> > >
> > > success:
> > >         jornada_ssp_end();
> > >         return ret;
> > > }
> >=20
> >=20
> > Hi Lee!
> >=20
> > Yes, I agree!
> > Both are clean without so much repetition of code, which was what annoy=
d me.
> > But yours is clearer when things go good or bad, nice 1 ;)
>=20
> Hi Rickard Strandqvist,
>=20
> I would liked to prefer Lee Jones's code. It looks cleaner.
>=20
> >=20
> > I do not know what I can/may do, but I'll try. Remove what is not ok :-)
> >=20
> > Reviewed-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.s=
e>
> > Suggested-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.=
se>
>=20
> I suggest the following.
>=20
> Suggested-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> Cc: Bryan Wu <cooloney@gmail.com>

Very well, I will submit as a patch with Jingoo's Ack and Rickard's
Suggested-by and Reviewed-by.  Is anyone able to test this patch?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
