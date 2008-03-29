From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 1/3 2.6.24] fbdev: platforming metronomefb
	and hecubafb
Date: Sat, 29 Mar 2008 04:50:07 -0400
Message-ID: <20080329085006.6926.54613.sendpatchset@hit-nxdomain.opendns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JfXfq-0006Zs-76 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 29 Mar 2008 02:48:30 -0700
Received: from wa-out-1112.google.com ([209.85.146.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JfXfo-0000gS-Mq
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 29 Mar 2008 02:48:30 -0700
Received: by wa-out-1112.google.com with SMTP id k22so797290waf.18
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 29 Mar 2008 02:48:27 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@linux-foundation.org, Jaya Kumar <jayakumar.lkml@gmail.com>

Hi Tony, Geert, Andrew, fbdev,

Following are 2 patches. They are my first pass at splitting metronomefb and
hecubafb into platform independent (platform drivers) and platform specific
(platform devices) drivers which are am200epd (arm) and n411 (x86).

This code works okay but I'm having some trouble figuring out why module
refcounting and unloading doesn't work on my platform device side of things.
So that's on the todolist. I stuck the headers in include/video but I'm not
sure if that was the right thing to do. I noticed some of the other headers in
there are there in order to share headers with userspace. Would it be better
if I made an include/linux/video or just stuck it in include/linux/ itself?
The overall diffstat is appended below.

I would be grateful for any feedback on this.

Thanks,
jaya

Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>

---

 Documentation/fb/metronomefb.txt |   16 --
 drivers/video/Kconfig            |   33 ++--
 drivers/video/Makefile           |    2 
 drivers/video/am200epd.c         |  278 ++++++++++++++++++++++++++++++++++
 drivers/video/hecubafb.c         |  294 ++++++++----------------------------
 drivers/video/metronomefb.c      |  310 +++++----------------------------------
 drivers/video/n411.c             |  192 ++++++++++++++++++++++++
 include/video/hecubafb.h         |   50 ++++++
 include/video/metronomefb.h      |   61 +++++++
 9 files changed, 726 insertions(+), 510 deletions(-)


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
