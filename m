From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: Some questions
Date: 12 Mar 2003 01:07:08 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047427628.6814.79.camel@thor>
References: <Pine.LNX.4.44.0303111628240.23668-100000@phoenix.infradead.org>
	 <1047407816 .1013.182.camel@localhost.localdomain>
	 <3E6E4D9A.7060003@winischhofer.net>
	 <1047419056.1100.26.camel@localhost.localdomain>
	 <3E6E61C6.2000503@winischhofer.net>
	 <1047422558.1128.120.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from netline-be1.netline.ch ([195.141.226.32])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18stm5-0004LX-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 16:07:14 -0800
In-Reply-To: <1047422558.1128.120.camel@localhost.localdomain>
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
Cc: Thomas Winischhofer <thomas@winischhofer.net>, James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Die, 2003-03-11 at 23:51, Antonino Daplas wrote:
> On Wed, 2003-03-12 at 06:23, Thomas Winischhofer wrote:
> > >=20
> > > I actually prefer #3, and I already have working code for this.  We c=
an
> > > also make this driver switchable (ie, drivers that are not affected b=
y X
> > > can disable this, and only drivers that are affected such as the riva,
> > > aty, radeon, etc can turn this on).
> >=20
> > What exactly is a "trusted" console?
>=20
> By default, the pid of each vt is -1.  When X loads, it installs its own
> VT (ie vt7), which in that case the pid of that particular vt =3D=3D X's
> pid.  We can check this pid, and if switching from a vt with pid =3D=3D -=
1,
> we can safely assume that the hardware state is still sane, and if not,
> assume the hardware state is undefined.

Can you also detect when the app has opened the framebuffer device, and
assume it's playing nice when it has? (for Option "UseFBDev")


--=20
Earthling Michel D=E4nzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open!=20
Get cracking and register here for some mind boggling fun and=20
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
