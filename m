From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: Re: 2.6.12-rc1-mm2 -- nvidiafb driver gives
 black screen
Date: Mon, 28 Mar 2005 20:34:43 -0800
Message-ID: <4248DAE3.9060604@osdl.org>
References: <a44ae5cd0503242023233dc23f@mail.gmail.com>	 <20050324203118.345c6004.akpm@osdl.org> <a44ae5cd050325205012399ccc@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090904090103060008030701"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DG8RY-0003IH-0e
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Mar 2005 20:35:08 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DG8RW-0007AN-Fw
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Mar 2005 20:35:07 -0800
In-Reply-To: <a44ae5cd050325205012399ccc@mail.gmail.com>
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
--------------090904090103060008030701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Miles Lane wrote:
> On Thu, 24 Mar 2005 20:31:18 -0800, Andrew Morton <akpm@osdl.org> wrote:
> 
>>(Added the mailing list - trust that's ok)
>>
>>Miles Lane <miles.lane@gmail.com> wrote:
>>
>>>Kernel command line: BOOT_IMAGE=Linux ro root=306 video=nvidiafb
>>>init=/etc/init lang=us apm=power-off nomce
>>>nvidiafb: nVidia device/chipset 10DE0312
>>>nvidiafb: nVidia Corporation NV31 [GeForce FX 5600]
>>>nvidiafb: CRTC0 found
>>>nvidiafb: CRTC1 not found
>>>nvidiafb: EDID found from BUS1
>>>nvidiafb: CRTC 0 appears to have a CRT attached
>>>nvidiafb: Using CRT on CRTC 0
>>>
>>>
>>>>>I am wondering whether the following two lines point to the problem.
>>>
>>>allocation failed: out of vmalloc space - use vmalloc=<size> to increase size.
>>>nvidiafb: cannot ioremap FB base
>>
>>Quite possibly.

Sure, without the FB memory, video won't show up.
And the 2 lines are directly related -- same error printed from
2 different places.

>>I'll do rc2-mm3 tonight - please test that.  It has fixes.
> 
> 
> Hello Andrew,
> 
> mm3 did not fix the problem.  I still get a blank framebuffer console.
> I still get these two errors:
> allocation failed: out of vmalloc space - use vmalloc=<size> to increase size.
> nvidiafb: cannot ioremap FB base
> Also, I still get the /sys listing Oops when listing the i2c entries
> for the nvidiafb.
> Lastly, I get the Oops that halts booting if I include certain other
> i2c drivers in the build.
> Removing nvidiafb from the build allows me to get a completely usable
> build of 2.6.12-rc1-mm3.
> 
> I haven't heard anything from the author of the nvidiafb driver about
> the various issues I have reported.

Here's a tiny patch to get started.  Hopefully it will show us
why ioremap is failing...

Another issue while looking at this code:
there is some __initdata in nvidia.c that should be __devinitdata
(deja vu)

Miles, after using this patch, please also test by booting
with "vmalloc=512M"  (or "vmalloc=256M" if you don't have 512 MB
to spare).

-- 
~Randy

--------------090904090103060008030701
Content-Type: text/x-patch;
 name="nvid_remap_test1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nvid_remap_test1.patch"

linux-2612-rc1-mm3
Add a little debug printk to try to find out why ioremap fails.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/video/nvidia/nvidia.c |    2 ++
 1 files changed, 2 insertions(+)

diff -Naurp ./drivers/video/nvidia/nvidia.c~nv_test_remap ./drivers/video/nvidia/nvidia.c
--- ./drivers/video/nvidia/nvidia.c~nv_test_remap	2005-03-28 19:21:28.000000000 -0800
+++ ./drivers/video/nvidia/nvidia.c	2005-03-28 19:46:47.000000000 -0800
@@ -1511,6 +1511,8 @@ static int __devinit nvidiafb_probe(stru
 	par->ScratchBufferSize = (par->Architecture < NV_ARCH_10) ? 8 * 1024 :
 	    16 * 1024;
 	par->ScratchBufferStart = par->FbUsableSize - par->ScratchBufferSize;
+	printk(KERN_ERR PFX "calling ioremap(smem_start = 0x%p, size = 0x%lx)\n",
+			nvidiafb_fix.smem_start, par->FbMapSize);
 	info->screen_base = ioremap(nvidiafb_fix.smem_start, par->FbMapSize);
 	nvidiafb_fix.smem_len = par->FbUsableSize;
 

--------------090904090103060008030701--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
