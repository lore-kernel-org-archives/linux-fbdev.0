From: Torgeir Veimo <torgeir@pobox.com>
Subject: Re: [patch] radeonfb: FB_WAITFORVSYNC
	implementation
Date: Sat, 12 Mar 2005 16:59:19 +0000
Message-ID: <1110646759.5997.90.camel@atlantis.netenviron.com>
References: <1110636406.5997.86.camel@atlantis.netenviron.com>
	 <20050312151318.GA27200@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DA9xQ-0006zC-Gq
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 08:59:20 -0800
Received: from orb.pobox.com ([207.8.226.5])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DA9xO-0006Zr-Vg
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 08:59:20 -0800
Received: from orb (localhost [127.0.0.1])
	by orb.pobox.com (Postfix) with ESMTP id 821515D
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Mar 2005 11:59:16 -0500 (EST)
Received: from [192.168.1.18] (iampivot.plus.com [81.174.152.151])
	(using SSLv3 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by orb.sasl.smtp.pobox.com (Postfix) with ESMTP id 3439A8B
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Mar 2005 11:59:16 -0500 (EST)
In-Reply-To: <20050312151318.GA27200@sci.fi>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: linux-fbdev-devel@lists.sourceforge.net

On Sat, 2005-03-12 at 17:13 +0200, Ville Syrj=E4l=E4 wrote:
> On Sat, Mar 12, 2005 at 02:06:45PM +0000, Torgeir Veimo wrote:
> > This is an implementation of the FB_WAITFORVSYNC ioctl for the radeon=
fb.
> > A small test application is attached at the end. This patch is agains=
t
> > vanilla 2.6.11.
>=20
> Some comements below.

Ok, I'll provide a new patch with fixes for these..

> Also adding support for FB_ACTIVATE_VBL should be quite simple now.

I guess it would require storing values, and apply the at the next vsync
irq. What operations would be interesting to do this way?


--=20
Torgeir Veimo <torgeir@pobox.com>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
