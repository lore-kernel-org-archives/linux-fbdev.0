From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Some questions
Date: 12 Mar 2003 09:02:01 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047430840.1186.233.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303111628240.23668-100000@phoenix.infradead.org>
	<1047407816 .1013.182.camel@localhost.localdomain>
	<3E6E4D9A.7060003@winischhofer.net>
	<1047419056.1100.26.camel@localhost.localdomain>
	<3E6E61C6.2000503@winischhofer.net>
	<1047422558.1128.120.camel@localhost.localdomain> 
	<1047427628.6814.79.camel@thor>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18sugA-0002aX-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 17:05:10 -0800
In-Reply-To: <1047427628.6814.79.camel@thor>
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
Cc: Thomas Winischhofer <thomas@winischhofer.net>, James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-03-12 at 08:07, Michel D=E4nzer wrote:
> On Die, 2003-03-11 at 23:51, Antonino Daplas wrote:
> > On Wed, 2003-03-12 at 06:23, Thomas Winischhofer wrote:
> > > >=20
> > > > I actually prefer #3, and I already have working code for this.  We=
 can
> > > > also make this driver switchable (ie, drivers that are not affected=
 by X
> > > > can disable this, and only drivers that are affected such as the ri=
va,
> > > > aty, radeon, etc can turn this on).
> > >=20
> > > What exactly is a "trusted" console?
> >=20
> > By default, the pid of each vt is -1.  When X loads, it installs its ow=
n
> > VT (ie vt7), which in that case the pid of that particular vt =3D=3D X'=
s
> > pid.  We can check this pid, and if switching from a vt with pid =3D=3D=
 -1,
> > we can safely assume that the hardware state is still sane, and if not,
> > assume the hardware state is undefined.
>=20
> Can you also detect when the app has opened the framebuffer device, and
> assume it's playing nice when it has? (for Option "UseFBDev")
>=20

X using fbdev will also have the same limitation. I have implemented
something like this before.  For each fb_open, the current->pid can be
saved into a "white list" and removed for each fb_close.  fbcon can then
compare this to the pid of the vt it's switching from.

This is becoming to sound very ugly though.  I guess, the best way is to
really support Option "UseFBDev", or at least have the user decide if
he/she wants to have the hardware refreshed. =20

Tony  =20





-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
