From: Andrey Utkin <andrey_utkin@fastmail.com>
Date: Sat, 19 Nov 2016 18:26:01 +0000
Subject: Re: [PATCH v4.2 0/2] console: Add persistent scrollback buffers for all VGA console
Message-Id: <1479579961.1060082.793173033.0E4E8EEE@webmail.messagingengine.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: =?utf-8?Q?=3C201611170549=2EQ3WT?=
 =?utf-8?Q?foMB=C3=83=C2=BEngguang=2Ewu=40i?=
 =?utf-8?Q?ntel=2Ecom=3E=20=3C1479410?= =?utf-8?Q?777-6702-1-git-sen?=
 =?utf-8?Q?d-email-manuel=2Esch?= =?utf-8?Q?oelling=40gmx=2Ede=3E?=
In-Reply-To: <1479410777-6702-1-git-send-email-manuel.schoelling@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: =?utf-8?Q?Manuel=20Sch=C3=B6lling?= <manuel.schoelling@gmx.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jslaby@suse.cz, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Got into trouble sending my replies to LKML from Mutt, getting delivery
rejections related to encoding:

https://gist.github.com/andrey-utkin/b204666c34613858a34844283571ce17

Sorry for people who got excessive resends from me. For now I'm sending
this from web interface, hopefully it gets things right.

Hi Manuel,

I have tested your patches with v4.8.8 kernel on Gentoo system. Just
took me a little time to figure out that what my system uses as "raw
console" is not vgacon driver, but fbcon. In order to override defaults
and get VGA console, I had to add kernel bootargs "nofb nomodeset". A
pleasant byproduct of switching to VGA console was the fact that
the earliest printouts of kernel loading stage are preserved in
scrollback so I can look at them. However, vgacon is not compatible with
usage of modern graphical modes.

So your patch really works with native VGA console. This is very nice.
Thank you for filling this long-living feature gap.

Tested-by: Andrey Utkin <andrey_utkin@fastmail.com>

Now would you consider implementing same feature also for fbcon? As I
see it lacks same feature. I guess it may be harder because of support
of graphics (penguins on the top of screen, direct graphical output into
framebuffer-driven console - see "links -g", "fbgs", "mplayer -vo fbdev"
and so on).

P. S. I forgot to mention in my previous code review comments that both
patches have some checkpatch issues, and it should be quite easy to
perfect the patches to make checkpatch happy even in "--strict" mode.
You can use "--fix-inplace" by the way, it may solve most of that, just
review what exactly it changes so that it doesn't garble what is right.

Cheers!
