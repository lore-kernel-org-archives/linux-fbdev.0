From: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 19 Jan 2017 16:33:14 +0000
Subject: Re: [PATCH v10 3/4] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <20170119163314.GD22777@kroah.com>
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
Cc: jslaby@suse.com, kilobyte@angband.pl, lkml14@scotdoyle.com, rdunlap@infradead.org, shorne@gmail.com, andrey_utkin@fastmail.com, akpm@linux-foundation.org, paul.burton@imgtec.com, daniel.vetter@ffwll.ch, tj@kernel.org, hdegoede@redhat.com, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thu, Jan 19, 2017 at 05:12:15PM +0100, Manuel Sch=F6lling wrote:
> On Thu, 2017-01-19 at 14:23 +0100, Greg KH wrote:
> > On Fri, Jan 13, 2017 at 09:07:57PM +0100, Manuel Sch=F6lling wrote:
> > > Add a scrollback buffers for each VGA console. The benefit is that
> > > the scrollback history is not flushed when switching between
> > > consoles
> > > but is persistent.
> > > The buffers are allocated on demand when a new console is opened.
> > >=20
> > > This breaks tools like clear_console that rely on flushing the
> > > scrollback history by switching back and forth between consoles
> > > which is why this feature is disabled by default.
> > > Use the escape sequence \e[3J instead for flushing the buffer.
> > >=20
> > > Signed-off-by: Manuel Sch=F6lling <manuel.schoelling@gmx.de>
> > > Reviewed-by: Andrey Utkin <andrey_utkin@fastmail.com>
> > > Tested-by: Andrey Utkin <andrey_utkin@fastmail.com>
> > > Tested-by: Adam Borowski <kilobyte@angband.pl>
> > > ---
> > > =A0drivers/video/console/Kconfig=A0=A0|=A0=A025 +++++++-
> > > =A0drivers/video/console/vgacon.c | 142 ++++++++++++++++++++++++++---
> > > ------------
> > > =A02 files changed, 111 insertions(+), 56 deletions(-)
> > >=20
> > > diff --git a/drivers/video/console/Kconfig
> > > b/drivers/video/console/Kconfig
> > > index c3f1fb9ee820..f500e58f7636 100644
> > > --- a/drivers/video/console/Kconfig
> > > +++ b/drivers/video/console/Kconfig
> > > @@ -43,9 +43,28 @@ config VGACON_SOFT_SCROLLBACK_SIZE
> > > =A0=A0=A0=A0=A0=A0=A0=A0range 1 1024
> > > =A0=A0=A0=A0=A0=A0=A0=A0default "64"
> > > =A0=A0=A0=A0=A0=A0=A0=A0help
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0Enter the amount of System RAM to allocat=
e for the
> > > scrollback
> > > -	=A0buffer.=A0=A0Each 64KB will give you approximately 16 80x25
> > > -	=A0screenfuls of scrollback buffer
> > > +	=A0=A0Enter the amount of System RAM to allocate for
> > > scrollback
> > > +	=A0=A0buffers of VGA consoles. Each 64KB will give you
> > > approximately
> > > +	=A0=A016 80x25 screenfuls of scrollback buffer.
> > > +
> > > +config VGACON_SOFT_SCROLLBACK_PERSISTENT
> > > +	bool "Persistent Scrollback History for each console"
> > > +	depends on VGACON_SOFT_SCROLLBACK
> > > +	default n
> > > +	help
> > > +	=A0=A0Say Y here if the scrollback history should persist when
> > > switching
> > > +	=A0=A0between consoles. Otherwise, the scrollback history will
> > > be flushed
> > > +	=A0=A0each time the console is switched.
> > > +
> > > +	=A0=A0This feature might break your tool of choice to flush
> > > the scrollback
> > > +	=A0=A0buffer, e.g. clear(1) will work fine but Debian's
> > > clear_console(1)
> > > +	=A0=A0will be broken, which might cause security issues.
> > > +	=A0=A0You can use the escape sequence \e[3J instead if this
> > > feature is
> > > +	=A0=A0activated.
> >=20
> > This issue is the one that makes me the most worried.=A0=A0Why doesn't
> > clear_console() work anymore?=A0=A0Why doesn't it use \e[3J ?
>=20
> Well, clear_console() just switches from one console to another and
> back again. It just assumes that the scrollback buffer is flushed when
> switching.
> My plan is to make a patch for clear_console() as soon as these patches
> are in the kernel - it's chicken-and-egg problem.

I'd recommend that patch get to clear_console() first, having it use the
new escape sequence, if it isn't supported, shouldn't cause any
problems, right?

thanks,

greg k-h
