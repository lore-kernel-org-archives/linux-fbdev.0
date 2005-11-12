From: Adrian Bunk <bunk@stusta.de>
Subject: drivers/video/nvidia/ compile error with PPC_OF=y, FB_OF=n
Date: Sat, 12 Nov 2005 05:16:49 +0100
Message-ID: <20051112041649.GU5376@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751252AbVKLEQz@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

I got the following compile error in 2.6.14-mm2 that seems to come from 
Linus' tree:

<--  snip  -->

...
  CC [M]  drivers/video/nvidia/nv_of.o
drivers/video/nvidia/nv_of.c:33: error: redefinition of 'nvidia_probe_of_connector'
drivers/video/nvidia/nv_proto.h:51: error: previous definition of 'nvidia_probe_of_connector' was here
make[3]: *** [drivers/video/nvidia/nv_of.o] Error 1

<--  snip  -->

The problem is that nv_proto.h thinks nv_of.o is only built with 
CONFIG_FB_OF=y, but it's actually built when CONFIG_PPC_OF=y.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
