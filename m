From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: mono, gray and index configs
Date: Mon, 22 Aug 2005 11:57:10 -0400
Message-ID: <9e4733910508220857192a579@mail.gmail.com>
References: <9e47339105081020216574ac7e@mail.gmail.com>
	 <42FAE3F8.8080902@gmail.com>
	 <Pine.LNX.4.62.0508111020520.1037@numbat.sonytel.be>
	 <b00ca3bd05081104086fa9e639@mail.gmail.com>
	 <Pine.LNX.4.62.0508111344070.1037@numbat.sonytel.be>
	 <42FB8C29.4070503@gmail.com>
	 <9e47339105081112142c67e1a8@mail.gmail.com> <43069BE0.80604@gmail.com>
	 <9e473391050819200950020d7@mail.gmail.com>
	 <Pine.LNX.4.62.0508221203410.24432@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E7Efq-0001tH-PP
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Aug 2005 08:57:22 -0700
Received: from wproxy.gmail.com ([64.233.184.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E7Efp-0002zj-11
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Aug 2005 08:57:23 -0700
Received: by wproxy.gmail.com with SMTP id i3so960211wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Aug 2005 08:57:10 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0508221203410.24432@numbat.sonytel.be>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On 8/22/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, 19 Aug 2005, Jon Smirl wrote:
> > The patch is just for testing, don't send it on. The radeonfb portion
> > is definitely not finished.
> >
> > This adds an optional function to each driver that advertises what
> > configs it offers.
> >
> > +char *radeonfb_getconfigs(struct fb_info *info)
> > +{
> > +     return "I4\nI8\nA1R5G5B5\nR5G6B5\nR8G8B8\nA8R8G8B8\nA4R4G4B4\nA8I=
8\nA2R10G10B10\n";
> > +}
> >
> >   static struct fb_ops radeonfb_ops =3D {
> >       .owner                  =3D THIS_MODULE,
> > @@ -1873,6 +1909,7 @@ static struct fb_ops radeonfb_ops =3D {
> >       .fb_fillrect            =3D radeonfb_fillrect,
> >       .fb_copyarea            =3D radeonfb_copyarea,
> >       .fb_imageblit           =3D radeonfb_imageblit,
> > +     .fb_get_configs         =3D radeonfb_getconfigs,
> >  };
>=20
> Do we really need this?

It is optional. It's used in sysfs, where you cat the config variable
to get a list of valid configs. Once in sysfs a program could then use
it to generate a list to pick from, etc...

It seems hard to use the search method if you are looking for a config
that is in the middle of the list.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
