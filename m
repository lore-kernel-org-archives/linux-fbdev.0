From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Vertical retrace interrupts?
Date: 31 Jan 2003 07:22:16 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1043968889.1002.40.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0301281920520.12076-100000@phoenix.infradead.org>
	<1043893384.1052.127.camel@localhost.localdomain> 
	<1043927116.7576.40.camel@thor>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18eODt-0000pg-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Jan 2003 15:35:57 -0800
In-Reply-To: <1043927116.7576.40.camel@thor>
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
Cc: James Simmons <jsimmons@infradead.org>, Fredrik Noring <noring@nocrew.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-01-30 at 19:45, Michel D=E4nzer wrote:
> On Don, 2003-01-30 at 03:34, Antonino Daplas wrote:
> > On Wed, 2003-01-29 at 03:21, James Simmons wrote:
> > >=20
> > > > Are there any plans on merging DirectFB features? Stuff like vertic=
al
> > > > retrace interrupts etc.?
> >=20
> > I wholeheartedly agree with this.  There are a lot of applications out
> > there (especially video players) where vtrace signal delivery is
> > critical for optimum operation.  Polling for VGA registers is not
> > totally correct for newer cards and is too inefficient, so this has to
> > be done at a per driver level.
>=20
> Let me point out that the DRM in XFree86 4.3.0 and 2.5 kernels has a
> generic ioctl which can block or send a signal on vertical blank
> interrupts.
>=20
>=20

Yes, I've seen the dri list archives, and adding support for this in
fbdev will result in code dupliation :-(.

However, at least 3 people have mailed me that they are using their
somewhat old pc as a set top box with mplayer, DirectFB and i810fb. No
X.  The image instability is noticeable because they are driving
big-screen TV's, especially because DirecFB is double-buffered, with
triple-buffering in the TODO list.  It's because of this that I have to
hack in vretrace signal delivary to i810fb.  There's also a similar
patch for matroxfb.


Tony




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
