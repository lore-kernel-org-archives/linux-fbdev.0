From: Andrew Morton <akpm@osdl.org>
Subject: Re: Re: [PATCH 1/6] nvidiafb: ioremap and i2c
 fixes
Date: Sun, 24 Apr 2005 22:00:58 -0700
Message-ID: <20050424220058.0f95b392.akpm@osdl.org>
References: <200504161313.25574.adaplas@hotpop.com>
	<20050423174013.3006852f.akpm@osdl.org>
	<200504251121.20530.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DPviu-0001bB-Ci
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 24 Apr 2005 22:01:32 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DPvis-0005mK-Ux
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 24 Apr 2005 22:01:32 -0700
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
To: adaplas@pol.net
Cc: adaplas@hotpop.com, linux-fbdev-devel@lists.sourceforge.net

"Antonino A. Daplas" <adaplas@hotpop.com> wrote:
>
>  > Am I right in believing that if someone has a 256MB card and doesn't know
>  > about the `vram' option, their card will fail to work, because the 128MB
>  > vmalloc() will fail?
>  >
> 
>  I thought that a 128MiB vmalloc will work.

Well only if there are zero other current vmallocations and if we didn't
have the guard page.

	unsigned int __VMALLOC_RESERVE = 128 << 20;

>  > If so, that seems a bit user-hostile to me.  Perhaps we should make it
>  > 64MB?
> 
>  Okay, dropping maximum to 64 MiB.

Fair enough.  I guess we should check the vmalloc max on all other
supported 32-bit architectures.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
