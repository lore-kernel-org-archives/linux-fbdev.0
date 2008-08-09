From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Framebuffer drivers that break the boot on systemswithout the hardware
Date: Sat, 09 Aug 2008 22:15:08 +0200
Message-ID: <489DFACC.6030009@keyaccess.nl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753676AbYHIUPV@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Antonino Daplas <adaplas@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Linux Kernel <linux-kernel@vger.kernel.org>

Hi Antonino.

At:

http://lkml.org/lkml/2008/8/1/96

Ingo Molnar posted a list of drivers he found to break the boot during 
testing of randconfig kernels and among them are a number of FB drivers:

   FB_CIRRUS
   FB_ASILIANT
   FB_VGA16
   FB_VESA
   FB_RADEON
   FB_CYBLA
   (and FB_VIRTUAL)

Looking at some of them there wouldn't seem to be too many very sensible 
options to avoid this at the individual driver level. Would you perhaps 
have an idea how to avoid the issue generically for these?

More of the drivers in that list will  be considered fine as is but I 
was fixing some of the old legacy ISA ones as ofcourse any driver not 
needing special avoidance treatment is one less to have to deal with.

The randconfig testing IS useful in finding bugs, so...

Rene.
