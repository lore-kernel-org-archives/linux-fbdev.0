From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Vertical retrace interrupts?
Date: 02 Feb 2003 00:50:10 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1044118163.3906.29.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0301281920520.12076-100000@phoenix.infradead.org>
	<1043893384.1052.127.camel@localhost.localdomain>
	<1043927116.7576.40.camel@thor>
	<1043968889.1002.40.camel@localhost.localdomain>
	<1044012272.6540.14.camel@thor>
	<1044038091.1596.14.camel@localhost.localdomain>
	<1044040336.6385.92.camel@thor>  <20030131213245.GA2905@iliana>
	<1044055934.997.20.camel@localhost.localdomain> 
	<1044114349.4294.15.camel@thor>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18f13Z-0007Wi-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 01 Feb 2003 09:03:53 -0800
In-Reply-To: <1044114349.4294.15.camel@thor>
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
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, Fredrik Noring <noring@nocrew.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2003-02-01 at 23:45, Michel D=E4nzer wrote:
[snip]
> >=20
> > The fbdev driver will automatically load the DRM module when it refers
> > to any exportable symbol of DRM.  We can also make the fbdev drivers
> > specifically depend on DRM in Kconfig so users don't accidentally
> > compile fbdev without its DRM counterpart.
>=20
> I wonder if people will like having to build the DRM for a framebuffer
> device... a solution where one component uses the other if it's there,
> but works without it otherwise, might be better.
>=20
Yes, your suggestion is better.  I did browse the dri code, and my
feeling is drm is coded for userspace clients without any usable hooks
for clients residing in kernel space. I'm still wondering how to access
DRM services from kernel space. =20

> > The aim is not to avoid code duplication, although that is a plus, it's
> > two independent handlers clashing and locking up the machine.
>=20
> I'm not sure it would be that bad, but certainly suboptimal. :)
>=20

It will be bad.  The handler that gets loaded first will receive the
interrupt signal first.  It will, by necessity, clear the registers of
the event it's watching for to reenable the interrupt.  So when it's the
second handler's turn, and if it is also watching for the same event,
then it will falsely assume that the event never happened.  At worst,
the second handler will wait indefinitely for an event that will never
arrive, at best it will time out and send false information.

>=20
> > > Could it not be that the fbdev sort of minimally intialize the DRM wh=
en
> > > it is not already active ? After all, the fbdev knows as much, if not
> > > more, than the X driver about the graphic chips state, especially if =
the
> > > X driver is using the fbdev.
> >=20
> > I was wondering about this to.  How much initialization is required?  I=
s
> > it not enough to just load the DRM module?
>=20
> No. The DRM_INST_HANDLER ioctl needs to be called to make the IRQs work,
> and I suspect more needs to be done before that.
>=20

Yes, I also realized that.  My feeling is if James or Geert do agree to
add support for this, fbdev will just have to duplicate the code, taking
care that another handler may exist, or DRM will be rewritten so the
interrupt handling can be shared or made available to other modules, as
you suggested.

> > Also, we have fbdev drivers that are incompatible with DRM, so having
> > fbdev load DRM is like telling it to commit suicide :-)
>=20
> Out of curiosity, is that about i8xx?
>=20

No, the i810fb driver is compatible with X and DRM. =20

Tony




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
