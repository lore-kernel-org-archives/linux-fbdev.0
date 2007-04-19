From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
Subject: Re: [Linux-fbdev-devel] Radeon X300, radeonfb, dual head
Date: Thu, 19 Apr 2007 08:04:15 +0200
Message-ID: <1176962655.10554.290.camel@thor.sulgenrain.local>
References: <200704181409.51475.hjk@linutronix.de>
	<1176903932.10554.248.camel@thor.sulgenrain.local>
	<200704181702.21359.hjk@linutronix.de>
	<200704182320.46917.hjk@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <xorg-bounces@lists.freedesktop.org>
In-Reply-To: <200704182320.46917.hjk@linutronix.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
To: =?ISO-8859-1?Q?Hans-J=FCrgen?= Koch <hjk@linutronix.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, xorg@lists.freedesktop.org

On Wed, 2007-04-18 at 23:20 +0200, Hans-J=C3=BCrgen Koch wrote:
> Am Mittwoch, 18. April 2007 17:02 schrieb Hans-J=C3=BCrgen Koch:
> > Am Mittwoch, 18. April 2007 15:45 schrieb Michel D=C3=A4nzer:
> > > On Wed, 2007-04-18 at 14:09 +0200, Hans-J=C3=BCrgen Koch wrote:
> > > >=20
> > > > 1.) I compiled radeonfb statically into my kernel and booted with
> > > > video=3Dradeonfb:1280x1024-32@60. This works fine, the framebuffe=
r
> > > > console works as expected. But the X server doesn't come up
> > > > properly. Xorg.0.log ends like this:
> > > >=20
> > > > [...]
> > > > (**) RADEON(0): RADEONSaveScreen(2)
> > > > (**) RADEON(0): FIFO timed out: 2 entries, stat=3D0x80026102
> > > > (EE) RADEON(0): FIFO timed out, resetting engine...
> > >=20
> > > Please file a bug for this at http://bugs.freedesktop.org if it has=
n't
> > > been reported yet.=20
> >=20
> > I'll do that, but want to experiment a little bit more first.
>=20
> I found that compiling radeonfb into the kernel never works. X server
> is hanging at 100% CPU, almost completely blocking the system. Even
> a ssh login becomes so slow (about 30 seconds to respond to a key press=
)
> that it is practically useless.
>=20
> Should I also report this as a bug against radeonfb ?

We should rule out an X driver or DRM bug first, so we need to see the
full X log file for this case.


--=20
Earthling Michel D=C3=A4nzer           |          http://tungstengraphics=
.com
Libre software enthusiast         |          Debian, X and DRI developer
