From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Some questions
Date: Wed, 12 Mar 2003 09:24:59 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0303120921500.7675-100000@vervain.sonytel.be>
References: <1047432552.1348.94.camel@thor>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18t1ZD-00069V-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Mar 2003 00:26:28 -0800
In-Reply-To: <1047432552.1348.94.camel@thor>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Antonino Daplas <adaplas@pol.net>, Thomas Winischhofer <thomas@winischhofer.net>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On 12 Mar 2003, Michel [ISO-8859-1] D=E4nzer wrote:
> On Mit, 2003-03-12 at 02:02, Antonino Daplas wrote:
> > On Wed, 2003-03-12 at 08:07, Michel D=E4nzer wrote:
> > > On Die, 2003-03-11 at 23:51, Antonino Daplas wrote:
> > > > On Wed, 2003-03-12 at 06:23, Thomas Winischhofer wrote:
> > > > > >=20
> > > > > > I actually prefer #3, and I already have working code for thi=
s.  We can
> > > > > > also make this driver switchable (ie, drivers that are not af=
fected by X
> > > > > > can disable this, and only drivers that are affected such as =
the riva,
> > > > > > aty, radeon, etc can turn this on).
> > > > >=20
> > > > > What exactly is a "trusted" console?
> > > >=20
> > > > By default, the pid of each vt is -1.  When X loads, it installs =
its own
> > > > VT (ie vt7), which in that case the pid of that particular vt =3D=
=3D X's
> > > > pid.  We can check this pid, and if switching from a vt with pid =
=3D=3D -1,
> > > > we can safely assume that the hardware state is still sane, and i=
f not,
> > > > assume the hardware state is undefined.
> > >=20
> > > Can you also detect when the app has opened the framebuffer device,=
 and
> > > assume it's playing nice when it has? (for Option "UseFBDev")
> >=20
> > X using fbdev will also have the same limitation. I have implemented
> > something like this before.  For each fb_open, the current->pid can b=
e
> > saved into a "white list" and removed for each fb_close.  fbcon can t=
hen
> > compare this to the pid of the vt it's switching from.

The application cannot play not nice unless it mmap()s the MMIO registers=
. To
be able to do that, it first has to clear FB_ACCELF_TEXT in var.accel_fla=
gs.

> > This is becoming to sound very ugly though.  I guess, the best way is=
 to
> > really support Option "UseFBDev", or at least have the user decide if
> > he/she wants to have the hardware refreshed. =20
>=20
> I'm afraid I don't understand what you're saying here.

But I think you do agree :-) He says that if fbdev is active, the X serve=
r has
to be fbdev compliant and thus not mess with the hardware where it's not
allowed to.

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



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
