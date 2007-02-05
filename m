From: Luca Tettamanti <kronos@people.it>
Subject: Re: [PATCH] nvidiafb: allow ignoring EDID info
Date: Mon, 5 Feb 2007 21:18:24 +0100
Message-ID: <20070205201824.GA13431@dreamland.darkstar.lan>
References: <ephv35$4i3$1@sea.gmane.org>
	<20070128160831.fb51347f.akpm@osdl.org>
	<21d7e9970701281612q56b694edp6efd1a5556dea3fe@mail.gmail.com>
	<20070128162907.370f5476.akpm@osdl.org>
	<21d7e9970701281639w57edc2efw4ba620d4c1bdcee7@mail.gmail.com>
	<cb7bb73a0701290637q2ce0ff16t28f82d0c0339a2ba@mail.gmail.com>
	<20070130203301.GA15067@dreamland.darkstar.lan>
	<20070204201713.GA12867@dreamland.darkstar.lan>
	<cb7bb73a0702041317u4ca2fbabp45cf56526e57c982@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HEAIK-0007vv-Fy for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Feb 2007 12:18:32 -0800
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HEAIH-0006ft-0v
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Feb 2007 12:18:32 -0800
Content-Disposition: inline
In-Reply-To: <cb7bb73a0702041317u4ca2fbabp45cf56526e57c982@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Il Sun, Feb 04, 2007 at 10:17:08PM +0100, Giuseppe Bilotta ha scritto: =

> On 2/4/07, Luca Tettamanti <kronos@people.it> wrote:
> >Giuseppe, can you send me the EDID block of your monitor?
> =

> I'd gladly do it, if I knew how to retrieve it ... because apparently,
> get-edid doesn't work, even though both the nv driver for X and
> nvidiafb manage to retrieve it.

get-edid uses the BIOS, while the other two talk directly over the I2C
bus.

Try loading i2c-dev (I2C_CHARDEV); With i2cdump[1] you can read the EDID
block, which resides at address 0x50:

i2cdump N 0x50 (where N is the bus number)

If you are unshure about bus number try with all the available
/dev/i2c-* devices (you may want to unload HW monitor drivers first, so
you don't poke at random stuff).

Luca
[1] lm-sensors package, at least on Debian.
-- =

La somma dell'intelligenza sulla terra =E8 una costante.
La popolazione =E8 in aumento.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
