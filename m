From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Fw: [Bugme-new] [Bug 4217] New: radeonfb makes system hang and
 LCD "burn"
Date: Thu, 17 Feb 2005 09:15:33 +1100
Message-ID: <1108592133.5533.6.camel@gaston>
References: <20050215121555.54c63ed2.akpm@osdl.org>
	 <1108502142.13394.2.camel@gaston> <87fyzxsdo7.fsf@kataplop.net>
	 <1108504143.13376.14.camel@gaston>  <87r7jggxc7.fsf@kataplop.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1XTX-0005EK-QQ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Feb 2005 14:16:51 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D1XTW-00026W-9P
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Feb 2005 14:16:51 -0800
In-Reply-To: <87r7jggxc7.fsf@kataplop.net>
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
To: Marc =?ISO-8859-1?Q?Poulhi=E8s?= <marc.poulhies@epfl.ch>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2005-02-16 at 19:43 +0100, Marc Poulhi=E8s wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>=20
> > Try building radeonfb in the kernel and booting with
> > radeonfb.default_dynclk=3D-1, let me know if that works. fbdev's in
> > modules have always been sort-of dodgy....
> >
> > The "dynclk" thing has issues, the upstream code from ATI has some bu=
gs
> > plus there is something weird going on which I suspect might be a
> > miscompile of a bit of code in there. I'll send a patch working aroun=
d
> > that today.
> >
> > Ben.
>=20
> Ok, did that. Same result. The only thing displayed is the system
> caret. I can see it moving left and right while the system boots and
> "displays" the messages (X is working nicely).
>=20
> I did compile debug support, so I'm including the output.

Well... looks like radeonfb is actually working ... You can try booting
with radeonfb.noaccel=3D1 on your kernel command line and tell me what's
up ? I looks like your fbcon is having trouble actually. Not sure what's
up, I haven't had any report of that so far.

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
