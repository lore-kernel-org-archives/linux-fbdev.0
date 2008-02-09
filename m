From: "Scott D. Davilla" <davilla@4pi.com>
Subject: framebuffer questions
Date: Sat, 9 Feb 2008 16:12:51 -0500
Message-ID: <p06230914c3d3bdda5250@[192.168.9.5]>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JNx10-00089a-M5 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 09 Feb 2008 13:13:38 -0800
Received: from mx.4pi.com ([24.172.19.59])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JNx0z-0005m2-9X
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 09 Feb 2008 13:13:38 -0800
Received: from [192.168.9.5] (nc-65-41-43-142.sta.embarqhsd.net [65.41.43.142])
	by mx.4pi.com (Postfix) with ESMTP id D26AD3A0DB22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat,  9 Feb 2008 16:13:29 -0500 (EST)
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
To: linux-fbdev-devel@lists.sourceforge.net

I'm tracking a X11 hang/video corruption problem. I'm not a Linux 
framebuffer expert so I'm asking for input.

Hardware is an AppleTV (yes, an AppleTV). This is an EFI based 
pentium-m with intel 945GM chipset with nvidia 7300.

Linux boots and I get console output. X11 works but when displaying 
720p or 1080i MPEG2 content using xvmc, I get random application 
hangs (requiring a kill to the app) and random green macro block 
video corruption.  A similar BIOS based ITX system  configured with 
identical kernel/rootfile system never hangs or has video corruption.

The differences are EFI vs BIOS and imacfb vs vesafb.

EFI does not have any dynamic interaction with the kernel or app 
level. The only time EFI comes into play is mapping memory and 
acpi/smbios address structures. And with these EFI is not doing 
anything, the kernel  EFI routines are using the passed EFI memory 
structures. All timing/runtime EFI services are disabled/remapped to 
non-EFI routines. I've even remapped the EFI structures into e820 
structures in an experimental bootloader that boots the kernel is a 
similar fashion as ELILO does for the 2.6.24 kernels and still get 
hangs/video corrution. So I don't think it's related to EFI booting.


Going over the imacfb source, I've noticed a few issues that might be 
causing hidden problems.

1) "info = framebuffer_alloc(sizeof(u32) * 16, &dev->dev)" is used to 
allocate memory for the framebuffer info structure (struct fb_info 
*info).

struct fb_info is greater than 16 * sizeof(u32) so it seems this 
should be "info = framebuffer_alloc(sizeof(struct fb_info), 
&dev->dev)" or imacfb is going to be read/writing beyond what was 
allocated. Side note efifb.c has this same code as it was derived 
from imacfb.


2) "request_mem_region(imacfb_fix.smem_start, size_total, "imacfb")" 
uses size_total and "ioremap(imacfb_fix.smem_start, 
imacfb_fix.smem_len)" uses imacfb_fix.smem_len. I guess the intent 
here is request memory for the largest video buffer size supported 
but only map the current video buffer size. There's a complicated 
logic sequence above the request_mem_region call that uses magic 
numbers to try to compute and pad the various sizes.

This seems in error. The current video buffer size is 
"imacfb_defined.yres * imacfb_fix.line_length", and the max size is 
screen_info.lfb_size. Should these not be used directly and all the 
sizing logic voodoo removed.

3) imacfb (and efifb) do not any removal routines for unloading the 
module. So what happens when X11 takes over? Should there be an 
removal routine for unloading? The console video buffer is still 
mapped (screen_base). How does X11 know not to use this area? What 
does X11 do regarding the console framebuffer when it runs and it is 
does not unlaod the console module, how does it avoid using the 
console mapped video memory?

Thanks
Scott


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
