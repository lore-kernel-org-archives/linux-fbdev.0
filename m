From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: 2.6.12-rc1-mm2 -- nvidiafb driver gives black screen
Date: Thu, 14 Apr 2005 13:51:42 +0800
Message-ID: <200504141351.42971.adaplas@hotpop.com>
References: <a44ae5cd0503242023233dc23f@mail.gmail.com> <20050324203118.345c6004.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DLxHH-0000xC-GI
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 13 Apr 2005 22:52:35 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DLxHH-0005Sz-2S
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 13 Apr 2005 22:52:35 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 60D30152A7B2
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 14 Apr 2005 05:52:22 +0000 (UTC)
In-Reply-To: <20050324203118.345c6004.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>, Miles Lane <miles.lane@gmail.com>
Cc: khali@linux-fr.org, linux-fbdev-devel@lists.sourceforge.net

On Friday 25 March 2005 12:31, Andrew Morton wrote:

> >
> > allocation failed: out of vmalloc space - use vmalloc=<size> to increase
> > size. nvidiafb: cannot ioremap FB base
>

This patch will always limit the amount of video RAM to remap at
128 MiB.

From: Antonino Daplas <adaplas@pol.net>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 nvidia.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

diff -Nru a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
--- a/drivers/video/nvidia/nvidia.c	2005-04-14 13:33:38 +08:00
+++ b/drivers/video/nvidia/nvidia.c	2005-04-14 13:44:15 +08:00
@@ -1510,7 +1510,11 @@
 	par->FbMapSize = par->RamAmountKBytes * 1024;
 
 	if (vram && vram * 1024 * 1024 < par->FbMapSize)
-	    par->FbMapSize = vram * 1024 * 1024;
+		par->FbMapSize = vram * 1024 * 1024;
+
+	/* Limit amount of vram to 128 MB */
+	if (par->FbMapSize > 128 * 1024 * 1024)
+		par->FbMapSize = 128 * 1024 * 1024;
 
 	par->FbUsableSize = par->FbMapSize - (128 * 1024);
 	par->ScratchBufferSize = (par->Architecture < NV_ARCH_10) ? 8 * 1024 :






-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
