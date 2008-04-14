From: Andres Salomon <dilinger@queued.net>
Subject: Re: OLPC: gxfb/lxfb: add DCON panel modes to framebuffer drivers
Date: Mon, 14 Apr 2008 11:33:33 -0400
Message-ID: <20080414113333.2ce51648@ephemeral>
References: <20080414035302.794dcd7a@ephemeral>
	<200804141033.59998.arnd@arndb.de>
	<20080414151856.GA10111@cosmic.amd.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760675AbYDNPbh@vger.kernel.org>
In-Reply-To: <20080414151856.GA10111@cosmic.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, info-linux@geode.amd.com, adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net

On Mon, 14 Apr 2008 09:18:56 -0600
Jordan Crouse <jordan.crouse@amd.com> wrote:

> On 14/04/08 10:33 +0200, Arnd Bergmann wrote:
> > On Monday 14 April 2008, Andres Salomon wrote:
> > > Since there's no way to autodetect panel modes, we're forced to h=
ardcode
> > > them in the driver and add a big fat #ifdef. =C2=A0The OLPC DCON =
needs a
> > > specific mode line (at 1200x900). =C2=A0This adds it to both gxfb=
 and lxfb.
> > >=20
> > > Signed-off-by: Andres Salomon <dilinger@debian.org>
> >=20
> > Since the XO is based on Open Firmware, shouldn't the panel size re=
ally be
> > a property in the device tree that can be read by this driver?
>=20
> Andre's description was slightly misleading.  We could probably detec=
t
> the panel mode, but there isn't any reason to since the panel timings
> are well known and won't change.  While OFW detection would be good
> computer science fu, it would be a wasted effort since its so easy to=
 hard
> code them into the table.
>=20
> Jordan
>=20

Right, that's what I get for sending this stuff out at 4am.  To be clea=
r,
the issue that we have to hard code ways to access panel timing info on=
 a
per-platform and/or per-bios basis.  There's no standard way to fetch
it across all Geodes (that I'm aware of).  Even the VSA doesn't really
help us here.



--=20
Need a kernel or Debian developer?  Contact me, I'm looking for contrac=
ts.
