From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Re: fbdev cursor part 1.
Date: Tue, 24 Feb 2004 02:55:08 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040224005508.GD8088@sci.fi>
References: <Pine.LNX.4.44.0402222234120.2390-100000@phoenix.infradead.org> <1077496550.5960.9.camel@gaston> <Pine.GSO.4.58.0402231156040.14277@waterleaf.sonytel.be> <1077533958.5942.42.camel@gaston> <Pine.GSO.4.58.0402231343270.14277@waterleaf.sonytel.be> <20040223132151.GA7255@sci.fi> <Pine.GSO.4.58.0402231449040.14277@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvQym-0003ZQ-Tr
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Feb 2004 17:03:20 -0800
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvQqs-0005Fw-HP
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Feb 2004 16:55:10 -0800
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 2B1AC1113DE3
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 24 Feb 2004 02:55:09 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0402231449040.14277@waterleaf.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, Feb 23, 2004 at 02:51:07PM +0100, Geert Uytterhoeven wrote:
> On Mon, 23 Feb 2004, Ville [iso-8859-1] Syrj=E4l=E4 wrote:
> > BTW would it be possible to add a new accelerator type for Pro chips.=
 I'd
> > like to identify Pro chips in my DirectFB driver because there are a =
few
> > important differences between Pro and older models. Othwerwise I'm go=
ing
> > to have to the same thing I did with matrox cards and use /proc/bus/p=
ci :(
>=20
> Can't you just check CONFIG_CHIP_ID in your DirectFB driver?

Yes I can ;) I didn't realize the chip kept the device id in it's own=20
register. Thanks.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
