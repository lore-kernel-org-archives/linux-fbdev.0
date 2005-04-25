From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: Re: [PATCH 1/6] nvidiafb: ioremap and i2c
 fixes
Date: Sun, 24 Apr 2005 22:03:09 -0700
Message-ID: <20050424220309.77617eed.rddunlap@osdl.org>
References: <200504161313.25574.adaplas@hotpop.com>
	<20050423174013.3006852f.akpm@osdl.org>
	<200504251121.20530.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DPvn8-0001jm-Qh
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 24 Apr 2005 22:05:54 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DPvn7-0005sX-93
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 24 Apr 2005 22:05:54 -0700
In-Reply-To: <200504251121.20530.adaplas@hotpop.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@hotpop.com, akpm@osdl.org, adaplas@pol.net

On Mon, 25 Apr 2005 11:21:20 +0800 Antonino A. Daplas wrote:

| On Sunday 24 April 2005 08:40, Andrew Morton wrote:
| > "Antonino A. Daplas" <adaplas@hotpop.com> wrote:
| > > - Add 'vram' option to specify amount of video RAM to remap
| > >  - Limit remap size to 128 MIB
| >
| > Am I right in believing that if someone has a 256MB card and doesn't know
| > about the `vram' option, their card will fail to work, because the 128MB
| > vmalloc() will fail?
| >
| 
| I thought that a 128MiB vmalloc will work.

The default vmalloc total size is 128 MB, but the kernel always
requires a "guard page", which cannot be allocated, so the
total allocation fails.

I tried to make a patch that sets the default vmalloc total size
to 128 MB + PAGE_SIZE, but Miles reported that the driver's
vmalloc() call still failed...

| > If so, that seems a bit user-hostile to me.  Perhaps we should make it
| > 64MB?
| 
| Okay, dropping maximum to 64 MiB.
| 
| From: Antonino Daplas <adaplas@pol.net>
| Signed-off-by: Antonino Daplas <adaplas@pol.net>
| 
|  nvidia.c |    6 +++---
|  1 files changed, 3 insertions(+), 3 deletions(-)
| 
| diff -Nru a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
| --- a/drivers/video/nvidia/nvidia.c	2005-04-16 11:54:44 +08:00
| +++ b/drivers/video/nvidia/nvidia.c	2005-04-25 10:39:45 +08:00
| @@ -1511,9 +1511,9 @@
|  	if (vram && vram * 1024 * 1024 < par->FbMapSize)
|  		par->FbMapSize = vram * 1024 * 1024;
|  
| -	/* Limit amount of vram to 128 MB */
| -	if (par->FbMapSize > 128 * 1024 * 1024)
| -		par->FbMapSize = 128 * 1024 * 1024;
| +	/* Limit amount of vram to 64 MB */
| +	if (par->FbMapSize > 64 * 1024 * 1024)
| +		par->FbMapSize = 64 * 1024 * 1024;
|  
|  	par->FbUsableSize = par->FbMapSize - (128 * 1024);
|  	par->ScratchBufferSize = (par->Architecture < NV_ARCH_10) ? 8 * 1024 :


---
~Randy


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
