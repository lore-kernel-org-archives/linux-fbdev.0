From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [RFC 2.6.26-rc3 07/10] am200epd: move
	am200epd to mach-pxa
Date: Mon, 16 Jun 2008 10:29:23 +0800
Message-ID: <4855D003.1040306@gmail.com>
References: <1213289961-1562-1-git-send-email-jayakumar.lkml@gmail.com>	
	<1213289961-1562-8-git-send-email-jayakumar.lkml@gmail.com>	
	<4851D781.9020007@gmail.com>
	<45a44e480806142323h438e82a6ye4e57e83ce872e1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K84TR-0005s8-G9 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 15 Jun 2008 19:29:37 -0700
Received: from rv-out-0708.google.com ([209.85.198.243])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K84TP-0005kl-4R
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 15 Jun 2008 19:29:37 -0700
Received: by rv-out-0708.google.com with SMTP id f25so4193555rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 15 Jun 2008 19:29:34 -0700 (PDT)
In-Reply-To: <45a44e480806142323h438e82a6ye4e57e83ce872e1b@mail.gmail.com>
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
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

Jaya Kumar wrote:
> On Thu, Jun 12, 2008 at 10:12 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>> Jaya Kumar wrote:
>>> The am200epd driver was designed with bad assumptions. It manipulated
>>> GPSR/GPLR registers directly. It relied on direct access to the pxa LCDC
>>> registers which have since conflicted with commit
>>> ce4fb7b892a6d6c6a0f87366b26fd834d2923dd7 . This patch moves it into
>>> mach-pxa in preparation for an overhaul. This is done as a move rather
>>> than a removal in order to facilitate code review.
>> You may generate the patch with "-M" option, so that git can recognize
>> the file rename/move change.
> 
> Thanks! I had used git-mv and wondered why the patch was just a normal
> diff when I generated it. For any other git newbies like myself, it
> was:
> 
> git-format-patch -M -n --signoff --subject-prefix="RFC 2.6.26-rc3"
> eb90d81d03c0917b0fd629f6342554a3b58ea52c
> and that gives a nice:
> ---
>  arch/arm/mach-pxa/Kconfig                       |   17 +++++++++++++++++
>  arch/arm/mach-pxa/Makefile                      |    1 +
>  {drivers/video => arch/arm/mach-pxa}/am200epd.c |    0
>  drivers/video/Kconfig                           |   13 -------------
>  drivers/video/Makefile                          |    1 -
>  5 files changed, 18 insertions(+), 14 deletions(-)
>  rename {drivers/video => arch/arm/mach-pxa}/am200epd.c (100%)
> 
>> Also, I think it would be better to merge this commit with your
>> following [patch 08] am200epd: conver to share fb and use gpio api,
>> that will be helpful for code review, and "-M" option should be
>> smart enough to make the change clear.
>>
> 
> Ok, git doesn't give me that result. When I merged the move patch with
> the change patch, it no longer detects it as a move. I get the
> following output:
> 
>  arch/arm/mach-pxa/Kconfig    |   17 ++
>  arch/arm/mach-pxa/Makefile   |    1 +
>  arch/arm/mach-pxa/am200epd.c |  347 ++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-pxa/devices.c  |    1 +
>  drivers/video/Kconfig        |   13 --
>  drivers/video/Makefile       |    1 -
>  drivers/video/am200epd.c     |  295 -----------------------------------
>  7 files changed, 366 insertions(+), 309 deletions(-)
>  create mode 100644 arch/arm/mach-pxa/am200epd.c
>  delete mode 100644 drivers/video/am200epd.c
> 
> If it's okay, then I'll just use that when I regenerate the patchset next time.
> 

Either way is fine to me.

> Thanks,
> jaya


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
