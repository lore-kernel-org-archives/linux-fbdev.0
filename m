From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 0/4] Cell SPE logos
Date: Fri, 13 Jul 2007 10:52:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0707131051190.18802@pademelon.sonytel.be>
References: <20070710122702.765654000@pademelon.sonytel.be>
	<20070712160621.644d78d2.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-588761602-1184316730=:18802"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I9Gss-0001HU-Qg for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 01:52:19 -0700
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I9Gsr-0000gf-Bf
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 01:52:18 -0700
In-Reply-To: <20070712160621.644d78d2.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>, cbe-oss-dev@ozlabs.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-588761602-1184316730=:18802
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Jul 2007, Andrew Morton wrote:
> On Tue, 10 Jul 2007 14:27:02 +0200
> Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
>=20
> > The Cell Broadband Engine contains a 64-bit PowerPC core with 2 hardw=
are
> > threads (called PPEs) and 8 Synergistic Processing Engines (called SP=
Es).
> > When booting Linux, 2 penguins logos are shown on the graphical conso=
le by
> > the standard frame buffer console logo code.
> >=20
> > To emphasize the existence of the SPEs (which can be used under Linux=
), we
> > added a second row of (smaller) helper penguin logos, one for each SP=
E.
> >=20
> > A sample screenshot can be found at
> > http://www.kernel.org/pub/linux/kernel/people/geoff/cell/debian-pengu=
in-shot.png
> > (or on the ps3linux T-shirts we wore at OLS :-)
>=20
> Does this mean I'll get penguins on my PS3 now?

Sure!

> > Summaries:
> >   [1] fbdev: extract fb_show_logo_line()
> >   [2] fbdev: Add fb_append_extra_logo()
>=20
> This one does give additional code and data to all fbdev users while on=
ly
> being useful to cell machines.  Should we fix that?

I can protect it by #ifdef CONFIG_PPC_CELL (as long as there are no other
users). Would that be OK?

> >   [3] fbdev: SPE helper penguin logo
> >   [4] Cell: Draw SPE helper penguin logos
>=20
> I queued #4 up along with the fbdev patches, even though it isn't reall=
y an
> fbdev patch.

OK, thanks!

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
---584337861-588761602-1184316730=:18802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
---584337861-588761602-1184316730=:18802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

---584337861-588761602-1184316730=:18802--
