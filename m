From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: Re: Status of radeonfb in 2.5?
Date: 18 Oct 2002 21:28:40 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1034969321.1126.2251.camel@tibook>
References: <3DACA222.5030409@netscape.net>
	<20021016223613.17897@192.168.4.1> <3DADD22F.9030508@netscape.net>
	<1034808341.1229.282.camel@tibook>  <aopfrg$aln$1@main.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from netline-be1.netline.ch ([195.141.226.32])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 182cne-0002gH-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Oct 2002 12:28:46 -0700
In-Reply-To: <aopfrg$aln$1@main.gmane.org>
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
To: nwourms@netscape.net
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fre, 2002-10-18 at 19:21, Nicholas Wourms wrote:
> Michel D=E4nzer wrote:
>=20
> > On Mit, 2002-10-16 at 22:55, Nicholas Wourms wrote:
> >>=20
> >> A) Is it (or will it ever be) possible to run dual head
> >> using two different cards (like radeon & riva-tnt2)?  I know
> >> there is still much work to be done, but I was curious if
> >> this was even remotely possible.
> >=20
> > I think it should theoretically work, but as always the only way to tel=
l
> > is to try it. :)
>=20
> Well there isn't much on multiheading in the documentation, so I was hopi=
ng=20
> for some hints or key insights into how to set this up.

Something like video=3Dradeonfb video=3Driva ?


> >> B) Does anyone have a painless, yet precise way of
> >> generating modelines for fb.modes if you are using
> >> XFree-4.2?  I only ask because the XFree modelines are all
> >> determined by i2c DDC probing, thus there are none in the
> >> XF86Config file.
> >=20
> > If the X driver supports Option "UseFBDev", you should be able to use
> > fbset with that.
> >=20
>=20
> Huh?  The problem is that fbset will not work because I need to populate=20
> fb.modes with proper mode lines.  So at the moment fbset won't work at al=
l. =20

I was thinking of running X with Option "UseFBDev" and getting
information about the modes with fbset.


--=20
Earthling Michel D=E4nzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
