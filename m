From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Fw: [Bugme-new] [Bug 4217] New: radeonfb makes system hang and
 LCD "burn"
Date: Wed, 16 Feb 2005 08:49:02 +1100
Message-ID: <1108504143.13376.14.camel@gaston>
References: <20050215121555.54c63ed2.akpm@osdl.org>
	 <1108502142.13394.2.camel@gaston>  <87fyzxsdo7.fsf@kataplop.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1AZv-0000Gm-Fh
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Feb 2005 13:49:55 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D1AZu-0000S3-4E
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Feb 2005 13:49:55 -0800
In-Reply-To: <87fyzxsdo7.fsf@kataplop.net>
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

On Tue, 2005-02-15 at 22:42 +0100, Marc Poulhi=E8s wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>=20
> > On Tue, 2005-02-15 at 12:15 -0800, Andrew Morton wrote:
> >>=20
> >> Begin forwarded message:
> >>=20
> >> Date: Tue, 15 Feb 2005 12:03:52 -0800
> >> From: bugme-daemon@osdl.org
> >> To: bugme-new@lists.osdl.org
> >> Subject: [Bugme-new] [Bug 4217] New: radeonfb makes system hang and =
LCD "burn"
> >
> > What if you load the module with option "default_dynclk=3D-1" ?
> >
> > (Or if radeonfb is built-in, do radeonfb.default_dynclk=3D-1 on the k=
ernel
> > command line).=20
>=20
> Seems to work a bit more. Module loads correctly, system is still
> responding, but display is not correct. System caret seems to be the
> only thing displayed, and it moves when I type, but no characters get
> displayed.
>=20
> Do you need some more informations? (like debug output)=20

Try building radeonfb in the kernel and booting with
radeonfb.default_dynclk=3D-1, let me know if that works. fbdev's in
modules have always been sort-of dodgy....

The "dynclk" thing has issues, the upstream code from ATI has some bugs
plus there is something weird going on which I suspect might be a
miscompile of a bit of code in there. I'll send a patch working around
that today.

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
