From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 2/4] fbdev: Add
	fb_append_extra_logo()
Date: Fri, 13 Jul 2007 14:02:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0707131356590.18802@pademelon.sonytel.be>
References: <20070710122702.765654000@pademelon.sonytel.be>
	<20070710123540.678435000@pademelon.sonytel.be>
	<1184285757.4566.11.camel@daplas>
	<Pine.LNX.4.62.0707130855360.15603@pademelon.sonytel.be>
	<1184327134.4702.6.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1533421621-1184328176=:18802"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I9Jrb-000615-8N for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 05:03:11 -0700
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I9JrX-0000y8-O7
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 05:03:11 -0700
In-Reply-To: <1184327134.4702.6.camel@daplas>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Geoff Levand <geoffrey.levand@am.sony.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, James Simmons <jsimmons@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, cbe-oss-dev@ozlabs.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1533421621-1184328176=:18802
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Jul 2007, Antonino A. Daplas wrote:
> On Fri, 2007-07-13 at 08:56 +0200, Geert Uytterhoeven wrote:
> > On Fri, 13 Jul 2007, Antonino A. Daplas wrote:
> > > On Tue, 2007-07-10 at 14:27 +0200, Geert Uytterhoeven wrote:
> > > > --- a/drivers/video/fbmem.c
> > > > +++ b/drivers/video/fbmem.c
> > > > @@ -318,6 +318,13 @@ static struct logo_data {
> > > >  	const struct linux_logo *logo;
> > > >  } fb_logo __read_mostly;
> > > > =20
> > > > +#define FB_LOGO_EX_NUM_MAX 10
> > > > +static struct logo_data_extra {
> > > > +	const struct linux_logo *logo;
> > > > +	unsigned int n;
> > > > +} fb_logo_ex[FB_LOGO_EX_NUM_MAX];
> > > > +static unsigned int fb_logo_ex_num;
> > > > +
> > > >  static void fb_rotate_logo_ud(const u8 *in, u8 *out, u32 width, =
u32 height)
> > > >  {
> > > >  	u32 size =3D width * height, i;
> > > > @@ -411,10 +418,22 @@ static void fb_do_show_logo(struct fb_in
> > > >  	}
> > > >  }
> > > > =20
> > > > +#ifdef CONFIG_FB
> > >=20
> > > The #ifdef is redundant.
> >=20
> > IIRC, it's needed for the CONFIG_FB=3Dm case.
>=20
> What would happen if CONFIG_FB=3Dm? (We already have a patch that preve=
nts
> logo drawing if the driver or fbcon is modular)

Then we use the dummy fb_append_extra_logo() in <linux/linux_logo.h>.

With kind regards,
=20
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village =C2=B7 Da Vincilaan 7-D1 =C2=B7 B-1935 Zaventem =C2=
=B7 Belgium
=20
Phone:    +32 (0)2 700 8453=09
Fax:      +32 (0)2 700 8622=09
E-mail:   Geert.Uytterhoeven@sonycom.com=09
Internet: http://www.sony-europe.com/
 =09
Sony Network and Software Technology Center Europe=09
A division of Sony Service Centre (Europe) N.V.=09
Registered office: Technologielaan 7 =C2=B7 B-1840 Londerzeel =C2=B7 Belg=
ium=09
VAT BE 0413.825.160 =C2=B7 RPR Brussels=09
Fortis Bank Zaventem =C2=B7 Swift GEBABEBB08A =C2=B7 IBAN BE3900138235861=
9
---584337861-1533421621-1184328176=:18802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
---584337861-1533421621-1184328176=:18802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

---584337861-1533421621-1184328176=:18802--
