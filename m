From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: PATCH: move soft_cursor into fbconsole
Date: Sat, 23 Jul 2005 13:05:57 +0800
Message-ID: <200507231305.59225.adaplas@gmail.com>
References: <9e47339105061021571f479b10@mail.gmail.com> <Pine.LNX.4.56.0507020030120.14405@pentafluge.infradead.org> <9e473391050701175679f468ff@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DwCDP-00060k-TD
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Jul 2005 22:06:23 -0700
Received: from zproxy.gmail.com ([64.233.162.203])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DwCDO-0006NX-EQ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Jul 2005 22:06:23 -0700
Received: by zproxy.gmail.com with SMTP id s18so316338nze
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 22 Jul 2005 22:06:12 -0700 (PDT)
In-Reply-To: <9e473391050701175679f468ff@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>, James Simmons <jsimmons@www.infradead.org>
Cc: James Simmons <jsimmons@pentafluge.infradead.org>, adaplas@pol.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Saturday 02 July 2005 08:56, Jon Smirl wrote:
> Another way to think of this, let's make another member variable
> .fb_hwcursor. When the driver has a hardware cusor is sets
> .fb_hwcursor. If you want to use the software cursor use the exisiting
> .fb_cursor.
>
> If you think about it every driver is going to have the exact same
> assignment .fb_cursor = soft_cursor. If every driver is going to have
> exactly the same assignment, why do we need the variable?
>
> It's the existence of the hardware cursor that varies from driver to
> driver, that's the one we need the variable for.

Is this resolved?  I tend to agree with Jon.  Let's just remove all
references to soft_cursor from all drivers, and let fbcon_cursor() fall back
to soft_cursor when xxxfb_cursor() is absent.  It is a lot cleaner and saner
this way, and although it touches all drivers, it is a singe logical change,
so it's acceptable.

Also, I think it might be preferable to have 2 cursor hooks, one
is fbcon-specific, and the other is for use only in userspace, which needs
to be more comprehensive.  Or if a single but comprehensive cursor API is
preferred, then we just adapt fbcon_cursor to use the more powerful
cursor API.  

So, anyone want to propose a cursor API for fbdev, that is both usable by
fbcon and userspace?

Tony




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
