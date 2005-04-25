From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: 2.6.12-rc1-mm2 -- nvidiafb driver gives black screen
Date: Mon, 25 Apr 2005 11:21:24 +0800
Message-ID: <200504251121.24725.adaplas@hotpop.com>
References: <a44ae5cd0503242023233dc23f@mail.gmail.com> <a44ae5cd05042217122613bac4@mail.gmail.com> <a44ae5cd05042410092055e3c4@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DPuD3-0005Dz-Ar
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 24 Apr 2005 20:24:33 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DPuD1-0003ng-Nb
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 24 Apr 2005 20:24:33 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 5B24F15797D7
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 25 Apr 2005 03:24:22 +0000 (UTC)
In-Reply-To: <a44ae5cd05042410092055e3c4@mail.gmail.com>
Content-Disposition: inline
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
To: Miles Lane <miles.lane@gmail.com>, "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net, khali@linux-fr.org, akpm@osdl.org

On Monday 25 April 2005 01:09, Miles Lane wrote:
> On 4/22/05, Miles Lane <miles.lane@gmail.com> wrote:
> > Okay, it also fails with Antonio's patches applied in addition to yours.
>
> I know I implied this in my previous message, but I want to make it
> explicit. This combination of patches also fails to give a working
> framebuffer console when I specify vmalloc=128M.  I only get a working
> framebuffer console by specifying vmalloc=256M.
>
>            Miles

Can you try this patch?  This limits the amount of RAM that nvidiafb
will remap to 64 MiB.  This is on top of another patch I sent to Andrew:
"[Linux-fbdev-devel] [PATCH 1/6] nvidiafb: ioremap and i2c fixes"

Tony

diff -Nru a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
--- a/drivers/video/nvidia/nvidia.c	2005-04-16 11:54:44 +08:00
+++ b/drivers/video/nvidia/nvidia.c	2005-04-25 10:39:45 +08:00
@@ -1511,9 +1511,9 @@
 	if (vram && vram * 1024 * 1024 < par->FbMapSize)
 		par->FbMapSize = vram * 1024 * 1024;
 
-	/* Limit amount of vram to 128 MB */
-	if (par->FbMapSize > 128 * 1024 * 1024)
-		par->FbMapSize = 128 * 1024 * 1024;
+	/* Limit amount of vram to 64 MB */
+	if (par->FbMapSize > 64 * 1024 * 1024)
+		par->FbMapSize = 64 * 1024 * 1024;
 
 	par->FbUsableSize = par->FbMapSize - (128 * 1024);
 	par->ScratchBufferSize = (par->Architecture < NV_ARCH_10) ? 8 * 1024 :




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
