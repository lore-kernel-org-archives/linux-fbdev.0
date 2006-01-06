From: Adrian Bunk <bunk@stusta.de>
Subject: drivers/video/imsttfb.c: setclkMHz: clk_p is always 0
Date: Fri, 6 Jan 2006 17:25:54 +0100
Message-ID: <20060106162554.GJ12131@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752277AbWAFQ0A@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

The Coverity checker noticed that in the function setclkMHz in 
drivers/video/imsttfb.c, the variable clk_p is never assigned a value 
other than 0.

Could someone understanding this code decide whether this is a real bug 
or whether clk_p can be replaced by 0?

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
