From: Nicholas Wourms <nwourms@netscape.net>
Subject: Re: Status of radeonfb in 2.5?
Date: Fri, 18 Oct 2002 13:21:29 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <aopfrg$aln$1@main.gmane.org>
References: <3DACA222.5030409@netscape.net> <20021016223613.17897@192.168.4.1> <3DADD22F.9030508@netscape.net> <1034808341.1229.282.camel@tibook>
Reply-To: nwourms@netscape.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from main.gmane.org ([80.91.224.249])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 182axm-0002Ml-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Oct 2002 10:31:06 -0700
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 182awp-0003YL-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Oct 2002 19:30:07 +0200
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
To: linux-fbdev-devel@lists.sourceforge.net

Michel D=E4nzer wrote:

> On Mit, 2002-10-16 at 22:55, Nicholas Wourms wrote:
>>=20
>> A) Is it (or will it ever be) possible to run dual head
>> using two different cards (like radeon & riva-tnt2)?  I know
>> there is still much work to be done, but I was curious if
>> this was even remotely possible.
>=20
> I think it should theoretically work, but as always the only way to tell
> is to try it. :)

Well there isn't much on multiheading in the documentation, so I was hoping=
=20
for some hints or key insights into how to set this up.  Is there any=20
special magic that the matrox people use to thell the kernel to initialize =

both framebuffers?

>=20
>> B) Does anyone have a painless, yet precise way of
>> generating modelines for fb.modes if you are using
>> XFree-4.2?  I only ask because the XFree modelines are all
>> determined by i2c DDC probing, thus there are none in the
>> XF86Config file.
>=20
> If the X driver supports Option "UseFBDev", you should be able to use
> fbset with that.
>=20

Huh?  The problem is that fbset will not work because I need to populate=20
fb.modes with proper mode lines.  So at the moment fbset won't work at all.=
 =20
What I was asking, since the documention was written when XFree 3.x was=20
still in use,  was how do I get (calculate) the modelines for fb.modes=20
based on the information the i2c DDC probing XFree-4.2.1 outputs in=20
XFree.0.log?  Or is there a better way?  What might be cool is if the fb=20
drivers used the lm-sensors(i2c) capabilities to automagically probe the=20
information and set up the most optimal settings.  Maybe I'm talking too=20
much about something I'm not all that familiar with...  Still, it would be =

nice =3D).

Cheers,
Nicholas




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
