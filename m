From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 25 May 2015 10:40:06 +0000
Subject: Re: fbdev: ssd1307fb: Unify init code and obtain hw specific bits from DT
Message-Id: <20150525104006.GD22558@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150523173245.GA31663@mwanda>
In-Reply-To: <20150523173245.GA31663@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Mon, May 25, 2015 at 09:34:32AM +0200, Thomas Niederpr=FCm wrote:
> Am Sat, 23 May 2015 20:32:45 +0300
> schrieb Dan Carpenter <dan.carpenter@oracle.com>:
>=20
> > Hello Thomas Niederpr=FCm,
> >=20
> > The patch a3998fe03e87: "fbdev: ssd1307fb: Unify init code and obtain
> > hw specific bits from DT" from Mar 31, 2015, leads to the following
> > static checker warning:
> >=20
> > 	drivers/video/fbdev/ssd1307fb.c:371 ssd1307fb_init()
> > 	warn: add some parenthesis here?
> >=20
> > drivers/video/fbdev/ssd1307fb.c
> >    366          /* Set COM pins configuration */
> >    367          ret =3D ssd1307fb_write_cmd(par->client,
> > SSD1307FB_SET_COM_PINS_CONFIG); 368          if (ret < 0)
> >    369                  return ret;
> >    370 =20
> >    371          compins =3D 0x02 | (!par->com_seq & 0x1) << 4
> >    372                                     | (par->com_lrremap & 0x1)
> > << 5;
> >=20
> > Smatch is complaining because it's normally  "!par->com_seq & 0x1" is
> > a bug and "!(par->com_seq & 0x1)" is intended.  I don't know what was
> > intended here though.  If the current code is correct, you can silence
> > the static checker warning by writing it as "(!par->com_seq) & 0x1".
>=20
> Indeed "!(par->com_seq & 0x1)" is what I intended. Thanks for spotting
> this.=20
> What is the best way to handle this now? Will you send a fixup
> patch as for the backlight code or will this be my task?

Could you send a fix and give me a:

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

cookie?

regards,
dan carpenter


