From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Vertical retrace interrupts?
Date: 01 Feb 2003 02:35:39 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1044038091.1596.14.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0301281920520.12076-100000@phoenix.infradead.org>
	<1043893384.1052.127.camel@localhost.localdomain>
	<1043927116.7576.40.camel@thor>
	<1043968889.1002.40.camel@localhost.localdomain> 
	<1044012272.6540.14.camel@thor>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18egDx-000532-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 31 Jan 2003 10:49:13 -0800
In-Reply-To: <1044012272.6540.14.camel@thor>
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
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Fredrik Noring <noring@nocrew.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2003-01-31 at 19:24, Michel D=E4nzer wrote:
>=20
> You don't need X to use the DRM, just some privileged client to
> initialize it.
>=20

You're right.  I just realized that since DRM already has an interrupt
handler, it is unwise for fbdev to install its own interrupt handler
too, as this will fatally lock up the machine when DRM and fbdev are
loaded simultaneously.

So, how about this?  Let fbdev have its own vblank ioctl, but for fbdev
drivers with a DRM counterpart, fbdev will just call the DRM
wait_vblank() and send_vbl_signals() functions.   Do you think this is
doable, I haven't examined the code thoroughly? =20

The main goal is too avoid having 2 independent interrupt handlers for
one device.

Tony=20
=20




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
