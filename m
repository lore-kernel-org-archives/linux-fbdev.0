From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: PATCH: move soft_cursor into fbconsole
Date: Fri, 1 Jul 2005 20:28:08 -0400
Message-ID: <9e473391050701172831e522e7@mail.gmail.com>
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
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DoVrk-0002Gi-7O
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 01 Jul 2005 17:28:16 -0700
Received: from wproxy.gmail.com ([64.233.184.200])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DoVrh-0002Lo-Rk
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 01 Jul 2005 17:28:15 -0700
Received: by wproxy.gmail.com with SMTP id i1so429794wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 01 Jul 2005 17:28:08 -0700 (PDT)
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

On 7/1/05, James Simmons <jsimmons@www.infradead.org> wrote:
> I don't want to make a patch that touches all the drivers. Th epatch I
> posted is a nice simple patch. If there are no other arguments against it
> I like to submit it to Andrew.

But we agreed that having the drivers fallback to the softcursor is
the wrong general thing to do since it only works for fbconsole. Why
do we want to keep code in place when we agree that it is not needed?
All it does is add clutter to the driver code.

You don't need to make the patch, I already made it for you.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
