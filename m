From: Adrian Bunk <bunk@stusta.de>
Subject: 2.6.10-rc1-mm2: intelfb/AGP unknown symbols
Date: Sat, 30 Oct 2004 05:24:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20041030032425.GI6677@stusta.de>
References: <20041029014930.21ed5b9a.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S263462AbUJ3D0W@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20041029014930.21ed5b9a.akpm@osdl.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>, Arjan van de Ven <arjan@infradead.org>, Sylvain Meyer <sylvain.meyer@worldonline.fr>, Antonino Daplas <adaplas@pol.net>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Fri, Oct 29, 2004 at 01:49:30AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.10-rc1-mm1:
> 
>  linus.patch
>...
>  bk-agpgart.patch
>...


The removal of 3 "unneeded exports" in bk-agpgart.patch conflicts with 
code adding usage of them in Linus' tree:


<--  snip  -->

...
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.10-rc1-mm2; fi
WARNING: /lib/modules/2.6.10-rc1-mm2/kernel/drivers/video/intelfb/intelfb.ko needs unknown symbol agp_backend_acquire
WARNING: /lib/modules/2.6.10-rc1-mm2/kernel/drivers/video/intelfb/intelfb.ko needs unknown symbol agp_copy_info
WARNING: /lib/modules/2.6.10-rc1-mm2/kernel/drivers/video/intelfb/intelfb.ko needs unknown symbol agp_backend_release
WARNING: /lib/modules/2.6.10-rc1-mm2/kernel/drivers/video/i810/i810fb.ko needs unknown symbol agp_backend_acquire
WARNING: /lib/modules/2.6.10-rc1-mm2/kernel/drivers/video/i810/i810fb.ko needs unknown symbol agp_backend_release

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
