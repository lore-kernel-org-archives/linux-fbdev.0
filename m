From: Adam Borowski <kilobyte@angband.pl>
Date: Fri, 20 Jan 2017 13:16:11 +0000
Subject: Re: [PATCH v10 3/4] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <20170120131611.afzupatjx4y7vcwv@angband.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201701112105.R6Zog6jw%fengguang.wu@intel.com>
 <20170113200758.9880-4-manuel.schoelling@gmx.de>
 <20170119132352.GB29998@kroah.com>
 <1484842335.1250.7.camel@gmx.de>
 <20170119163314.GD22777@kroah.com>
 <20170119230412.ekq3uhdmdvdjqoed@angband.pl>
In-Reply-To: <20170119230412.ekq3uhdmdvdjqoed@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Manuel =?iso-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>, jslaby@suse.com, lkml14@scotdoyle.com, rdunlap@infradead.org, shorne@gmail.com, andrey_utkin@fastmail.com, akpm@linux-foundation.org, paul.burton@imgtec.com, daniel.vetter@ffwll.ch, tj@kernel.org, hdegoede@redhat.com, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Fri, Jan 20, 2017 at 12:04:12AM +0100, Adam Borowski wrote:
> On Thu, Jan 19, 2017 at 05:33:14PM +0100, Greg KH wrote:
> > On Thu, Jan 19, 2017 at 05:12:15PM +0100, Manuel Sch=F6lling wrote:
> > > On Thu, 2017-01-19 at 14:23 +0100, Greg KH wrote:
> > > > On Fri, Jan 13, 2017 at 09:07:57PM +0100, Manuel Sch=F6lling wrote:
> > > > > +	=A0=A0This feature might break your tool of choice to flush
> > > > > the scrollback
> > > > > +	=A0=A0buffer, e.g. clear(1) will work fine but Debian's
> > > > > clear_console(1)
> > > > > +	=A0=A0will be broken, which might cause security issues.
> > > > > +	=A0=A0You can use the escape sequence \e[3J instead if this
> > > > > feature is
> > > > > +	=A0=A0activated.
> >=20
> > I'd recommend that patch get to clear_console() first, having it use the
> > new escape sequence, if it isn't supported, shouldn't cause any
> > problems, right?
>=20
> doko: would you consider, pretty please with a cherry on top, applying the
> patch I've sent to this bug?  The privacy/security issue is pretty minor =
and
> applies only to a tiny fraction of users, but I understand why Greg is
> reluctant.

# Subject: Bug#845177 closed by Matthias Klose <doko@debian.org>
#
# This is an automatic notification regarding your Bug report
# which was filed against the bash package:
#
# #845177: clear_console: assumes VT switch clears scrollback
#
# It has been closed by Matthias Klose <doko@debian.org>.
[...]
# Changes:
#    * clear_console: Securely erase the current console. Closes: #845177.

--=20
Autotools hint: to do a zx-spectrum build on a pdp11 host, type:
  ./configure --host=3Dzx-spectrum --build=3Dpdp11
