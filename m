From: "Alex Deucher" <alexdeucher@gmail.com>
Subject: Re: [Linux-fbdev-devel] Radeon X300, radeonfb, dual head
Date: Wed, 18 Apr 2007 16:45:25 -0500
Message-ID: <a728f9f90704181445x95f493bj2ab639394bc22139@mail.gmail.com>
References: <200704181409.51475.hjk@linutronix.de>
	<1176903932.10554.248.camel@thor.sulgenrain.local>
	<200704181702.21359.hjk@linutronix.de>
	<200704182320.46917.hjk@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <xorg-bounces@lists.freedesktop.org>
In-Reply-To: <200704182320.46917.hjk@linutronix.de>
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
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: xorg@lists.freedesktop.org

On 4/18/07, Hans-J=FCrgen Koch <hjk@linutronix.de> wrote:
> Am Mittwoch, 18. April 2007 17:02 schrieb Hans-J=FCrgen Koch:
> > Am Mittwoch, 18. April 2007 15:45 schrieb Michel D=E4nzer:
> > > On Wed, 2007-04-18 at 14:09 +0200, Hans-J=FCrgen Koch wrote:
> > > >
> > > > 1.) I compiled radeonfb statically into my kernel and booted with
> > > > video=3Dradeonfb:1280x1024-32@60. This works fine, the framebuffer
> > > > console works as expected. But the X server doesn't come up
> > > > properly. Xorg.0.log ends like this:
> > > >
> > > > [...]
> > > > (**) RADEON(0): RADEONSaveScreen(2)
> > > > (**) RADEON(0): FIFO timed out: 2 entries, stat=3D0x80026102
> > > > (EE) RADEON(0): FIFO timed out, resetting engine...
> > >
> > > Please file a bug for this at http://bugs.freedesktop.org if it hasn'=
t
> > > been reported yet.
> >
> > I'll do that, but want to experiment a little bit more first.
>
> I found that compiling radeonfb into the kernel never works. X server
> is hanging at 100% CPU, almost completely blocking the system. Even
> a ssh login becomes so slow (about 30 seconds to respond to a key press)
> that it is practically useless.
>
> Should I also report this as a bug against radeonfb ?
>
> I don't have that effect with vesafb. I also disabled framebuffer support
> completely and booted with a VGA console, this also works.
>
> But even with vesafb or VGA, the X server shows the same picture on
> both monitors. It starts without errors, even AIGLX comes up,
> glxgears says 1400fps (Core2Duo@1.86GHz).
> KDE control center shows the settings as they should be, and in fact
> the X server uses a screen with 3360x1050. But instead of displaying
> the left half on the left monitor and the right half on the right,
> it shows the right half on both monitors.
>
> Could it be possible that X in fact draws both halves correctly, but
> some "internal switch" connects both connectors to the same output?
>
> Could it be a problem that I use a DVI-VGA-adaptor for one of the
> monitors? I don't get a digital DVI signal at that output, is this
> normal?
>
> Any ideas?

Can you post your full Xorg log and the config you are using?  Also
what release of the Xserver and radeon driver are you using?

Alex
