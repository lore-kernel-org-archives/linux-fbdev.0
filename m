From: Felipe W Damasio <felipewd@terra.com.br>
Subject: Re: [PATCH] Leak in vesafb
Date: Mon, 06 Oct 2003 18:38:22 -0300
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <3F81E0CE.2000908@terra.com.br>
References: <3F81DEE5.9000600@terra.com.br>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030903090806040806020406"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <3F81DEE5.9000600@terra.com.br>
List-Id: <fbdev-devel.lists.sourceforge.net
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030903090806040806020406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Felipe W Damasio wrote:
>     Hi Andrew,
> 
>     Patch against 2.6.0-test6.
> 
>     Releases a previous request'ed_mem_region. Found by smatch.
> 
>     Since it didn't checked the return value of request_region, I'm not 
> sure we should free it here...since (as it says on the driver), "vgacon 
> probably has this region already".
> 
>     Andrew, I'd appreciate you could review this..

	Also, this updated patch also iounmap fb_info.screen_base, since 
we're about to return -EINVAL on vesa_init.

	Cheers,

Felipe

--------------030903090806040806020406
Content-Type: text/plain;
 name="vesafb-leak.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vesafb-leak.patch"

--- linux-2.6.0-test6/drivers/video/vesafb.c.orig	2003-10-06 18:22:13.000000000 -0300
+++ linux-2.6.0-test6/drivers/video/vesafb.c	2003-10-06 18:33:39.000000000 -0300
@@ -366,8 +366,11 @@
 
 	fb_alloc_cmap(&fb_info.cmap, video_cmap_len, 0);
 
-	if (register_framebuffer(&fb_info)<0)
+	if (register_framebuffer(&fb_info)<0) {
+		release_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len);
+		iounmap(fb_info.screen_base);
 		return -EINVAL;
+	}
 
 	printk(KERN_INFO "fb%d: %s frame buffer device\n",
 	       fb_info.node, fb_info.fix.id);

--------------030903090806040806020406--
