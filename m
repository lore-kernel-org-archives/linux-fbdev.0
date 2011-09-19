From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 19 Sep 2011 06:22:51 +0000
Subject: linux-next: manual merge of the fbdev tree with the mips tree
Message-Id: <20110919162251.aa920a691f34b76d36acd61b@canb.auug.org.au>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Manuel Lauss <manuel.lauss@googlemail.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>

Hi all,

Today's linux-next merge of the fbdev tree got a conflict in
drivers/video/Kconfig between commit 9d7dec27ace1 ("MIPS: Alchemy: remove
all CONFIG_SOC_AU1??? defines") from the mips tree and commit
4ee584615102 ("au1200fb: switch to FB_SYS helpers") from the fbdev tree.

Just context changes. I fixed it up (see below) and can carry the fix as
necessary.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --cc drivers/video/Kconfig
index 55a7df4,8165c55..0000000
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@@ -1755,10 -1764,11 +1764,11 @@@ config FB_AU110
  
  config FB_AU1200
  	bool "Au1200 LCD Driver"
 -	depends on (FB = y) && MIPS && SOC_AU1200
 +	depends on (FB = y) && MIPS_ALCHEMY
- 	select FB_CFB_FILLRECT
- 	select FB_CFB_COPYAREA
- 	select FB_CFB_IMAGEBLIT
+ 	select FB_SYS_FILLRECT
+ 	select FB_SYS_COPYAREA
+ 	select FB_SYS_IMAGEBLIT
+ 	select FB_SYS_FOPS
  	help
  	  This is the framebuffer driver for the AMD Au1200 SOC.  It can drive
  	  various panels and CRTs by passing in kernel cmd line option
