From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH] nvidiafb: fix section references
Date: Tue, 29 Mar 2005 08:25:20 -0800
Message-ID: <42498170.2050902@osdl.org>
References: <a44ae5cd0503242023233dc23f@mail.gmail.com>	 <20050324203118.345c6004.akpm@osdl.org> <a44ae5cd050325205012399ccc@mail.gmail.com> <4248DAE3.9060604@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040704010308090400040101"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DGJX7-0006fU-R5
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Mar 2005 08:25:37 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DGJX5-0003Um-73
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Mar 2005 08:25:37 -0800
In-Reply-To: <4248DAE3.9060604@osdl.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, khali@linux-fr.org, adaplas@pol.net

This is a multi-part message in MIME format.
--------------040704010308090400040101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Randy.Dunlap wrote:
> Miles Lane wrote:
> 
>> On Thu, 24 Mar 2005 20:31:18 -0800, Andrew Morton <akpm@osdl.org> wrote:
>>
>>> (Added the mailing list - trust that's ok)
>>>
>>> Miles Lane <miles.lane@gmail.com> wrote:
>>>
>>>> Kernel command line: BOOT_IMAGE=Linux ro root=306 video=nvidiafb
>>>> init=/etc/init lang=us apm=power-off nomce
>>>> nvidiafb: nVidia device/chipset 10DE0312
>>>> nvidiafb: nVidia Corporation NV31 [GeForce FX 5600]
>>>> nvidiafb: CRTC0 found
>>>> nvidiafb: CRTC1 not found
>>>> nvidiafb: EDID found from BUS1
>>>> nvidiafb: CRTC 0 appears to have a CRT attached
>>>> nvidiafb: Using CRT on CRTC 0
>>>>
>>>>
>>>>>> I am wondering whether the following two lines point to the problem.
>>>>
>>>>
>>>> allocation failed: out of vmalloc space - use vmalloc=<size> to 
>>>> increase size.
>>>> nvidiafb: cannot ioremap FB base
>>>
>>>
>>> Quite possibly.
> 
> 
> Sure, without the FB memory, video won't show up.
> And the 2 lines are directly related -- same error printed from
> 2 different places.
> 
>>> I'll do rc2-mm3 tonight - please test that.  It has fixes.
>>
>>
>>
>> Hello Andrew,
>>
>> mm3 did not fix the problem.  I still get a blank framebuffer console.
>> I still get these two errors:
>> allocation failed: out of vmalloc space - use vmalloc=<size> to 
>> increase size.
>> nvidiafb: cannot ioremap FB base
>> Also, I still get the /sys listing Oops when listing the i2c entries
>> for the nvidiafb.
>> Lastly, I get the Oops that halts booting if I include certain other
>> i2c drivers in the build.
>> Removing nvidiafb from the build allows me to get a completely usable
>> build of 2.6.12-rc1-mm3.
>>
>> I haven't heard anything from the author of the nvidiafb driver about
>> the various issues I have reported.
> 
> 
> Here's a tiny patch to get started.  Hopefully it will show us
> why ioremap is failing...
> 
> Another issue while looking at this code:
> there is some __initdata in nvidia.c that should be __devinitdata
> (deja vu)
> 
> Miles, after using this patch, please also test by booting
> with "vmalloc=512M"  (or "vmalloc=256M" if you don't have 512 MB
> to spare).

and here are the section usage fixes.
Miles, please apply and test with this also.

Andrew, I think you and Tony want this.

-- 
~Randy

--------------040704010308090400040101
Content-Type: text/x-patch;
 name="nvid_sections.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nvid_sections.patch"

linux-2612-rc1-mm3
Fix section usage in nvidiafb driver.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/video/nvidia/nvidia.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff -Naurp ./drivers/video/nvidia/nvidia.c~nvid_sections ./drivers/video/nvidia/nvidia.c
--- ./drivers/video/nvidia/nvidia.c~nvid_sections	2005-03-28 08:40:09.000000000 -0800
+++ ./drivers/video/nvidia/nvidia.c	2005-03-29 08:20:20.000000000 -0800
@@ -402,25 +402,25 @@ static struct pci_device_id nvidiafb_pci
 MODULE_DEVICE_TABLE(pci, nvidiafb_pci_tbl);
 
 /* command line data, set in nvidiafb_setup() */
-static int flatpanel __initdata = -1;	/* Autodetect later */
-static int forceCRTC __initdata = -1;
-static int hwcur __initdata = 0;
-static int noaccel __initdata = 0;
-static int noscale __initdata = 0;
-static int paneltweak __initdata = 0;
+static int flatpanel __devinitdata = -1;	/* Autodetect later */
+static int forceCRTC __devinitdata = -1;
+static int hwcur __devinitdata = 0;
+static int noaccel __devinitdata = 0;
+static int noscale __devinitdata = 0;
+static int paneltweak __devinitdata = 0;
 #ifdef CONFIG_MTRR
-static int nomtrr __initdata = 0;
+static int nomtrr __devinitdata = 0;
 #endif
 
-static char *mode_option __initdata = NULL;
+static char *mode_option __devinitdata = NULL;
 
-static struct fb_fix_screeninfo __initdata nvidiafb_fix = {
+static struct fb_fix_screeninfo __devinitdata nvidiafb_fix = {
 	.type = FB_TYPE_PACKED_PIXELS,
 	.xpanstep = 8,
 	.ypanstep = 1,
 };
 
-static struct fb_var_screeninfo __initdata nvidiafb_default_var = {
+static struct fb_var_screeninfo __devinitdata nvidiafb_default_var = {
 	.xres = 640,
 	.yres = 480,
 	.xres_virtual = 640,
@@ -1617,7 +1617,7 @@ static void __exit nvidiafb_remove(struc
  * ------------------------------------------------------------------------- */
 
 #ifndef MODULE
-static int __init nvidiafb_setup(char *options)
+static int __devinit nvidiafb_setup(char *options)
 {
 	char *this_opt;
 

--------------040704010308090400040101--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
