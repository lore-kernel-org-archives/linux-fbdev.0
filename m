From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 04 Jan 2018 15:50:25 +0000
Subject: Re: [PATCH] fbdev: auo_k190x: Use zeroing memory allocator than allocator/memset
Message-Id: <2609430.fGI7Anm6Eo@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171231122615epcas1p467e0c038c7009363f9ee9444c82ab29d@epcas1p4.samsung.com>
 <1514723157-5675-1-git-send-email-himanshujha199640@gmail.com>
In-Reply-To: <1514723157-5675-1-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Sunday, December 31, 2017 05:55:57 PM Himanshu Jha wrote:
> Use vzalloc for allocating zeroed memory and remove unnecessary
> memset function.
> 
> Done using Coccinelle.
> Generated-by: scripts/coccinelle/api/alloc/kzalloc-simple.cocci

Use of "Generated-by:" triggers checkpatch.pl warning + error:

WARNING: Non-standard signature: Generated-by:
#8: 
Generated-by: scripts/coccinelle/api/alloc/kzalloc-simple.cocci

ERROR: Unrecognized email address: 'scripts/coccinelle/api/alloc/kzalloc-simple.cocci'
#8: 
Generated-by: scripts/coccinelle/api/alloc/kzalloc-simple.cocci

I've changed it to "Generate-by" to silence checkpatch.pl.

> 0-day tested with no failures.
> 
> Suggested-by: Luis R. Rodriguez <mcgrof@kernel.org>
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>

Patch queued for 4.16, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

