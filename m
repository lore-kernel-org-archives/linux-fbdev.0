From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Debugging pxafb and am200epd
Date: Thu, 8 May 2008 16:06:48 -0400
Message-ID: <45a44e480805081306v17421858w3fbde163d43118e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JuCON-0004ad-8S for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 May 2008 13:07:03 -0700
Received: from wf-out-1314.google.com ([209.85.200.174])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JuCOC-0007o4-Ia
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 May 2008 13:06:57 -0700
Received: by wf-out-1314.google.com with SMTP id 27so844520wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 08 May 2008 13:06:49 -0700 (PDT)
Content-Disposition: inline
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
To: Eric Miao <ymiao3@marvell.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Hi Eric,

Just some quick questions and notes while trying to implement am200epd
sharing pxafb's framebuffer.

1. pxafb_init is set to __devinit, but it is only called from
module_init. Is my understanding correct that it should be __init?
2. pxafb currently doesn't implement module unloading support.  Is
there a reason for this?

3. I'm seeing weird behavior with insmod of am200epd on my test system
on a gumstix. Probably something that I'm doing wrong but I wanted to
ask advice here anyway. Here's what I'm doing:
# insmod drivers/video/cfbcopyarea.ko && insmod
drivers/video/cfbfillrect.ko && insmod drivers/video/cfbimgblt.ko
# insmod drivers/video/syscopyarea.ko && insmod
drivers/video/sysfillrect.ko && insmod drivers/video/sysimgblt.ko &&
insmod drivers/video/fb_sys_fops.ko
# insmod drivers/video/metronomefb.ko ; insmod drivers/video/pxafb.ko
# grep pxafb_probe /proc/kallsyms
bf014000 t pxafb_probe  [pxafb]
# grep bf014000 /proc/kallsyms
bf014000 t pxafb_probe  [pxafb]
bf014000 t $a   [pxafb]

The reason I was debugging this was because platform_device_add was
failing from am200epd when am200epd is trying to add pxa2xx-fb. It
would fail from platform_drv_probe. I found that it was because the
pxafb's probe routine somehow gets replaced by other stuff. I was
worried if it was due to am200epd so I then took out all the code from
am200epd's init_module so it does nothing other than return 0. So the
following insmod is of am200epd that has a completely empty
init_module.

# insmod arch/arm/mach-pxa/am200epd.ko

# grep pxafb_probe /proc/kallsyms
bf014000 t pxafb_probe  [pxafb]

# grep bf014000 /proc/kallsyms
bf014000 t am200_exit   [am200epd]
bf014000 t $a   [am200epd]
bf014000 t cleanup_module       [am200epd]
bf014000 t pxafb_probe  [pxafb]
bf014000 t $a   [pxafb]

The above doesn't make sense to me. I don't understand why am200_exit
is overloaded at the same address as pxafb_probe. Any suggestions on
how to debug this?

Thanks,
jaya

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
