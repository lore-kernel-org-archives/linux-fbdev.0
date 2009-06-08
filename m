From: InKi Dae <daeinki@gmail.com>
Subject: Samsung SoC Framebuffer Driver issue.
Date: Mon, 8 Jun 2009 13:53:32 +0900
Message-ID: <90b950fc0906072153j6308059eq4d6f864c97a2003d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <daeinki@gmail.com>) id 1MDWrX-0007wV-4l
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 08 Jun 2009 04:53:35 +0000
Received: from mail-px0-f195.google.com ([209.85.216.195])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MDWrW-0007t1-48 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 08 Jun 2009 04:53:35 +0000
Received: by pxi33 with SMTP id 33so252760pxi.28
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 07 Jun 2009 21:53:32 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: ben@simtec.co.uk
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Hello,  Ben  Dooks.

I am trying to develop Samsung SoC Framebuffer Driver for S5PC100 but
I faced some problems about design. so I have some questions about those.

there are some differences between LCD Controller registers of S3C64XX
and S5PC100 like the following.

. regiters not used by S3C64XX were added to S5PC100 also BPP MODE.
. WindowX Palette Data Index registers were removed from lcd
controller of S3C64XX and Palette Memory Registers were added to one
of S5PC100


1.
Your framebuffer driver, drivers/video/s3c-fb.c, is related to only S3C64XX.
and I'd like to divide framebuffer driver into common logical driver
for supporting S3C64XX and S5PC100 and S5PC100 specific driver.
but your driver needs to modifying because calling register control
commands in s3c-fb.c directly.

How do you think about that ?

2.
S3C64XX LCD Controller's registers are similar with S5PC100's, so I
wouldn't modify register prefix.
but some registers should added to definition file
(arch/arm/mach-s3c6400/include/mach/regs-fb.h).

which way do you prefer adding some registers to
arch/arm/mach-s3c6400/include/mach/regs-fb.h or creating new
definition file for S5PC100 ?

If you give me your comments for the issues above, I will modify
Samsung SoC Framebuffer Driver to be supported for S3C64XX and
S5PC100.
In the result, I expect that your driver will be divided into logical
driver and specific driver supporting S3C64XX and S5PC100 or either
S3C64XX or S5PC100.
If the driver would be completed, logical driver, s3c-fb.c, would
support S3C64XX, S5PC100 and also S5PC110.

Please give me your comments and advices.

Best Regards,
InKi Dae.

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
