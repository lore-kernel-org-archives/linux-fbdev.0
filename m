From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Sat, 23 May 2015 17:32:45 +0000
Subject: re: fbdev: ssd1307fb: Unify init code and obtain hw specific bits from DT
Message-Id: <20150523173245.GA31663@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hello Thomas Niederpr=FCm,

The patch a3998fe03e87: "fbdev: ssd1307fb: Unify init code and obtain
hw specific bits from DT" from Mar 31, 2015, leads to the following
static checker warning:

	drivers/video/fbdev/ssd1307fb.c:371 ssd1307fb_init()
	warn: add some parenthesis here?

drivers/video/fbdev/ssd1307fb.c
   366          /* Set COM pins configuration */
   367          ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_SET_COM_=
PINS_CONFIG);
   368          if (ret < 0)
   369                  return ret;
   370 =20
   371          compins =3D 0x02 | (!par->com_seq & 0x1) << 4
   372                                     | (par->com_lrremap & 0x1) << 5;

Smatch is complaining because it's normally  "!par->com_seq & 0x1" is
a bug and "!(par->com_seq & 0x1)" is intended.  I don't know what was
intended here though.  If the current code is correct, you can silence
the static checker warning by writing it as "(!par->com_seq) & 0x1".

But I also have a hard time remembering if | or << is higher precedence
so that might be clearer with parenthesis as well even though the code
is clearly correct when I google for "order of operations" in C.

   373          ret =3D ssd1307fb_write_cmd(par->client, compins);
   374          if (ret < 0)
   375                  return ret;

regards,
dan carpenter
