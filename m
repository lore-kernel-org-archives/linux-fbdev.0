From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc3 06/10] gumstix: conversion
	to MFP support and add bluetooth support
Date: Thu, 3 Jul 2008 22:01:07 -0700
Message-ID: <45a44e480807032201y5fac43abpc47082e9df46aede@mail.gmail.com>
References: <1213289961-1562-1-git-send-email-jayakumar.lkml@gmail.com>
	<1213289961-1562-7-git-send-email-jayakumar.lkml@gmail.com>
	<4851D4E9.3080008@gmail.com>
	<45a44e480806142251x61462e2ft839332de6c2fbe1c@mail.gmail.com>
	<4855CE39.2090702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KEdQ0-0006y0-AQ for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 Jul 2008 22:01:12 -0700
Received: from ik-out-1112.google.com ([66.249.90.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KEdPw-0005PU-TJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 Jul 2008 22:01:12 -0700
Received: by ik-out-1112.google.com with SMTP id c21so501620ika.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 03 Jul 2008 22:01:07 -0700 (PDT)
In-Reply-To: <4855CE39.2090702@gmail.com>
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

On Sun, Jun 15, 2008 at 7:21 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> OK, so I assume with the latest u-boot (I mean after Jan 27, 2006), it
> should boot up with 32KHz timer enabled, and you don't really need to
> enable OSCC by default, right? Or would you be kind enough to test that
> out?

Yes, you're right, it should get enabled by default with the newer
u-boot. I'll try it out. A bit scared about reflashing the boot loader
because the gumstix model that I have doesn't have JTAG. :-)

> You see, I'm a bit conservative to add clk support for 32KHz timer in
> the kernel, as that should be started earlier, most suitable place will
> be in the boot loader. If this doesn't work, we have to work it out in
> another way.

Agreed.

Thanks,
jaya

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
