From: Torgeir Veimo <torgeir@pobox.com>
Subject: Re: [patch] radeonfb: FB_WAITFORVSYNC
	implementation
Date: Wed, 16 Mar 2005 01:28:50 +0000
Message-ID: <1110936530.5511.20.camel@africa.netenviron.com>
References: <1110636406.5997.86.camel@atlantis.netenviron.com>
	 <20050312151318.GA27200@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBNLF-0002H3-2U
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 17:28:57 -0800
Received: from orb.pobox.com ([207.8.226.5])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DBNLE-0002ck-Hm
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 17:28:57 -0800
Received: from orb (localhost [127.0.0.1])
	by orb.pobox.com (Postfix) with ESMTP id 876C2E5
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Mar 2005 20:28:53 -0500 (EST)
Received: from 192.168.1.13 (iampivot.plus.com [81.174.152.151])
	(using SSLv3 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by orb.sasl.smtp.pobox.com (Postfix) with ESMTP id 38B528F
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Mar 2005 20:28:53 -0500 (EST)
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
>=20
> > +	spinlock_t		int_lock;
>=20
> Unused spinlock.

Removed. Something leftover as I experimented to get it to work
properly..


> > +		/* clear interrupt */
> > +		//OUTREG(GEN_INT_CNTL, int_cntl | CRTC_VBLANK_STAT_ACK);
>=20
> Why is this commented out?

Well, first of all is it really important to clear the interrupt when
enabling it?=20

From what I've seen the rage128 acknowledges an interrupt by writing to
the int_cntl register, while the radeon does it by writing to the
int_status register, so I think the above code is not correct.. I might
want to clear any vblank interrupts by writing to the int_status
register though.

I based my code on the matrox fb driver and the atyfb driver. I don't
have any documentation on the radeon chipsets, so am working on what I
can gather on the net.

--=20
Torgeir Veimo <torgeir@pobox.com>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
