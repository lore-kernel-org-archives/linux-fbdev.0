From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: Vertical retrace interrupts?
Date: 30 Jan 2003 12:45:17 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1043927116.7576.40.camel@thor>
References: <Pine.LNX.4.44.0301281920520.12076-100000@phoenix.infradead.org>
	 <1043893384.1052.127.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from netline-be1.netline.ch ([195.141.226.32])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18eD8d-0002Ok-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Jan 2003 03:45:47 -0800
In-Reply-To: <1043893384.1052.127.camel@localhost.localdomain>
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
Cc: James Simmons <jsimmons@infradead.org>, Fredrik Noring <noring@nocrew.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Don, 2003-01-30 at 03:34, Antonino Daplas wrote:
> On Wed, 2003-01-29 at 03:21, James Simmons wrote:
> >=20
> > > Are there any plans on merging DirectFB features? Stuff like vertical
> > > retrace interrupts etc.?
>=20
> I wholeheartedly agree with this.  There are a lot of applications out
> there (especially video players) where vtrace signal delivery is
> critical for optimum operation.  Polling for VGA registers is not
> totally correct for newer cards and is too inefficient, so this has to
> be done at a per driver level.

Let me point out that the DRM in XFree86 4.3.0 and 2.5 kernels has a
generic ioctl which can block or send a signal on vertical blank
interrupts.


--=20
Earthling Michel D=E4nzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld =3D Something 2 See!
http://www.vasoftware.com
