From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: Status of radeonfb in 2.5?
Date: 17 Oct 2002 00:45:40 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1034808341.1229.282.camel@tibook>
References: <3DACA222.5030409@netscape.net>
	<20021016223613.17897@192.168.4.1>  <3DADD22F.9030508@netscape.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from netline-be1.netline.ch ([195.141.226.32])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 181wvA-00046h-00
	for <Linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Oct 2002 15:45:45 -0700
In-Reply-To: <3DADD22F.9030508@netscape.net>
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
To: Nicholas Wourms <nwourms@netscape.net>
Cc: Linux-fbdev-devel@lists.sourceforge.net

On Mit, 2002-10-16 at 22:55, Nicholas Wourms wrote:
>=20
> A) Is it (or will it ever be) possible to run dual head=20
> using two different cards (like radeon & riva-tnt2)?  I know=20
> there is still much work to be done, but I was curious if=20
> this was even remotely possible.

I think it should theoretically work, but as always the only way to tell
is to try it. :)


> B) Does anyone have a painless, yet precise way of=20
> generating modelines for fb.modes if you are using=20
> XFree-4.2?  I only ask because the XFree modelines are all=20
> determined by i2c DDC probing, thus there are none in the=20
> XF86Config file.

If the X driver supports Option "UseFBDev", you should be able to use
fbset with that.


--=20
Earthling Michel D=E4nzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast



-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
