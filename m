From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: Add three new IOCTLs to FB API
Date: Tue, 23 Sep 2003 02:27:54 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1064276874.1419.26.camel@thor.holligenstrasse29.lan>
References: <20030922202511.53395.qmail@web14915.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1b2B-0007pt-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Sep 2003 17:28:04 -0700
Received: from netline-mail1.netline.ch ([195.141.226.27])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A1b2B-0006C8-1d
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Sep 2003 17:28:03 -0700
In-Reply-To: <20030922202511.53395.qmail@web14915.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2003-09-22 at 22:25, Jon Smirl wrote:
>=20
> > > 2) Get 3D driver name. Return the name of the DRM driver that is asso=
ciated
> > > with this fb device. For example aty128fb would return r128, radeonfb=
 would
> > > return radeon. Empty string if there is none. There are eight DRM dri=
vers
> > and
> > > 15 fb ones.
> >=20
> > I think this should be done using sysfs, too. I.e. symbolic links betwe=
en the
> > fbdev and drm drivers in /sys.
>=20
> Initially the fb device will need to provide strings for the name of the =
3D
> driver. A user app is going to read these strings and load the DRM driver.

So the app will map from 3D driver to DRM?

> After the DRM driver is loaded it can make links.

The framebuffer device could do it just as well, the link target doesn't
have to exist.

> Another solution would be for the fb driver to reference a symbol in the
> appropriate DRM driver. This would make modprobe load them both.

This doesn't work because the framebuffer device is needed for console
on boot and hence built into the kernel. :)


--=20
Earthling Michel D=C3=A4nzer   \  Debian (powerpc), XFree86 and DRI develop=
er
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=3Ddaenzer



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
