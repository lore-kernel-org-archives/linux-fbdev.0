From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: PATCH: move soft_cursor into fbconsole
Date: Wed, 15 Jun 2005 23:37:15 -0400
Message-ID: <9e4733910506152037193300fa@mail.gmail.com>
References: <9e47339105061021571f479b10@mail.gmail.com>
	 <Pine.LNX.4.62.0506120942100.11197@numbat.sonytel.be>
	 <9e47339105061518346d1df105@mail.gmail.com>
	 <200506161111.27115.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DilBt-0006dD-SY
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Jun 2005 20:37:17 -0700
Received: from wproxy.gmail.com ([64.233.184.194])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DilBs-0000y4-Ga
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Jun 2005 20:37:17 -0700
Received: by wproxy.gmail.com with SMTP id 37so167075wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 15 Jun 2005 20:37:15 -0700 (PDT)
In-Reply-To: <200506161111.27115.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@pentafluge.infradead.org>

On 6/15/05, Antonino A. Daplas <adaplas@hotpop.com> wrote:
> On Thursday 16 June 2005 09:34, Jon Smirl wrote:
> > Are there still issues with this patch?
>=20
> Maybe.  A few drivers will set the fb_cursor field to either
> soft_cursor or the driver-specific cursor function, depending
> on the kernel boot options or setting of the var.accel flag.

I think there were three driver implementing hardware cursors.=20
I tried to keep them working, they only needed minor touchups.

If they had fallbacks to the software cursor I removed those and
returned an error instead. Instead fbconsole will get the error and
switch to software cursor. If HW cursors are going to work from user
space they can't contain SW cursor fallbacks.

The patch should move softcursor.c into the fbconsole subdirectory but
I can't figure out how to do that with git yet.

>=20
> The changes required are probably minor.
>=20
> Tony
>=20
>=20
>=20
>=20


--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
