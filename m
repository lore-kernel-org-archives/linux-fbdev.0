From: Ingo Oeser <ioe-lkml@rameria.de>
Subject: Re: Re: [PATCH] Sysfs for framebuffer
Date: Sun, 21 Mar 2004 09:02:33 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200403210902.35913.ioe-lkml@rameria.de>
References: <20040320174956.GA3177@dreamland.darkstar.lan> <20040320215219.GA20277@dreamland.darkstar.lan> <20040320215909.GA26277@kroah.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B58jv-00018d-Dc
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Mar 2004 11:36:07 -0800
Received: from smtprelay01.ispgateway.de ([62.67.200.156])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B58jt-0001iL-VI
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Mar 2004 11:36:06 -0800
In-Reply-To: <20040320215909.GA26277@kroah.com>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: Text/Plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>, Kronos <kronos@kronoz.cjb.net>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 20 March 2004 22:59, Greg KH wrote:
> Well, /sys/class/video is already taken by the V4L core code, so if
> "graphics" doesn't confuse people, it's ok with me.

I think it DOES confuse people. If they see that, they think the kernel
has (got) a graphics subsystem (now). That is simply not true, since it
is not even the lowest layer of the graphics subsystem in Linux, except
on a few special cases. It is just an basic accelerated 2D framebuffer.=20
No more, no less.

When we have all devices in that class, that are needed to run fully
accelerated 3D graphics, without any direct hardware access, then we
could call it "graphics class" without any confusion.

So PLEASE consider this confusion or people will start argueing with me
whether Linux has an in kernel graphics subsystem (like KGI once) and
not all people can be convinced by code, because not all are coders
anymore ;-)


Thanks & regards

Ingo Oeser

=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAXUwZU56oYWuOrkARAi2SAKCWOIOvQp5PtVbfZuudMoiXauX1OACg0Ji4
s0R/gqsMRXLbsm5iU2c4MDg=3D
=3DK/NA
=2D----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
