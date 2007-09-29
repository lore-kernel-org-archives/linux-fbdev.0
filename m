From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [Cbe-oss-dev] [patch 0/8] PS3 AV Settings
 Driver patches for 2.6.24
Date: Sat, 29 Sep 2007 10:00:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0709290957580.21636@pademelon.sonytel.be>
References: <20070926163308.772580000@pademelon.sonytel.be> 
	<1190860285.6502.6.camel@concordia> <46FBE6FD.3030605@am.sony.com>
	<1190968833.15970.3.camel@concordia> <46FD5604.3060104@am.sony.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1157957658-1191052813=:21636"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IbXFP-0004Du-FR for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 29 Sep 2007 01:00:26 -0700
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IbXFN-0007ar-So
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 29 Sep 2007 01:00:23 -0700
In-Reply-To: <46FD5604.3060104@am.sony.com>
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
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: michael@ellerman.id.au, linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org, "Antonino A. Daplas" <adaplas@gmail.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1157957658-1191052813=:21636
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Sep 2007, Geoff Levand wrote:
> Michael Ellerman wrote:
> > On Thu, 2007-09-27 at 10:23 -0700, Geoff Levand wrote:
> >> Michael Ellerman wrote:
> >> > On Wed, 2007-09-26 at 18:33 +0200, Geert Uytterhoeven wrote:
> >> >> Question: As several DVI-D displays advertise they support 1080i =
modes while
> >> >> they actually don't (cfr. the quirk database), perhaps I should d=
rop 1080i
> >> >> modes completely from the ps3av_preferred_modes[] table? Usually =
720p looks
> >> >> better than 1080i anyway.  What do you think?
> >> >=20
> >> > Definitely. If the autodetection fails Linux is basically unusable=
 on
> >> > PS3 unless you hack the kernel sources and build your own kboot an=
d
> >> > otheros.bld - not entirely trivial for novice users. So it's prett=
y
> >> > important that it works 100%.
> >>=20
> >> It is not that bad.  If a bootloader is configued to use autodetecti=
on
> >> so that it is shown at best video mode, then it should have advertis=
ed
> >> key sequences to default to known video modes, with at least a 480p =
'safe'
> >> mode.
> >=20
> > Oh OK, that is a good idea. What's the "safe mode" key sequence for t=
he
> > otheros.bld you provide on kernel.org?
>=20
> I don't maintain that, and have no idea how it sets its video mode.  Di=
d you
> have trouble with it?  I know in the past it used a fixed 480p mode.=20

It uses the autodetect mode. In the past, the kernel defaulted to 480p fo=
r
DVI-D/HDMI displays, 480i for other displays.

So far no one complained about the new otheros.bld (AFAIK). Which doesn't=
 mean
that (a) the problem doesn't happen and (b) it wouldn't be nice to have a=
 `safe
mode' key sequence...

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
---584337861-1157957658-1191052813=:21636
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
---584337861-1157957658-1191052813=:21636
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

---584337861-1157957658-1191052813=:21636--
