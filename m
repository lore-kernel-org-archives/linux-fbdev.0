From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: Add three new IOCTLs to FB API
Date: Mon, 22 Sep 2003 12:23:26 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1064226206.8398.43.camel@thor.holligenstrasse29.lan>
References: <20030922052838.53671.qmail@web14913.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1Nqv-0007Ao-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Sep 2003 03:23:34 -0700
Received: from netline-mail1.netline.ch ([195.141.226.27])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A1Nqv-0001s0-4A
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Sep 2003 03:23:33 -0700
In-Reply-To: <20030922052838.53671.qmail@web14913.mail.yahoo.com>
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
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2003-09-22 at 07:28, Jon Smirl wrote:
>=20
> In order to load DRM 3D support I need two pieces of information. The nam=
e of
> the 3D DRM driver and the bus:dev:func of the hardware. DRM does not impl=
ement
> PCI ID probing, instead you need to it what hardware to use.=20
>=20
> By adding these to the FB API you can start standalone Mesa just by speci=
fying
> the name of the FB device to use. I can pick up mode and resolution from =
the
> existing FB API.
>=20
> 1) Get location of card that is associated with this fb device. It would =
return
> bus,dev,func of hardware. There may be more than one piece of the same ha=
rdware
> installed.
>=20
> 3) Get vendor and card PCI ID
>=20
> 2) Get 3D driver name. Return the name of the DRM driver that is associat=
ed
> with this fb device. For example aty128fb would return r128, radeonfb wou=
ld
> return radeon. Empty string if there is none. There are eight DRM drivers=
 and
> 15 fb ones.

For radeon, you also need to know whether it's an R100 or R200 core (for
the 3D driver, as Ian pointed out, but also for the CP init ioctl).

Maybe these could be handled via sysfs instead of adding ioctls?

Also, at least with radeonfb, the fix.id field contains the chip ID.


--=20
Earthling Michel D=C3=A4nzer   \  Debian (powerpc), XFree86 and DRI develop=
er
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=3Ddaenzer



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
