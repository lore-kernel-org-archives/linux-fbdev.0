From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Reading the EDID block for x86 machines
Date: 13 Mar 2003 01:38:19 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047490638.1028.29.camel@localhost.localdomain>
References: <1047386934.1113.35.camel@localhost.localdomain> 
	<20030312141022.A6984@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18tAEN-0001GJ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Mar 2003 09:41:32 -0800
In-Reply-To: <20030312141022.A6984@sci.fi>
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
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-03-12 at 20:10, Ville Syrj=E4l=E4 wrote:
> On Tue, Mar 11, 2003 at 08:49:46PM +0800, Antonino Daplas wrote:
> > Hi,
> >=20
> > I was wondering how to get the EDID block, and my first thought was to
> > implement DDC.  But it is tricky to implement,
>=20
> Forgive my ignorance but why is it tricky? As I understand it DDC1 only
> involves reading from the monitor or does EDID require something more?

It will require that each driver provide a means of getting the EDID
from the monitor, either via i2c or by some hardware specific means.
Matrox users are the fortunate few since the author implemented an i2c
backend.

>=20
> Reading stuff from my monitor via /dev/i2c works fine with matroxfb. I
> just tried this and I can see my monitors model in the returned data but
> parse-edid doesn't understand the data so I'm not sure it's the EDID.
>=20
> Also the BIOS solution will fail when someone decides to change their
> monitor. This got me thinking that with a real DDC solution would it be
> feasible to have the driver re-read the EDID periodically and/or on mode
> switch to prevent using bad modes?
>=20

That's okay.  The get_EDID() function can get the EDID block several
ways.

1.  via the driver if it has its own method of getting the EDID block
(1st choice)

2.  via userland - EDID block (ie get-edid > edid.dmp) uploaded to
driver via ioctl (2nd choice)

3.  through an arch-specific method -- VBE for x86, OF for PPC, etc
(last choice)

When a user changes monitors without rebooting, he/she can upload an
edid block appropriate for the display.

Tony




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
