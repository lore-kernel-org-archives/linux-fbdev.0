From: Richard Smith <rsmith@bitworks.com>
Subject: Re: still ..Confused about atyfb and M1
Date: Wed, 04 Feb 2004 09:16:58 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40210CEA.5080102@bitworks.com>
References: <Pine.LNX.4.44.0401302147390.22830-100000@phoenix.infradead.org> <401FF39B.7090406@bitworks.com> <Pine.GSO.4.58.0402041003560.20790@waterleaf.sonytel.be>
Reply-To: RSmith@bitworks.com
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AoOmt-0007jy-DM
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Feb 2004 07:17:59 -0800
Received: from b44.xdsl.pgtc.com ([198.70.248.44] helo=bitworks.com)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AoOms-0000Jo-UE
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Feb 2004 07:17:59 -0800
Received: from bitworks.com [192.168.1.22] by bitworks.com [127.0.0.1] with SMTP (MDaemon.v2.7.SP4.R) for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 04 Feb 2004 09:16:17 -0600
In-Reply-To: <Pine.GSO.4.58.0402041003560.20790@waterleaf.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: geert@linux-m68k.org
Cc: James Simmons <jsimmons@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Kern <alex.kern@gmx.de>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> On Tue, 3 Feb 2004, Richard Smith wrote:
>=20
>>new untested hardware booting a half-ass videobios running an unknown
>>driver.  Gee... wonder why it dosen't work? *grin*

 >Geert Uytterhoeven wrote:

> Indeed, atyfb needs BIOS (or OpenFirmware) initialization. It has
>=20
How much?  Are things like the ammount and type of RAM autodetected or=20
just read from registers that the BIOS is supposed to set?

>=20
 > initialization code for RAGE XL, though.

Any idea how different the RAGE XL is from the M1? I know they are both=20
Mach64 but how consistent are the registers across all of the Mach64 chips?

> My Vaio Z600TEK (Z505 in US/JP) has a M1. It works with atyfb in recent 2=
.4,
> but it took Dani=EBl Mantione quite a bit of work to make it work on this
> particular machine...

What device ID is your M1?

Any idea what he had to do?  Most of DM's code seems to deal with=20
makeing it work properly with a LCD.  Right now I just have a CRT hooked=20
up.  LCD will comes later.

> Let's say atyfb in 2.4 works on most M1s these days.

So which one should I work with? 2.4 or 2.6 with fbdiff?

--=20
Richard A. Smith
rsmith@bitworks.com




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
