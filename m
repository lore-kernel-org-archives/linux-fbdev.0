From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [Cbe-oss-dev] [patch 0/8] PS3 AV Settings Driver patches for
	2.6.24
Date: Thu, 27 Sep 2007 13:53:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0709271344130.10467@pademelon.sonytel.be>
References: <20070926163308.772580000@pademelon.sonytel.be>
	<1190860285.6502.6.camel@concordia>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1091693748-1190893984=:10467"
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <1190860285.6502.6.camel@concordia>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Michael Ellerman <michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org, "Antonino A. Daplas" <adaplas@gmail.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1091693748-1190893984=:10467
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Sep 2007, Michael Ellerman wrote:
> On Wed, 2007-09-26 at 18:33 +0200, Geert Uytterhoeven wrote:
> > Here are some new patches for the PS3 AV Settings Driver (ps3av), whi=
ch is
> > used in close collaboration with the PS3 Virtual Frame Buffer Device =
Driver
> > (ps3fb):
> >   [1] ps3av: eliminate unneeded temporary variables
> >   [2] ps3av: eliminate PS3AV_DEBUG
> >   [3] ps3av: use PS3 video mode ids in autodetect code
> >   [4] ps3av: treat DVI-D like HDMI in autodetect
> >   [5] ps3av: add autodetection for VESA modes
> >   [6] ps3av: add quirk database for broken monitors
> >   [7] ps3av: remove unused ps3av_set_mode()
> >   [8] ps3av: don't distinguish between `boot' and `non-boot' autodete=
ction
> >=20
> > Please review, and queue for 2.6.24 if they're ok. Thanks!
> >=20
> > Question: As several DVI-D displays advertise they support 1080i mode=
s while
> > they actually don't (cfr. the quirk database), perhaps I should drop =
1080i
> > modes completely from the ps3av_preferred_modes[] table? Usually 720p=
 looks
> > better than 1080i anyway.  What do you think?
>=20
> Definitely. If the autodetection fails Linux is basically unusable on
> PS3 unless you hack the kernel sources and build your own kboot and
> otheros.bld - not entirely trivial for novice users. So it's pretty
> important that it works 100%.

Well, this code has been in Geoff's git tree for a while, and it's been s=
everal
weeks ago I got complaints (which have been adressed by adding displays t=
o the
quirk database). The new kboot (from Distro Kit 1.4.1) also uses it.

The only 100% (sic) mode is 480p (actual usable resolution is 576x384), w=
hich
is quite limited due to the very low resolution. This is what the current
mainline kernel uses by default, causing complaints from people who don't=
 like
their shiny expensive full-HD displays being driven by 480p by default.

Furthermore Geoff is working on a way to configure the video mode for
otheros.bld (cfr. the tool to change the default kernel command line on a=
n
ia32 kernel image ages ago), and petitboot (which is intended to replace =
the
current kboot boot loader environment) allows to change the video mode us=
ing
a simple key press if you get a blank screen.

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
---584337861-1091693748-1190893984=:10467
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
---584337861-1091693748-1190893984=:10467--
