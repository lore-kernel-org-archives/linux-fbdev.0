From: Peter Jones <pjones@redhat.com>
Date: Tue, 18 Jul 2017 14:34:05 +0000
Subject: Re: [PATCH] efifb: allow user to disable write combined mapping.
Message-Id: <20170718143404.omgxrujngj2rhiya@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170718060909.5280-1-airlied@redhat.com>
In-Reply-To: <20170718060909.5280-1-airlied@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org, hpa@zytor.com, torvalds@linux-foundation.org

On Tue, Jul 18, 2017 at 04:09:09PM +1000, Dave Airlie wrote:
> This patch allows the user to disable write combined mapping
> of the efifb framebuffer console using an nowc option.
> 
> A customer noticed major slowdowns while logging to the console
> with write combining enabled, on other tasks running on the same
> CPU. (10x or greater slow down on all other cores on the same CPU
> as is doing the logging).
> 
> I reproduced this on a machine with dual CPUs.
> Intel(R) Xeon(R) CPU E5-2609 v3 @ 1.90GHz (6 core)
> 
> I wrote a test that just mmaps the pci bar and writes to it in
> a loop, while this was running in the background one a single
> core with (taskset -c 1), building a kernel up to init/version.o
> (taskset -c 8) went from 13s to 133s or so. I've yet to explain
> why this occurs or what is going wrong I haven't managed to find
> a perf command that in any way gives insight into this.
> 
>     11,885,070,715      instructions              #    1.39  insns per cycle
> vs
>     12,082,592,342      instructions              #    0.13  insns per cycle
> 
> is the only thing I've spotted of interest, I've tried at least:
> dTLB-stores,dTLB-store-misses,L1-dcache-stores,LLC-store,LLC-store-misses,LLC-load-misses,LLC-loads,\mem-loads,mem-stores,iTLB-loads,iTLB-load-misses,cache-references,cache-misses
> 
> For now it seems at least a good idea to allow a user to disable write
> combining if they see this until we can figure it out.

Well, that's kind of amazing, given 3c004b4f7eab239e switched us /to/
using ioremap_wc() for the exact same reason.  I'm not against letting
the user force one way or the other if it helps, though it sure would be
nice to know why.

Anyway,

Acked-By: Peter Jones <pjones@redhat.com>

Bartlomiej, do you want to handle this in your devel tree?

-- 
  Peter
