From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Add fb_check_var() for fixed mode
 device.
Date: Fri, 29 Aug 2008 16:14:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0808291610230.18326@anakin>
References: <48B4E16C.4000107@renesas.com>
	<Pine.LNX.4.64.0808270855110.7910@anakin>
	<g94i4r$2hq$1@ger.gmane.org> <20080828074521.GO16680@sci.fi> 
	<48B785DA.1030408@renesas.com>
	<1219999758.4421.259.camel@thor.sulgenrain.local>
	<Pine.LNX.4.64.0808291127510.18326@anakin>
	<1220017912.4421.291.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463808415-1381533590-1220019299=:18326"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KZ4kj-0007kL-U2 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 07:15:06 -0700
Received: from edna.telenet-ops.be ([195.130.132.58])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KZ4ki-00022g-V3
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 07:15:05 -0700
In-Reply-To: <1220017912.4421.291.camel@thor.sulgenrain.local>
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
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
Cc: Helge Deller <deller@gmx.de>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Ville Syrj?l? <syrjala@sci.fi>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463808415-1381533590-1220019299=:18326
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 29 Aug 2008, Michel D=E4nzer wrote:
> On Fri, 2008-08-29 at 14:16 +0200, Geert Uytterhoeven wrote:
> >=20
> > | X.Org X Server 1.4.2
>=20
> [...]
>=20
> > | (EE) FBDEV(0): FBIOPUT_VSCREENINFO succeeded but modified mode
>=20
> [...]
>=20
> > Hence Xorg is broken on all embedded devices with a frame buffer driv=
er
> > that supports a single fixed video mode only?
>=20
> No. As discussed before, you're probably missing
>=20
> http://cgit.freedesktop.org/xorg/xserver/commit/?id=3Dc095da04fe7c73b65=
03ef5b93549b13796c51b22
>=20
> which is in the upcoming xserver 1.5 release.

Ah, upcoming. That's not current/previous/... ;-)

> (BTW, would you happen to remember what the magic pixclock value was
> there for in the first place? :)

To avoid a division by zero exception? I guess I just took a value that
looked sensible.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org

In personal conversations with technical people, I call myself a hacker. =
But
when I'm talking to journalists I just say "programmer" or something like=
 that.
							    -- Linus Torvalds
---1463808415-1381533590-1220019299=:18326
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
---1463808415-1381533590-1220019299=:18326
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

---1463808415-1381533590-1220019299=:18326--
