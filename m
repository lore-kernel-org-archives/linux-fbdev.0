From: Jurriaan <thunder7@xs4all.nl>
Subject: Re: [PATCH 1/2] fbdev: S3 Savage Framebuffer Driver
Date: Wed, 10 Nov 2004 20:17:35 +0100
Message-ID: <20041110191735.GA19864@middle.of.nowhere>
References: <200410230436.42009.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CRxyV-000830-Sw
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Nov 2004 11:17:47 -0800
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CRxyV-000747-4O
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Nov 2004 11:17:47 -0800
Received: from zeeotter.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtp-vbr15.xs4all.nl (8.12.11/8.12.11) with ESMTP id iAAJHigr035607
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 10 Nov 2004 20:17:44 +0100 (CET)
	(envelope-from jurriaan@rivierenland.xs4all.nl)
Content-Disposition: inline
In-Reply-To: <200410230436.42009.adaplas@hotpop.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

From: Antonino A. Daplas <adaplas@hotpop.com>
Date: Sat, Oct 23, 2004 at 04:36:41AM +0800
> S3 Savage Frambuffer Driver for the following chipsets: 
> 
> Savage 3D
> Savage MX
> Savage 4
> Savage 2000
> ProSavage
> SuperSavage
> 
Excellent. I tried this (in 2.6.10-rc1-mm4) with my Thinkpad T23, which
has a SuperSavage IX/C SDR according to lspci.

If I compile the framebuffer into the kernel, it hangs during boot. The
oops is only partly visible, but the first line of the traceback
contains savage_setup_i2c_bus.

If I compile it as a module, it comes up with 800x600, which looks like
sh*t on a 1024x768 lcd panel. All my attempts to change the resolution,
either with fbset, or variations on this command

modprobe savagefb mode=1024x768-60

didn't work. 

Would you give me any hints on how to get it to come up with 1024x768?
I would love to see if it's faster than the vesa framebuffer I've been
using so far.

Thanks,
Jurriaan
-- 
I am the neurosis that requires a $500 an hour shrink
	Darkwing Duck
Debian (Unstable) GNU/Linux 2.6.9-mm1 2x6078 bogomips load 0.84


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
