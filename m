From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Add fb_check_var() for fixed mode
 device.
Date: Fri, 29 Aug 2008 14:16:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0808291127510.18326@anakin>
References: <48B4E16C.4000107@renesas.com>
	<Pine.LNX.4.64.0808270855110.7910@anakin>
	<g94i4r$2hq$1@ger.gmane.org> <20080828074521.GO16680@sci.fi> 
	<48B785DA.1030408@renesas.com>
	<1219999758.4421.259.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463808415-1213681410-1220002728=:18326"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KZ2uP-0004Sy-Sf for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 05:16:58 -0700
Received: from nelson.telenet-ops.be ([195.130.133.66])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KZ2uN-0006Go-6T
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 05:16:57 -0700
In-Reply-To: <1219999758.4421.259.camel@thor.sulgenrain.local>
Content-ID: <Pine.LNX.4.64.0808291403050.18326@anakin>
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
Cc: Helge Deller <deller@gmx.de>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, =?UTF-8?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463808415-1213681410-1220002728=:18326
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-ID: <Pine.LNX.4.64.0808291403051.18326@anakin>
Content-Transfer-Encoding: quoted-printable

On Fri, 29 Aug 2008, Michel D=E4nzer wrote:
> On Fri, 2008-08-29 at 14:15 +0900, Takashi Yoshii wrote:
> > +	/* bigger is error, smaller is OK */
> > +	if( ( var->xres > constant->xres )
> > +	  ||( var->yres > constant->yres )
>=20
> The resolution must match, otherwise userspace thinks it can e.g. set
> 800x600 when the fixed mode is 1024x768.

It will be set later to the correct resolution. The above hunk just taks
care of the rounding rules.

Anyway, I'm still wondering whether this check is really needed. If your
application doesn't look at how fb_var_screeninfo was changed by calling
FBIOPUT_VSCREENINFO, you're in deep trouble anyway, due to the rounding
rules.

As I don't have access to a PA-RISC machine with the mentioned hardware,
I modified ps3fb by commenting out its fb_check_var() and fb_set_par()
routines (this also gave a black screen, but as far as the fbdev subsyste=
m
is concerned, it has a working frame buffer device that supports one sing=
le
video mode only). Surprisingly, X indeed didn't like it:

| X.Org X Server 1.4.2
| Release Date: 11 June 2008
| X Protocol Version 11, Revision 0
| Build Operating System: Linux Debian (xorg-server 2:1.4.2-3)
| Current Operating System: Linux ps3 2.6.27-rc4-00176-gb8e6c91-dirty #18=
15 SMP Fri Aug 29 13:54:57 CEST 2008 ppc64
| Build Date: 03 August 2008  03:08:04AM
| =20
|         Before reporting problems, check http://wiki.x.org
|         to make sure that you have the latest version.
| Module Loader present
| Markers: (--) probed, (**) from config file, (=3D=3D) default setting,
|         (++) from command line, (!!) notice, (II) informational,
|         (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
| (=3D=3D) Log file: "/var/log/Xorg.0.log", Time: Fri Aug 29 13:57:26 200=
8
| (=3D=3D) Using config file: "/etc/X11/xorg.conf"
| (EE) FBDEV(0): FBIOPUT_VSCREENINFO succeeded but modified mode
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
| (EE) FBDEV(0): mode initialization failed
|=20
| Fatal server error:
| AddScreen/ScreenInit failed for driver 0

The "Screen" / "Display" (sub)section has `Modes "1920x1200"'. Removing
this indeed doesn't make a difference.

As I had added debug code to drivers/video/fbmem.c:fb_set_var(), I could
see what happened in the working version with mode-setting vs. the non-wo=
rking
version without modesetting:
  - working, with mode-setting:
      o fb_set_var() fails for the standard 1920x1200 mode in the Xorg
        database,
      o X fallbacks to the current 1920x1200 mode.
  - non-working, without modesetting:
      o fb_set_var() doesn't fail for the standard 1920x1200 mode in the
        Xorg database, but it returns the current 1920x1200 mode,
      o X complains that the mode got modified.

Hence Xorg is broken on all embedded devices with a frame buffer driver
that supports a single fixed video mode only?

BTW, I know current Xorg is broken on several m68k platforms with non-chu=
nky
frame buffer layouts, due to some serious bugs in the way some uncommon v=
alues
of frame buffer parameters are handled, but IIRC they shouldn't affect
`common' chunky frame buffers. Still have to look into it to fix it prope=
rly
(anyone who can donate me some spare time? ;-)

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
---1463808415-1213681410-1220002728=:18326
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
---1463808415-1213681410-1220002728=:18326
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

---1463808415-1213681410-1220002728=:18326--
