From: =?utf-8?q?Hans-J=C3=BCrgen_Koch?= <hjk@linutronix.de>
Subject: Re: [Linux-fbdev-devel] Radeon X300, radeonfb, dual head
Date: Wed, 18 Apr 2007 17:02:20 +0200
Message-ID: <200704181702.21359.hjk@linutronix.de>
References: <200704181409.51475.hjk@linutronix.de>
	<1176903932.10554.248.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <xorg-bounces@lists.freedesktop.org>
In-Reply-To: <1176903932.10554.248.camel@thor.sulgenrain.local>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Michel =?utf-8?q?D=C3=A4nzer?= <michel@tungstengraphics.com>, xorg@lists.freedesktop.org

Am Mittwoch, 18. April 2007 15:45 schrieb Michel D=C3=A4nzer:
> On Wed, 2007-04-18 at 14:09 +0200, Hans-J=C3=BCrgen Koch wrote:
> >=20
> > 1.) I compiled radeonfb statically into my kernel and booted with
> > video=3Dradeonfb:1280x1024-32@60. This works fine, the framebuffer
> > console works as expected. But the X server doesn't come up
> > properly. Xorg.0.log ends like this:
> >=20
> > [...]
> > (**) RADEON(0): RADEONSaveScreen(2)
> > (**) RADEON(0): FIFO timed out: 2 entries, stat=3D0x80026102
> > (EE) RADEON(0): FIFO timed out, resetting engine...
>=20
> Please file a bug for this at http://bugs.freedesktop.org if it hasn't
> been reported yet.=20

I'll do that, but want to experiment a little bit more first.

> Does this also happen if you don't enable the DRI?

Thanks for reminding me - I didn't enable DRM in my kernel yet, so DRI
was always off. I now enabled it, and (to answer your question), this is
no issue. Even AIGLX starts up properly, but everything else is as before.

I still have the same picture on both monitors.

>=20
>=20
> > 2.) I compiled vesafb statically, radeonfb only as module. If I boot
> > with vga=3D0x318, the framebuffer console works as expected. The
> > X server starts up, Xorg.0.log looks good (except that DRI is disabled).
> >=20
> > But when kdm comes up, I see the same picture on both monitors. What I
> > see looks like the right half of the 3360x1050 desktop (mouse can be
> > moved across the left border of the screen, stops at the right border).
> > Both screens are driven properly with 1680x1050. I tried several
> > modifications of my xorg.conf, but never managed to get different
> > images on the two monitors, they always show the same.=20
>=20
> [...]
>=20
> >         Option          "MonitorLayout" "TMDS,TMDS"
>=20
> The driver doesn't support this combination yet, and it doesn't match
> your setup anyway.=20

Well, the manpage says:

CRT -- Analog CRT monitor=20
TMDS -- Desktop flat panel

So I thought the latter would be appropriate for two LCD monitors.
The manpage also doesn't mention any illegal combinations.=20

> What happens if you comment out this option or change=20
> it to "CRT,CRT"?

Nothing, no change.

Thanks,
Hans


=20
