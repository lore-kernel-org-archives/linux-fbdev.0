From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: Vertical retrace interrupts?
Date: 01 Feb 2003 16:45:50 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1044114349.4294.15.camel@thor>
References: <Pine.LNX.4.44.0301281920520.12076-100000@phoenix.infradead.org>
	 <1043893384.1052.127.camel@localhost.localdomain>
	 <1043927116.7576.40.camel@thor>
	 <1043968889.1002.40.camel@localhost.localdomain>
	 <1044012272.6540.14.camel@thor>
	 <1044038091.1596.14.camel@localhost.localdomain>
	 <1044040336.6385.92.camel@thor>  <20030131213245.GA2905@iliana>
	 <1044055934.997.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from netline-be1.netline.ch ([195.141.226.32])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18ezqF-0002QV-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 01 Feb 2003 07:46:03 -0800
In-Reply-To: <1044055934.997.20.camel@localhost.localdomain>
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
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, Fredrik Noring <noring@nocrew.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sam, 2003-02-01 at 00:34, Antonino Daplas wrote:=20
> On Sat, 2003-02-01 at 05:32, Sven Luther wrote:
> > On Fri, Jan 31, 2003 at 08:12:16PM +0100, Michel D=E4nzer wrote:
> > > On Fre, 2003-01-31 at 19:35, Antonino Daplas wrote:
> > > > On Fri, 2003-01-31 at 19:24, Michel D=E4nzer wrote:
> > > > >=20
> > > > > You don't need X to use the DRM, just some privileged client to
> > > > > initialize it.
> > > >=20
> > > > You're right.  I just realized that since DRM already has an interr=
upt
> > > > handler, it is unwise for fbdev to install its own interrupt handler
> > > > too, as this will fatally lock up the machine when DRM and fbdev are
> > > > loaded simultaneously.
> > > >=20
> > > > So, how about this?  Let fbdev have its own vblank ioctl, but for f=
bdev
> > > > drivers with a DRM counterpart, fbdev will just call the DRM
> > > > wait_vblank() and send_vbl_signals() functions.   Do you think this=
 is
> > > > doable, I haven't examined the code thoroughly? =20
> > > >=20
> > > > The main goal is too avoid having 2 independent interrupt handlers =
for
> > > > one device.
> > >=20
> > > A noble goal, but the framebuffer device would still need its own code
> > > when the DRM isn't active, so I'm afraid there's no way around code
> > > duplication, unless we could somehow factor out the common code for t=
he
> > > two to share?
>=20
> The fbdev driver will automatically load the DRM module when it refers
> to any exportable symbol of DRM.  We can also make the fbdev drivers
> specifically depend on DRM in Kconfig so users don't accidentally
> compile fbdev without its DRM counterpart.

I wonder if people will like having to build the DRM for a framebuffer
device... a solution where one component uses the other if it's there,
but works without it otherwise, might be better.

> The aim is not to avoid code duplication, although that is a plus, it's
> two independent handlers clashing and locking up the machine.

I'm not sure it would be that bad, but certainly suboptimal. :)


> > Could it not be that the fbdev sort of minimally intialize the DRM when
> > it is not already active ? After all, the fbdev knows as much, if not
> > more, than the X driver about the graphic chips state, especially if the
> > X driver is using the fbdev.
>=20
> I was wondering about this to.  How much initialization is required?  Is
> it not enough to just load the DRM module?

No. The DRM_INST_HANDLER ioctl needs to be called to make the IRQs work,
and I suspect more needs to be done before that.

> Also, we have fbdev drivers that are incompatible with DRM, so having
> fbdev load DRM is like telling it to commit suicide :-)

Out of curiosity, is that about i8xx?


--=20
Earthling Michel D=E4nzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld =3D Something 2 See!
http://www.vasoftware.com
