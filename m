From: Otto Solares <solca@guug.org>
Subject: Re: [PATCH] neofb patches
Date: Thu, 29 Apr 2004 19:18:16 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040430011816.GC26704@guug.org>
References: <20040428002037.GE22495@guug.org> <1083112565.20473.10.camel@gaston> <20040428070832.GA23411@guug.org> <1083147416.18416.24.camel@thor.asgaard.local> <20040428163730.GA24448@guug.org> <1083191201.18413.73.camel@thor.asgaard.local> <20040429010725.GD24584@guug.org> <1083243672.18413.148.camel@thor.asgaard.local> <20040429175201.GA26608@guug.org> <1083280337.8281.181.camel@thor.asgaard.local>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJMf9-0003kP-P9
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 29 Apr 2004 18:17:59 -0700
Received: from guug.galileo.edu ([168.234.203.30] helo=guug.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJMf7-0007zz-4y
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 29 Apr 2004 18:17:57 -0700
Content-Disposition: inline
In-Reply-To: <1083280337.8281.181.camel@thor.asgaard.local>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, Apr 30, 2004 at 01:12:17AM +0200, Michel D=E4nzer wrote:
> On Thu, 2004-04-29 at 19:52, Otto Solares wrote:
> > On Thu, Apr 29, 2004 at 03:01:13PM +0200, Michel D=E4nzer wrote:
> > > On Thu, 2004-04-29 at 03:07, Otto Solares wrote:
> > > > On Thu, Apr 29, 2004 at 12:26:41AM +0200, Michel D=E4nzer wrote:
> > > >=20
> > > > > A small low-level driver could handle this, which both the frameb=
uffer
> > > > > device and the DRM use. Linus has proposed this approach, and I m=
ust say
> > > > > I like it.
> > > >=20
> > > > That should be fbdev without fbcon.
> > >=20
> > > I'm not sure that works: keep in mind that the DRM works on other OSs
> > > than Linux, and even on Linux some people may want to use the DRM
> > > without a framebuffer device. Neither should be a problem with a mini=
mal
> > > base driver which does nothing more than hardware resource management
> > > and arbitration.
> >=20
> > Differents OSs have differents sources for DRM kernel side so
> > that's not a problem nor will affect others OSs than linux.
>=20
> Nope. Most of the code in the DRI CVS drm module is shared between OSs.
> Most of the shared code is hardware specific though, so if you change
> the interface to the hardware, either all the OSs will have to provide
> the new interface, or the code can no longer be shared, which would get
> us back to the code duplication horrors. I'd very much like to avoid
> that.

I don't see your point, nothing prevents using the shared code,
the idea is not to change the interface, just to have a single
graphics layer that handle that same interface.  I know it could be
a pain to duplicate the fbdev into the cvs drm module, but with
proper file separations there could live the fbdev's drm code.

> > Yes, a minimal driver would do the work _NOW_.
>=20
> Why wouldn't it in the future?

Because we need a single and unified graphics layer for linux
in the very same way like the sound and input layers exists now.

A proper graphics layer based on fbdev_sysfs + libraries like the
ones Ben or Jon are working on + dri + hotplug + hal + udev + dbus
+ a good graphics servers (based on the unified layer) + toolkits
=3D a chance for linux to compete in the future with longhorn and
OSX.  The graphics layer I am describing here is low-level and
must contain the basics needed for a graphics server.  I am
working on one but i'm sure it would be useful to any Xserver
like the xserver from fd.o.

-otto



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g.=20
Take an Oracle 10g class now, and we'll give you the exam FREE.=20
http://ads.osdn.com/?ad_id=3D3149&alloc_id=3D8166&op=3Dclick
