From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: PATCH: move soft_cursor into fbconsole
Date: Fri, 1 Jul 2005 20:56:22 -0400
Message-ID: <9e473391050701175679f468ff@mail.gmail.com>
References: <9e47339105061021571f479b10@mail.gmail.com>
	 <Pine.LNX.4.56.0506210103540.18685@pentafluge.infradead.org>
	 <9e473391050620173132ea1ce6@mail.gmail.com>
	 <Pine.LNX.4.56.0506240015300.24330@pentafluge.infradead.org>
	 <9e473391050624052640aa5279@mail.gmail.com>
	 <Pine.LNX.4.56.0506241713210.14981@pentafluge.infradead.org>
	 <9e47339105062409276fcd5223@mail.gmail.com>
	 <Pine.LNX.4.56.0506241740220.15430@pentafluge.infradead.org>
	 <9e473391050624102559929cd9@mail.gmail.com>
	 <Pine.LNX.4.56.0507020030120.14405@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DoWJV-0004p2-5h
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 01 Jul 2005 17:56:57 -0700
Received: from wproxy.gmail.com ([64.233.184.205])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DoWJ2-0007va-Dd
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 01 Jul 2005 17:56:56 -0700
Received: by wproxy.gmail.com with SMTP id i1so432634wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 01 Jul 2005 17:56:23 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.56.0507020030120.14405@pentafluge.infradead.org>
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
To: James Simmons <jsimmons@www.infradead.org>
Cc: James Simmons <jsimmons@pentafluge.infradead.org>, adaplas@pol.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Another way to think of this, let's make another member variable
.fb_hwcursor. When the driver has a hardware cusor is sets
.fb_hwcursor. If you want to use the software cursor use the exisiting
.fb_cursor.

If you think about it every driver is going to have the exact same
assignment .fb_cursor =3D soft_cursor. If every driver is going to have
exactly the same assignment, why do we need the variable?

It's the existence of the hardware cursor that varies from driver to
driver, that's the one we need the variable for.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
