From: James Simmons <jsimmons@infradead.org>
Subject: Re: 2.6.0-test8 - CONFIG_PCI_CONSOLE
Date: Tue, 21 Oct 2003 19:07:06 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0310211906240.32738-100000@phoenix.infradead.org>
References: <200310210120.h9L1K3Fg002814@turing-police.cc.vt.edu>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <200310210120.h9L1K3Fg002814@turing-police.cc.vt.edu>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Valdis.Kletnieks@vt.edu
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


I have had the question. It appears to be dead code. unless someone speaks 
up I will remove that code.


On Mon, 20 Oct 2003 Valdis.Kletnieks@vt.edu wrote:

> in drivers/video/console/Kconfig, we have:
> 
> config PCI_CONSOLE
>         bool
>         depends on FRAMEBUFFER_CONSOLE
>         default y
> 
> However, it's unclear what this variable actually *DOES*:
> 
> [/usr/src/linux-2.6.0-test8-mm1-a]2 find . ! -name '*.o' | xargs grep PCI_CONS
> ./drivers/video/console/Kconfig:config PCI_CONSOLE
> ./arch/ppc/configs/power3_defconfig:CONFIG_PCI_CONSOLE=y
> ./arch/ppc/configs/common_defconfig:CONFIG_PCI_CONSOLE=y
> ./arch/ppc/configs/sandpoint_defconfig:CONFIG_PCI_CONSOLE=y
> ./arch/ppc/configs/ibmchrp_defconfig:CONFIG_PCI_CONSOLE=y
> ./arch/ppc/configs/pmac_defconfig:CONFIG_PCI_CONSOLE=y
> ./arch/ppc/defconfig:CONFIG_PCI_CONSOLE=y
> ./arch/sparc64/defconfig:CONFIG_PCI_CONSOLE=y
> ./arch/ia64/defconfig:CONFIG_PCI_CONSOLE=y
> ./arch/ppc64/defconfig:CONFIG_PCI_CONSOLE=y
> ./arch/parisc/defconfig:CONFIG_PCI_CONSOLE=y
> ./.config.old:CONFIG_PCI_CONSOLE=y
> ./config.old:CONFIG_PCI_CONSOLE=y
> 
> References in defconfig files, and in my .config, and that's about it...
> 
> It's been apparently dead code at least as far back as -test5-mm3.
> 
