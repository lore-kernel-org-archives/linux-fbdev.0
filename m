From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: [patch] radeonfb: FB_WAITFORVSYNC
	implementation
Date: Wed, 16 Mar 2005 01:19:14 -0500
Message-ID: <1110953954.5535.49.camel@localhost>
References: <1110636406.5997.86.camel@atlantis.netenviron.com>
	 <20050312151318.GA27200@sci.fi>
	 <1110936530.5511.20.camel@africa.netenviron.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBRsJ-0003nA-SB
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 22:19:23 -0800
Received: from darkcity.gna.ch ([195.226.6.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DBRsH-0004Lb-0v
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 22:19:23 -0800
Received: from localhost (localhost [127.0.0.1])
	by darkcity.gna.ch (Postfix) with ESMTP id 1294F18D09D
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Mar 2005 07:19:20 +0100 (CET)
Received: from unknown by localhost (amavisd-new, unix socket)
 id client-XX0nhWXv for <linux-fbdev-devel@lists.sourceforge.net>;
 Wed, 16 Mar 2005 07:19:18 +0100 (CET)
Received: from localhost (CPE001124084852-CM014500006147.cpe.net.cable.rogers.com [65.48.154.37])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by darkcity.gna.ch (Postfix) with ESMTP id CE2BD18D09D
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Mar 2005 07:19:16 +0100 (CET)
Received: from daenzer by localhost with local (Exim 4.50)
	id 1DBRsA-0002Vp-K2
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Mar 2005 01:19:14 -0500
In-Reply-To: <1110936530.5511.20.camel@africa.netenviron.com>
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
Content-Type: text/plain; charset="utf-8"
To: linux-fbdev-devel@lists.sourceforge.net

On Wed, 2005-03-16 at 01:28 +0000, Torgeir Veimo wrote:
> On Sat, 2005-03-12 at 17:13 +0200, Ville Syrj=C3=A4l=C3=A4 wrote:
> > On Sat, Mar 12, 2005 at 02:06:45PM +0000, Torgeir Veimo wrote:
>=20
> > > +		/* clear interrupt */
> > > +		//OUTREG(GEN_INT_CNTL, int_cntl | CRTC_VBLANK_STAT_ACK);
> >=20
> > Why is this commented out?
>=20
> Well, first of all is it really important to clear the interrupt when
> enabling it?=20
>=20
> From what I've seen the rage128 acknowledges an interrupt by writing to
> the int_cntl register, while the radeon does it by writing to the
> int_status register, so I think the above code is not correct..=20

That's right, so the int_cntl stuff in the interrupt handler is
superfluous?


> I based my code on the matrox fb driver and the atyfb driver. I don't
> have any documentation on the radeon chipsets, so am working on what I
> can gather on the net.

Let me point out again that the DRM has perfectly working code for
this...


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
