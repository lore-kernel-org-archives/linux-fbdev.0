From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Problem with radeon new ROM probe code
Date: Wed, 24 Sep 2003 19:44:10 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1064425449.15996.58.camel@gaston>
References: <1064405197.15996.44.camel@gaston>
	 <1064416682.10673.52.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A2DhI-0006ot-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 24 Sep 2003 10:45:04 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 1A2DhH-0003ax-JD
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Sep 2003 10:45:03 -0700
In-Reply-To: <1064416682.10673.52.camel@thor.holligenstrasse29.lan>
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
Cc: Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-09-24 at 17:18, Michel D=E4nzer wrote:
> On Wed, 2003-09-24 at 14:06, Benjamin Herrenschmidt wrote:
> >=20
> > Your new code for looking at the card's ROM is causing a problem for
> > me. On some cards, typically the "Mac" cards, the ROM doesn't contain
> > an x86 BIOS, but rather an OF driver. The current code will blindly
> > tap that, though it contains none of the expected tables, and will
> > use completely wrong values.
> >=20
> > Do you have ideas how to make some sanity checking on the ROM content ?
>=20
> The X radeon driver has this in RADEONGetBIOSParameters():
>=20
> if (info->VBIOS[0] !=3D 0x55 || info->VBIOS[1] !=3D 0xaa) {

We check that, but that isn't enough, an OF ROM will trigger that
as well

Ben.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
