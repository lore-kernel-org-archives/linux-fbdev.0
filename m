From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 30 Jan 2017 15:59:22 +0000
Subject: Re: [PATCH v1] video : fbdev : stifb :- Handle return NULL error from ioremap_nocache.
Message-Id: <1759269.Z5Z5RrJiUP@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170118102229epcas1p21c74a99299ee919a3f2d28ad435b7ca7@epcas1p2.samsung.com>
 <1484734911-5299-1-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1484734911-5299-1-git-send-email-arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: jejb@parisc-linux.org, deller@gmx.de, linux-parisc@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Wednesday, January 18, 2017 03:51:51 PM Arvind Yadav wrote:
> Here, If ioremap_nocache will fail. It will return NULL.
> Kernel can run into a NULL-pointer dereference.
> This error check will avoid NULL pointer dereference.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Thanks, I queued your patch with some minor changes for 4.11
(you can see the final version of the patch below).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH v1] video: fbdev: stifb: handle NULL return value from ioremap_nocache

Add missing error check for ioremap_nocache() failure
(prevents NULL pointer dereference on error).

Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
[b.zolnierkie: minor fixes]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/stifb.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: b/drivers/video/fbdev/stifb.c
=================================--- a/drivers/video/fbdev/stifb.c	2017-01-30 16:55:15.766435453 +0100
+++ b/drivers/video/fbdev/stifb.c	2017-01-30 16:55:15.750435453 +0100
@@ -1294,6 +1294,10 @@ static int __init stifb_init_fb(struct s
 	strcpy(fix->id, "stifb");
 	info->fbops = &stifb_ops;
 	info->screen_base = ioremap_nocache(REGION_BASE(fb,1), fix->smem_len);
+	if (!info->screen_base) {
+		printk(KERN_ERR "stifb: failed to map memory\n");
+		goto out_err0;
+	}
 	info->screen_size = fix->smem_len;
 	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_COPYAREA;
 	info->pseudo_palette = &fb->pseudo_palette;

