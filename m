From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: Mirrored Display?
Date: 16 Dec 2002 01:40:25 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1039999225.9260.30.camel@thor>
References: <200212131733.42340.kaufmann@sohard.de>
	 <1039911076.1000.39.camel@localhost.localdomain>
	 <200212151603.30592.kaufmann@sohard.de>
	 <1039985803.1080.119.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from dclient80-218-112-135.hispeed.ch ([80.218.112.135] helo=thor)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18NjJU-0000si-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 15 Dec 2002 16:40:55 -0800
In-Reply-To: <1039985803.1080.119.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Michael Kaufmann <kaufmann@sohard.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Son, 2002-12-15 at 21:57, Antonino Daplas wrote:
>=20
> User apps will always assume that the first pixel written to the
> framebuffer will appear as the first pixel of the first scanline of your
> display.  Meaning, for apps that will always use mmap, you have to
> rewrite them so they raster "right->left" instead of "left->right".
>=20
> If you think about it, a hardware solution seems to be more feasible.

This may be true in general, but at least for X it wouldn't be hard to
add an option for mirroring via a shadow framebuffer.


--=20
Earthling Michel D=E4nzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
