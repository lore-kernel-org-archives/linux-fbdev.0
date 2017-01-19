From: Adam Borowski <kilobyte@angband.pl>
Date: Thu, 19 Jan 2017 17:20:52 +0000
Subject: Re: [PATCH v10 3/4] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <20170119172052.272qttos3rlmbxvl@angband.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201701112105.R6Zog6jw%fengguang.wu@intel.com>
 <20170113200758.9880-4-manuel.schoelling@gmx.de>
 <20170119132352.GB29998@kroah.com>
 <1484842335.1250.7.camel@gmx.de>
In-Reply-To: <1484842335.1250.7.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Manuel =?iso-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com, lkml14@scotdoyle.com, rdunlap@infradead.org, shorne@gmail.com, andrey_utkin@fastmail.com, akpm@linux-foundation.org, paul.burton@imgtec.com, daniel.vetter@ffwll.ch, tj@kernel.org, hdegoede@redhat.com, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thu, Jan 19, 2017 at 05:12:15PM +0100, Manuel Sch=F6lling wrote:
> On Thu, 2017-01-19 at 14:23 +0100, Greg KH wrote:
> > On Fri, Jan 13, 2017 at 09:07:57PM +0100, Manuel Sch=F6lling wrote:
> > > Add a scrollback buffers for each VGA console.  The benefit is that
> > > the scrollback history is not flushed when switching between consoles
> > > but is persistent.  The buffers are allocated on demand when a new
> > > console is opened.
> > >=20
> > > This breaks tools like clear_console that rely on flushing the
> > > scrollback history by switching back and forth between consoles
> > > which is why this feature is disabled by default.
> > > Use the escape sequence \e[3J instead for flushing the buffer.
> >=20
> > This issue is the one that makes me the most worried.=A0=A0Why doesn't
> > clear_console() work anymore?=A0=A0Why doesn't it use \e[3J ?
>=20
> Well, clear_console() just switches from one console to another and
> back again. It just assumes that the scrollback buffer is flushed when
> switching.
> My plan is to make a patch for clear_console() as soon as these patches
> are in the kernel - it's chicken-and-egg problem.

No need to wait, \e[3J is supported since Linux 2.6.39; the problem I
spotted was that a previous version of your patch would break that.

It is also safe to output that sequence to a terminal unconditionally: I've
tested a number of terminals, they all either support it (most X terminals,
our console) or silently ignore it.

We can't, though, rely on terminfo to do so: it knows about this capability
(which it calls "E3") for TERM=3Dlinux only since very recently.  The TERM
variable is also unreliable: it fails to carry over a serial link while
blindly printing \e[3J works.

As for patching clear_console, https://bugs.debian.org/845177 has a minimal
fix; although for all setups supported by Debian that program could be be
better replaced with just "printf '\e[3J\e[2J'" which would make it work on
strictly more terminals than current code does.  Same for distributions
which copied clear_console (it originates from Ubuntu, maintained in Debian
since then).


Meow!
--=20
Autotools hint: to do a zx-spectrum build on a pdp11 host, type:
  ./configure --host=3Dzx-spectrum --build=3Dpdp11
