From: Otto Solares <solca@guug.org>
Subject: Re: [PATCH] neofb patches
Date: Wed, 28 Apr 2004 10:37:30 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040428163730.GA24448@guug.org>
References: <Pine.LNX.4.44.0404271938330.20536-100000@phoenix.infradead.org> <408EE34F.8080106@undead.cc> <1083107454.16544.42.camel@gaston> <20040428002037.GE22495@guug.org> <1083112565.20473.10.camel@gaston> <20040428070832.GA23411@guug.org> <1083147416.18416.24.camel@thor.asgaard.local>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIs3i-0008FV-Mt
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 09:37:18 -0700
Received: from guug.org ([168.234.203.30])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIs3i-0005u6-De
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 09:37:18 -0700
Content-Disposition: inline
In-Reply-To: <1083147416.18416.24.camel@thor.asgaard.local>
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
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, Apr 28, 2004 at 12:16:56PM +0200, Michel D=E4nzer wrote:
> On Wed, 2004-04-28 at 09:08, Otto Solares wrote:
> >=20
> > I like the fbdev abstraction but it has too many limitations:
>=20
> [...]
>=20
> > - It dangerously coexists currently with the DRM queues and
> >   SAREA areas. =20
>=20
> How does a DRM SAREA matter to a framebuffer device?

It matters as long as the SAREA have a hardware lock
to synchronize access to the hardware.  That lock must
be owned by a single entity in the kernel, or at least
the fbdev drivers must be aware of that lock, it would
be more simple if the fbdev drivers take care of it being
the single entity in the kernel taking care of the
hardware.

> > Both must merge in fbdev.
>=20
> I agree that they should cooperate properly, but I don't see how it
> follows that they must merge.

DRM and fbdev must merge so i repeat: just a single
kernel entity should own FIFO queues, shared locks,
DMA, the framebuffer, IO registers, interrupts, etc.

-otto



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g.=20
Take an Oracle 10g class now, and we'll give you the exam FREE.=20
http://ads.osdn.com/?ad_id=3D3149&alloc_id=3D8166&op=3Dclick
