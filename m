From: Adrian Bunk <bunk@stusta.de>
Subject: RFC: disallow modular framebuffers
Date: Tue, 1 Mar 2005 03:41:18 +0100
Message-ID: <20050301024118.GF4021@stusta.de>
Mime-Version: 1.0
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Hi,

while looking how to fix modular FB_SAVAGE_* (both FB_SAVAGE_I2C=m and 
FB_SAVAGE_ACCEL=m are currently broken) I asked myself:

Do modular framebuffers really make sense?

OK, distributions like to make everything modular, but all the 
framebuffer drivers I've looked at parse driver specific options in 
their *_setup function only in the non-modular case.

And most framebuffer drivers contain a module_exit function.
Is there really any case where this is both reasonable and working?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
