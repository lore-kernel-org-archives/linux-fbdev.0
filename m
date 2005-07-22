From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: hwd accel framebuffer: Newbi question (sleep in sync)
Date: Fri, 22 Jul 2005 11:58:19 +0800
Message-ID: <200507221158.20147.adaplas@gmail.com>
References: <42D22809.8070800@users.sourceforge.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dvpfk-0000pw-BL
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 21 Jul 2005 22:02:08 -0700
Received: from rproxy.gmail.com ([64.233.170.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Dvpfk-0001a6-6D
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 21 Jul 2005 22:02:08 -0700
Received: by rproxy.gmail.com with SMTP id g11so138144rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 21 Jul 2005 22:02:03 -0700 (PDT)
In-Reply-To: <42D22809.8070800@users.sourceforge.net>
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
To: linux-fbdev-devel@lists.sourceforge.net, Andrey Volkov <andreyvolkov@users.sourceforge.net>

On Monday 11 July 2005 16:04, Andrey Volkov wrote:
> Hi all,
>
> Anyone could explain me, could I or couldn't
> use process sleep (i.e. wait_for..., sleep_on...)
> in fb_info->fb_sync and/or in any hwd accelerated routines (i.e. blit,
> cursor and rectfill)?

No, in general, it's not safe to sleep in some of the fb_xxx routines,
especially when fbdev is used by fbcon.

> Code, which now in kernel, look terrible for me (counter based pooling).
> Must it be so?

Yes, because of the above reason. A few drivers though test a "can_sleep"
flag and alter behavior between looping and sleeping.

Tony



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
