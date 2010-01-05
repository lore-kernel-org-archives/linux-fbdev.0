From: Erik-Jan <ej.lfs@xs4all.nl>
Date: Tue, 05 Jan 2010 21:41:28 +0000
Subject: Re: PROBLEM: loading viafb module turns screen to black on VN896
Message-Id: <4B43B208.60100@xs4all.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060300050600010605020401"
List-Id: <linux-fbdev.vger.kernel.org>
References: <4B2E133B.9060502@web.de>
In-Reply-To: <4B2E133B.9060502@web.de>
To: linux-fbdev@vger.kernel.org

This is a multi-part message in MIME format.
--------------060300050600010605020401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Florian Tobias Schandinat wrote:
> Hi,
> 
> Erik-Jan schrieb:
>> Julian Wollrath wrote:
>>  > Hi,
>>  >
>>  > since I switched from 2.6.31.8 to 2.6.32.2 loading the viafb module
>>  > turns the screen to black, there is no graphic output on the screen 
>> anymore.
>>
>> I had the same sort of problem with CLE266. Only I didn't get a black 
>> screen, but a scrambled-up screen, as if the timings were wrong.
> 
> Well not exactly the same (initially) as the former one was mainly a new 
> supported chip started without the correct parameters.
> 
>> Not surprisingly, it all has to do with the 2D engine rewrite (around 
>> commit c3e25673843153ea75fda79a47cf12f10a25ca37) that has been done in 
>> 2.6.32.
>>
>> I found a few small things in the initialization of the framebuffer, 
>> that were present in 2.6.31 but removed in 2.6.32.
>> Attached a patch that puts these changes back in. I don't know if I've 
>> done some bad things (never done any kernel coding before) nor if it 
>> is OK for all the different VIA hardware out there, but on my CLE266 
>> it now works as before.
> 
> Excellent work!

Thanks.

> 
>> The changes to accel.c are needed for a correct boot; the other 
>> changes are needed for changing the framebuffer mode with fbset.
> 
> Ooh, I really must have been blind to let the later one slip in. But I 
> prefer a bit different solution as in 0001-*.patch to not duplicate that 
> call (and using info instead of viafbinfo as this is more compatible on 
> the way to dual head support). For the first one, well, I do not own 
> every VIA hardware especially not all configurations and for the oldest 
> ones there isn't even documentation available so I have sometimes rely 
> on people testing (ideally -mm so that bugs are caught before they go 
> mainline).
> The attached patches apply to current -mm
> http://userweb.kernel.org/~akpm/mmotm/

The 0001 didn't apply to -mm or to 2.6.32.2, so I've created a 
0001b-version that does. See attachment.

> If you are okay with them please give them your sign-off as you are the 
> original author so that I can forward them to Andrew.
> 

Tested with both 2.6.32.2 and mmotm (DATE=2009-12-10-17-19) and it works.
Signed-off-by: Erik-Jan Post <ej.lfs@xs4all.nl>

> 
> Thanks a lot,
> 
> Florian Tobias Schandinat
> 

--------------060300050600010605020401
Content-Type: text/plain;
 name="0001b-viafb-do-modesetting-after-updating-variables.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001b-viafb-do-modesetting-after-updating-variables.patch"

From a4d146a3b73da61d026308bef7effc47b71b433b Mon Sep 17 00:00:00 2001
From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 3 Jan 2010 00:25:15 +0000
Subject: [PATCH 1/2] viafb: do modesetting after updating variables

viafb: do modesetting after updating variables

Reorder viafb_set_par to allow using the updated variables in
viafb_setmode. This fixes a regression that prevented proper
runtime mode changes.

Signed-off-by: Erik-Jan Post <ej.lfs@xs4all.nl>
Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/via/viafbdev.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index e16df84..f7ff4ea 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -177,16 +177,16 @@ static int viafb_set_par(struct fb_info *info)
 	}
 
 	if (vmode_index != VIA_RES_INVALID) {
-		viafb_setmode(vmode_index, info->var.xres, info->var.yres,
-			info->var.bits_per_pixel, vmode_index1,
-			viafb_second_xres, viafb_second_yres, viafb_bpp1);
-
 		viafb_update_fix(info);
 		viafb_bpp = info->var.bits_per_pixel;
 		if (info->var.accel_flags & FB_ACCELF_TEXT)
 			info->flags &= ~FBINFO_HWACCEL_DISABLED;
 		else
 			info->flags |= FBINFO_HWACCEL_DISABLED;
+
+		viafb_setmode(vmode_index, info->var.xres, info->var.yres,
+			info->var.bits_per_pixel, vmode_index1,
+			viafb_second_xres, viafb_second_yres, viafb_bpp1);
 	}
 
 	return 0;
-- 
1.6.3.2


--------------060300050600010605020401--
