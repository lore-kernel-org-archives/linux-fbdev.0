From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: framebuffer ioctl
Date: Tue, 7 Sep 2004 12:01:39 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <9e473391040907090125be532a@mail.gmail.com>
References: <Pine.GSO.4.58.0409041304080.3434@waterleaf.sonytel.be>
	 <413A3735.9E7D2F11@orpatec.ch> <413B4925.5000706@comcast.net>
	 <20040906184306.GA29544@guug.org>
	 <9e47339104090612086149bfd7@mail.gmail.com>
	 <20040906192400.GB29544@guug.org>
	 <9e47339104090612334b3623ee@mail.gmail.com>
	 <413DD83D.7B9F5D92@orpatec.ch>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4iPl-0001Ez-Ox
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Sep 2004 09:01:49 -0700
Received: from rproxy.gmail.com ([64.233.170.196] helo=mproxy.gmail.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C4iPi-0004bV-0G
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Sep 2004 09:01:48 -0700
Received: by mproxy.gmail.com with SMTP id 77so193973rnl
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 Sep 2004 09:01:39 -0700 (PDT)
In-Reply-To: <413DD83D.7B9F5D92@orpatec.ch>
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
To: linux-fbdev-devel@lists.sourceforge.net

mesa-solo is under the "fbdev/DRI Environment" link at mesa3d.sf.net.
miniglx is a small glx layer that runs on top of mesa-solo.

Summary of the OLS discussions:
http://lkml.org/lkml/2004/8/2/111

Here is the mode setting proposal, it's somewhere in the fbdev
archives but I can't find it

At OLS we talked about a system like this:
1) user owns graphics devices
2) user sets mode with string (or similar) format using ioctl common to
all drivers.
3) driver is locked to prevent multiple mode sets
4) common code takes this string and does a hotplug event with it.
5) hotplug event runs root context in user space=20
6) mode is decoded and verified, this may involve a little process that
maintains the DDC database and reads a file of legal modes. Other
schemes are possible.
7a) mode is set using VBIOS and vm86, signal driver mode is set
7b) the register values needed to set the mode are passed into a root
priv ioctl.
8) driver is unlocked.

In this model all of the verification happens in user space. If you
want to set modes other than the ones from DDC you have to add them to
the config file. There is no need for DDC support and mode verification
in the kernel.

To give credit this is Alan Cox's design.


On Tue, 07 Sep 2004 17:48:13 +0200, Otto Wyss <otto.wyss@orpatec.ch> wrote:
> Jon Smirl wrote:
> >
> > > > Teach him about mesa-solo and he won't want to extend fbdev.
> > >
> I coudln't find much useful information about mesa-solo, is it the same
> as miniglx? Is there any link?
>=20
> > > What about the new graphics interface that will unify
> > > fbdev/drm you talk about in kernel summit?
> > >
> Is there anyone who could write a resum=E9e what's talked and decided
> about framebuffer at the summit? Just send it to me (i.e. plain text)
> and I'll put it onto the web in the document section.
>=20
> > > -otto
> Hi Otto, is that me or is that you ;-)
>=20
>=20
>=20
> O. Wyss
>=20
> --
> See a huge pile of work at "http://wyodesktop.sourceforge.net/"
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1 today.
> http://ads.osdn.com/?ad_id=3D5047&alloc_id=3D10808&op=3Dclick
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>=20



--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
