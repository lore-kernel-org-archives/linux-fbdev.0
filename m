From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 05/05] sh: enable deferred io LCDC on Migo-R
Date: Fri, 19 Dec 2008 15:34:50 +0900
Message-ID: <20081219063450.2703.46469.sendpatchset@rx1.opensource.se>
References: <20081219063359.2703.85817.sendpatchset@rx1.opensource.se>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20081219063359.2703.85817.sendpatchset@rx1.opensource.se>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, adaplas@gmail.com, linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Enable LCDC deferred io on Migo-R using 1s delay.

As with other deferred io frame buffers user space code should
use fsync() on the frame buffer device to trigger an update.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/mach-migor/setup.c |    2 ++
 1 file changed, 2 insertions(+)

--- 0008/arch/sh/boards/mach-migor/setup.c
+++ work/arch/sh/boards/mach-migor/setup.c	2008-12-18 13:59:06.000000000 +0900
@@ -262,6 +262,8 @@ static struct sh_mobile_lcdc_info sh_mob
 		.sys_bus_cfg = {
 			.ldmt2r = 0x06000a09,
 			.ldmt3r = 0x180e3418,
+			/* set 1s delay to encourage fsync() */
+			.deferred_io_msec = 1000,
 		},
 	}
 #endif
