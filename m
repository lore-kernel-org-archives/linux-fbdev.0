From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc3 07/10] am200epd: move
	am200epd to mach-pxa
Date: Sun, 15 Jun 2008 02:23:41 -0400
Message-ID: <45a44e480806142323h438e82a6ye4e57e83ce872e1b@mail.gmail.com>
References: <1213289961-1562-1-git-send-email-jayakumar.lkml@gmail.com>
	<1213289961-1562-8-git-send-email-jayakumar.lkml@gmail.com>
	<4851D781.9020007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K7leR-0002Ad-WF for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 14 Jun 2008 23:23:44 -0700
Received: from wf-out-1314.google.com ([209.85.200.174])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K7leP-0005eo-L6
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 14 Jun 2008 23:23:43 -0700
Received: by wf-out-1314.google.com with SMTP id 27so4734065wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 14 Jun 2008 23:23:41 -0700 (PDT)
In-Reply-To: <4851D781.9020007@gmail.com>
Content-Disposition: inline
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
To: Eric Miao <eric.y.miao@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Thu, Jun 12, 2008 at 10:12 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> Jaya Kumar wrote:
>> The am200epd driver was designed with bad assumptions. It manipulated
>> GPSR/GPLR registers directly. It relied on direct access to the pxa LCDC
>> registers which have since conflicted with commit
>> ce4fb7b892a6d6c6a0f87366b26fd834d2923dd7 . This patch moves it into
>> mach-pxa in preparation for an overhaul. This is done as a move rather
>> than a removal in order to facilitate code review.
>
> You may generate the patch with "-M" option, so that git can recognize
> the file rename/move change.

Thanks! I had used git-mv and wondered why the patch was just a normal
diff when I generated it. For any other git newbies like myself, it
was:

git-format-patch -M -n --signoff --subject-prefix="RFC 2.6.26-rc3"
eb90d81d03c0917b0fd629f6342554a3b58ea52c
and that gives a nice:
---
 arch/arm/mach-pxa/Kconfig                       |   17 +++++++++++++++++
 arch/arm/mach-pxa/Makefile                      |    1 +
 {drivers/video => arch/arm/mach-pxa}/am200epd.c |    0
 drivers/video/Kconfig                           |   13 -------------
 drivers/video/Makefile                          |    1 -
 5 files changed, 18 insertions(+), 14 deletions(-)
 rename {drivers/video => arch/arm/mach-pxa}/am200epd.c (100%)

>
> Also, I think it would be better to merge this commit with your
> following [patch 08] am200epd: conver to share fb and use gpio api,
> that will be helpful for code review, and "-M" option should be
> smart enough to make the change clear.
>

Ok, git doesn't give me that result. When I merged the move patch with
the change patch, it no longer detects it as a move. I get the
following output:

 arch/arm/mach-pxa/Kconfig    |   17 ++
 arch/arm/mach-pxa/Makefile   |    1 +
 arch/arm/mach-pxa/am200epd.c |  347 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-pxa/devices.c  |    1 +
 drivers/video/Kconfig        |   13 --
 drivers/video/Makefile       |    1 -
 drivers/video/am200epd.c     |  295 -----------------------------------
 7 files changed, 366 insertions(+), 309 deletions(-)
 create mode 100644 arch/arm/mach-pxa/am200epd.c
 delete mode 100644 drivers/video/am200epd.c

If it's okay, then I'll just use that when I regenerate the patchset next time.

Thanks,
jaya

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
