From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: PATCH: move soft_cursor into fbconsole
Date: Mon, 25 Jul 2005 12:45:46 -0400
Message-ID: <9e4733910507250945395b665f@mail.gmail.com>
References: <9e47339105061021571f479b10@mail.gmail.com>
	 <Pine.LNX.4.56.0507020030120.14405@pentafluge.infradead.org>
	 <9e473391050701175679f468ff@mail.gmail.com>
	 <200507231305.59225.adaplas@gmail.com>
	 <9e473391050723084153d29566@mail.gmail.com>
	 <Pine.LNX.4.56.0507251729430.21629@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dx660-0006DQ-PE
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 25 Jul 2005 09:46:28 -0700
Received: from wproxy.gmail.com ([64.233.184.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Dx65Z-0003ij-2P
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 25 Jul 2005 09:46:28 -0700
Received: by wproxy.gmail.com with SMTP id i3so994232wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 25 Jul 2005 09:45:46 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.56.0507251729430.21629@pentafluge.infradead.org>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net

On 7/25/05, James Simmons <jsimmons@infradead.org> wrote:
>=20
> > 1) the current ioctl one
>=20
> Defunct.
>=20
> > 2) the new stuff in sysfs. If the hardware cursor is there you get a sy=
sfs
> > attribute named cursor. write x,y to it to move the cursor around. I'll=
 add
> > the sysfs support as soon as we decide on the interface.
>=20
> I was playing with that a bit.
>=20
> > I'm still at OLS. Missed seeing both of you at KS. fbdev was discussed =
and
> > Linus went with Benh's proposal to move the modesetting API to user spa=
ce.
> > Obviously this will have a lot of impact on fbdev.
>=20
> I don't have any money to go to such events :-( Looks like fbdev is going
> away completly :-< We will need embedded graphics libraries to boot a
> machine in the future. I seen this coming and thats why my motivation for
> development keeps dropping. I suggest they make a big diff to remove the
> whole system.

It is a long way from Linus telling BenH to go ahead and having a
replacement system in the kernel. My bet is that userspace mode
setting only happens for a couple of chips. I don't see a lot of
people jumping up to replace the existing system. I was pushing to
keep fbdev the way it is but without either of the maintainers there
to defend fbdev it is a hard sell.

If you write a paper for OLS, get it accepted and present it; the
sponsors will probably pay your airfare. Hotels can be had for
$40/night. Work on Ted to get an invite to Kernel Summit and then give
him four months notice that you need airfare and you'll probably get
it.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
