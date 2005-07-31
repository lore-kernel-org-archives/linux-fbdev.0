From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [BUG] Strange interaction between X and /dev/fb0
 + /dev/fb1
Date: Sun, 31 Jul 2005 13:53:42 +0800
Message-ID: <42EC6766.2020807@gmail.com>
References: <42EC5F11.2070606@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dz6lg-0001Dq-HJ
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 30 Jul 2005 22:53:48 -0700
Received: from wproxy.gmail.com ([64.233.184.200])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Dz6lg-0002N8-D4
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 30 Jul 2005 22:53:48 -0700
Received: by wproxy.gmail.com with SMTP id 36so850022wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 30 Jul 2005 22:53:38 -0700 (PDT)
In-Reply-To: <42EC5F11.2070606@t-online.de>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Knut Petersen wrote:
> Hi everybody,
> 
>  1: the system boots with video=vesafb:ypan
>  2: cyblafb is loaded by the boot.local script
>  3: con2vt /dev/fb1 /dev/tty1
>  4: runlevel 3 (no X) is used
> 
> As cyblafb detects the video mode used by vesafb, everything works
> fine. If I switch to tty1, the accelerated cyblafb driver is used, all 
> other
> ttys use the slow  vesafb code.
> I can unload cyblafb after a con2ct /dev/fb0 /dev/tty1, load it again, 
> switch
> between ttys, everything without a problem.
> 
> Now I switch to runlevel 5.
> 
>  1: Switching from X to any tty, no matter if it is managed
>     by vesafb or cyblafb,does work without problems.

X restores, at least partially, the state of the card, then set_par
is called which fully restores the state of cyblafb.

>  2: Switching from any tty to X works without a problem.

X usually does a good job of restoring it's own state.

>  3: Switching from X to any tty except tty1 (managed by cyblafb)
>     and then between any ttys works without problems.

Vesa state is usually restored fully by X, so even if vesafb has
no set_par, vesafb comes back working.

> 
>  4: Switching from X to tty1 and then to any other tty does _not_
>     work. The cursor stops blinking, otherwise nothing changes
>     on the monitor. Blindly entered commands produce no visible
>     output, but they are executed.

I don't know why.  But try switching from tty1->X->tty1->!tty1 and
!tty1->X->tty1->!tty1. Do you still get the same behavior?
 
Tony


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
