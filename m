From: Olaf Hering <olh@suse.de>
Subject: Re: tty open screws X color palette
Date: Sun, 15 Aug 2004 08:32:51 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040815063251.GA23843@suse.de>
References: <20040813114713.GA2168@suse.de> <200409150902.27378.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BwEZa-0007gc-RQ
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 14 Aug 2004 23:32:54 -0700
Received: from cantor.suse.de ([195.135.220.2])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34)
	id 1BwEZa-000070-8x
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 14 Aug 2004 23:32:54 -0700
Content-Disposition: inline
In-Reply-To: <200409150902.27378.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="windows-1252"
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

 On Wed, Sep 15, Antonino A. Daplas wrote:

> On Friday 13 August 2004 19:47, Olaf Hering wrote:
> > An 'echo foo > /dev/tty42' while X runs will screw the color palette,=
 if
> > tty42 wasnt in use before. Tested on ibook G3 and G4.
> > This will happen with rage128 and radeonfb in 2.6.5 and later,
> > X version is 4.3.99.
> >
> > X runs usually with a different color depth than the kernel framebuff=
er
> > console.
> > How can this be fixed? tty open should not touch the hardware if the =
tty
> > is not active.
>=20
> I tried the above and nothing happens to X.  My setup is X86 nVidia AGP
> on rivafb linux-2.6.8-rc4-mm1.

Do you have 'Option "usefbdev" "true"' in our XF86Config?

--=20
USB is for mice, FireWire is for men!

sUse lINUX ag, n=C3=9CRNBERG


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
