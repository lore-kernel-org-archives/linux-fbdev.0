From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [announce 7/7] fbsplash - documentation
Date: Tue, 8 Mar 2005 01:12:40 -0500
Message-ID: <9e47339105030722127c697df@mail.gmail.com>
References: <20050308021706.GH26249@spock.one.pl>
	 <200503080418.08804.arnd@arndb.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8XxV-0006eu-Ef
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 22:12:45 -0800
Received: from rproxy.gmail.com ([64.233.170.195])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D8XxT-0008Q5-NT
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 22:12:45 -0800
Received: by rproxy.gmail.com with SMTP id z35so2252339rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Mar 2005 22:12:43 -0800 (PST)
In-Reply-To: <200503080418.08804.arnd@arndb.de>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: Michal Januszewski <spock@gentoo.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Tue, 8 Mar 2005 04:18:07 +0100, Arnd Bergmann <arnd@arndb.de> wrote:
> On Dinsdag 08 M=E4rz 2005 03:17, Michal Januszewski wrote:
>=20
> > +It's possible to set path to the splash helper by writing it to
> > +/proc/sys/kernel/fbsplash.
>=20
> It should probably just use its own hotplug agent instead of calling
> the helper directly.

Framebuffer is already generating hotplug add/remove messages.=20

HOTPLUG_TIME=3D'Mon Feb 28 02:15:25 EST 2005'
PHYSDEVPATH=3D/devices/pci0000:00/0000:00:01.0/0000:01:00.0
SUBSYSTEM=3Dgraphics
HOTPLUG_ARGS=3D
DEVPATH=3D/class/graphics/fb0
HOTPLUG_TYPE=3Dgraphics
ACTION=3Dadd
PHYSDEVDRIVER=3Dradeonfb
DEBUG=3Dyes
PHYSDEVBUS=3Dpci
SEQNUM=3D537

This event can be caught in early userspace. The helper app will need
to live on initramfs/initrd and be small. Statically link it to klibc.

You can use the modular fb patch that has been recently posted (just
about to go in -mm) to make hotplug fbdev debugging much simpler.

Alternatively you might want to look at how request_firmware works.
You could easily load the picture as if it were firmware. I'm looking
at modifying request_firmware to be more general right now.

A direct call to call_usermodehelper() requires you to build a path
and app name into the driver.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
