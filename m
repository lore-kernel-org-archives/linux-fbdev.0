From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: Vertical retrace interrupts?
Date: Fri, 31 Jan 2003 22:32:45 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030131213245.GA2905@iliana>
References: <Pine.LNX.4.44.0301281920520.12076-100000@phoenix.infradead.org> <1043893384.1052.127.camel@localhost.localdomain> <1043927116.7576.40.camel@thor> <1043968889.1002.40.camel@localhost.localdomain> <1044012272.6540.14.camel@thor> <1044038091.1596.14.camel@localhost.localdomain> <1044040336.6385.92.camel@thor>
Mime-Version: 1.0
Content-Transfer-Encoding: Quoted-Printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25] helo=mel-rto6.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18ein2-0003Ix-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 31 Jan 2003 13:33:36 -0800
Content-Disposition: inline
In-Reply-To: <1044040336.6385.92.camel@thor>
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
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Antonino Daplas <adaplas@pol.net>, Fredrik Noring <noring@nocrew.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, Jan 31, 2003 at 08:12:16PM +0100, Michel D=E4nzer wrote:
> On Fre, 2003-01-31 at 19:35, Antonino Daplas wrote:
> > On Fri, 2003-01-31 at 19:24, Michel D=E4nzer wrote:
> > >=20
> > > You don't need X to use the DRM, just some privileged client to
> > > initialize it.
> >=20
> > You're right.  I just realized that since DRM already has an interrup=
t
> > handler, it is unwise for fbdev to install its own interrupt handler
> > too, as this will fatally lock up the machine when DRM and fbdev are
> > loaded simultaneously.
> >=20
> > So, how about this?  Let fbdev have its own vblank ioctl, but for fbd=
ev
> > drivers with a DRM counterpart, fbdev will just call the DRM
> > wait_vblank() and send_vbl_signals() functions.   Do you think this i=
s
> > doable, I haven't examined the code thoroughly? =20
> >=20
> > The main goal is too avoid having 2 independent interrupt handlers fo=
r
> > one device.
>=20
> A noble goal, but the framebuffer device would still need its own code
> when the DRM isn't active, so I'm afraid there's no way around code
> duplication, unless we could somehow factor out the common code for the
> two to share?

Could it not be that the fbdev sort of minimally intialize the DRM when
it is not already active ? After all, the fbdev knows as much, if not
more, than the X driver about the graphic chips state, especially if the
X driver is using the fbdev.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
