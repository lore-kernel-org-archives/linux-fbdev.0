From: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: fbcmap: non working tests on
	unsigned	cmap->start
Date: Sun, 26 Apr 2009 14:20:47 +0200
Message-ID: <49F4519F.4090003@gmail.com>
References: <49EDD799.8060607@gmail.com>
	<20090423134110.51ea8df2.akpm@linux-foundation.org>
	<20090423214738.GF7134@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roel.kluin@gmail.com>) id 1Ly3M1-0002Mw-0A
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Apr 2009 12:21:05 +0000
Received: from mail-ew0-f217.google.com ([209.85.219.217])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ly3Lm-0005tR-1k for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Apr 2009 12:20:54 +0000
Received: by ewy17 with SMTP id 17so1723678ewy.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 26 Apr 2009 05:20:47 -0700 (PDT)
In-Reply-To: <20090423214738.GF7134@sci.fi>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>, Roel Kluin <roel.kluin@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

cmap->start is unsigned, A negative start could result in incorrect
colors. `start' is used as the starting index for the hardware palette,
'start+len-1' is the last index.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
>>> vi include/linux/fb.h +478
>>>
>>> Note that struct fb_cmap_user cmap->start in fb_set_user_cmap() is unsigned.
>>> Should there maybe be a test:
>>>
>>> if (cmap->start > MAX || ...)
>>>
>>> (and what should MAX be then?)
>>>

> On Thu, Apr 23, 2009 at 01:41:10PM -0700, Andrew Morton wrote:
>> argh.
>>
>> - Perhaps userspace can kill the kernel by sending a "negative"
>>   `start'.  Removing the test will make it even less likely that we'll
>>   fix this bug.
> 
> Shouldn't happen. 'start' is used as the starting index for the hardware
> palette, 'start+len-1' is the last index. All drivers should already check
> the passed values since the maximum index depends on the display mode.
> And I suppose the worst thing that could happen if the driver fails to
> check the values would be incorrect colors.

Thanks for your explanation, I think this should fix it?

diff --git a/drivers/video/fbcmap.c b/drivers/video/fbcmap.c
index f53b9f1..ea62d87 100644
--- a/drivers/video/fbcmap.c
+++ b/drivers/video/fbcmap.c
@@ -266,7 +266,7 @@ int fb_set_user_cmap(struct fb_cmap_user *cmap, struct fb_info *info)
 		rc = -ENODEV;
 		goto out;
 	}
-	if (cmap->start < 0 || (!info->fbops->fb_setcolreg &&
+	if (cmap->start >= cmap->len || (!info->fbops->fb_setcolreg &&
 				!info->fbops->fb_setcmap)) {
 		rc = -EINVAL;
 		goto out1;


------------------------------------------------------------------------------
Crystal Reports &#45; New Free Runtime and 30 Day Trial
Check out the new simplified licensign option that enables unlimited
royalty&#45;free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
