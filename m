From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: no cursor on nvidiafb console in 2.6.14-rc1-mm1
Date: Tue, 20 Sep 2005 18:26:40 +0800
Message-ID: <432FE3E0.3020405@gmail.com>
References: <20050919175116.GA8172@amd64.of.nowhere> <432F08C1.8010705@ppp0.net> <432F36B4.8030209@gmail.com> <432FBC93.4040007@ppp0.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EHfMU-00086j-5I
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Sep 2005 03:28:30 -0700
Received: from zproxy.gmail.com ([64.233.162.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EHfMS-0007Qj-Js
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Sep 2005 03:28:30 -0700
Received: by zproxy.gmail.com with SMTP id i11so1390791nzh
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 20 Sep 2005 03:28:22 -0700 (PDT)
In-Reply-To: <432FBC93.4040007@ppp0.net>
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
To: Jan Dittmer <jdittmer@ppp0.net>
Cc: Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Jan Dittmer wrote:
> Antonino A. Daplas wrote:
>> Jan Dittmer wrote:
>>
>>> jurriaan wrote:
>>>
>>>> After updating from 2.6.13-rc4-mm1 to 2.6.14-rc1-mm1 I see no cursor on
>>>> my console.
>>> Me too, 2.6.14-rc1-git4. Didn't try any kernel before with framebuffer,
>>> sorry. No fb options on the kernel command line.
>>>
>>
>> Can you try reversing this particular diff?
>>
>> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff_plain;h=af99ea96012ec72ef57fd36655a6d8aaa22e809e;hp=30f80c23f934bb0a76719232f492153fc7cca00a
>>
>> Tony
>>
> 
> --- 30f80c23f934bb0a76719232f492153fc7cca00a
> +++ af99ea96012ec72ef57fd36655a6d8aaa22e809e
> 
> ^^^ Which file??
> 

Heh, didn't realize that. drivers/video/nvidia/nvidia.c, actually.
But just apply this patch instead, as a Kconfig change is also
needed.

Signed-off-by: Antonino Daplas <adaplas@pol.net>

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -650,6 +650,7 @@ config FB_NVIDIA
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This driver supports graphics boards with the nVidia chips, TNT
 	  and newer. For very old chipsets, such as the RIVA128, then use
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -893,7 +893,7 @@ static int nvidiafb_cursor(struct fb_inf
 	int i, set = cursor->set;
 	u16 fg, bg;
 
-	if (!hwcur || cursor->image.width > MAX_CURS || cursor->image.height > MAX_CURS)
+	if (cursor->image.width > MAX_CURS || cursor->image.height > MAX_CURS)
 		return -ENXIO;
 
 	NVShowHideCursor(par, 0);
@@ -1356,6 +1356,9 @@ static int __devinit nvidia_set_fbinfo(s
 	info->pixmap.size = 8 * 1024;
 	info->pixmap.flags = FB_PIXMAP_SYSTEM;
 
+	if (!hwcur)
+	    info->fbops->fb_cursor = soft_cursor;
+
 	info->var.accel_flags = (!noaccel);
 
 	switch (par->Architecture) {


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
