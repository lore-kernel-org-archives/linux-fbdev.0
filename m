From: Andrew Morton <akpm@osdl.org>
Subject: Fw: framebuffer blitting performance loss  2.6.12 -> 2.6.13-rc3
Date: Fri, 15 Jul 2005 03:39:12 -0700
Message-ID: <20050715033912.1cd9b6c3.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DtNbz-0003BF-9K
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Jul 2005 03:40:07 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by sc8-sf-mx1.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1DtNbx-0008Gp-U4
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Jul 2005 03:40:07 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Knut Petersen <Knut_Petersen@t-online.de>



Begin forwarded message:

Date: Fri, 15 Jul 2005 12:14:37 +0200
From: Knut Petersen <Knut_Petersen@t-online.de>
To: linux-kernel@vger.kernel.org
Subject: framebuffer blitting performance loss  2.6.12 -> 2.6.13-rc3


Hi everybody!

There is a serious performance loss between 2.6.12 and 2.6.13-rc3
affecting _all_ framebuffer devices, especially those with fast
bitblit functions.

System: Via Epia 5000
CPU: Via Samuel 2, 533MHz
Graphics core: Cyberblade/i1 (Blade 3D core integrated in 8601A)
Framebuffer driver: Not yet released fully accelerated framebuffer
                    driver cyblafb


Test setup
==========

video mode: 1280x1024, vyres=2662, bpp=8, 8x16 font, ypan scrollmode
kernel 2.6.13-rc3 is compiled with HZ==1000

Measurement 1: Compile framebuffer modules
       Result: 2.6.13-rc3 is slightly slower, but this is an almost
               invisible performance loss of about 1%

Measurement 2: time cat of file consisting of 2000 empty lines
       Result:
                                          |  2.6.12 / 2.6.13-rc3
------------------------------------------+----------------------
total time                                |  0.182s / 0.220s


Measurement 3: time cat of file consisting of 2000 full lines of
               160 characters each. Result:

       Result:
                                          |  2.6.12 / 2.6.13-rc3
------------------------------------------+----------------------
total time                                |  0.853s / 1.062s
time spent in framebuffer bitblit routine |  0.256s / 0.257s
time spent for kernel bitblit overhead    |  0,426s / 0.623s !!!
other time (scrolling, disk io etc)       |  0,171s / 0,182s


Discussion of measurements
==========================

Framebuffer compiling shows that the general kernel performance is
more or less unchanged between 2.6.12 and 2.6.13-rc3.

Cat-ing of the file consisting of 2000 empty lines takes about 20.9%
more time, cat-ing of the file consisting of 2000 full lines takes about
24% more time.

As the time spent in the bitblit function of the framebuffer driver
does not change I do assume that the data sent to the framebuffer
driver has not changed. But the new routines take about 46% longer.

All framebuffer drivers should be affected by this performance loss,
but the faster the bitblit of the used framebuffer driver is, the
more it will affect the general performance. You will not see such
a great difference if e.g. vesafb is used.

Please have a serious look at the changed code of fbcon/fbmem etc
or switch back to the old routines.

cu,
 Knut
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
