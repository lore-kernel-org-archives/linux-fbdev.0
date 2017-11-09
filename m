From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 09 Nov 2017 13:12:46 +0000
Subject: Re: [PATCH 0/8] video: fbdev: au1200fb: Fix error handling path of 'au1200fb_drv_probe()'
Message-Id: <3843760.j1Dl9T2ZgC@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171016190602epcas2p1c54546e982659187188f178846c54531@epcas2p1.samsung.com>
 <cover.1508179264.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1508179264.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: tj@kernel.org, linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On Monday, October 16, 2017 09:04:46 PM Christophe JAILLET wrote:
> This patch serie tries to fix several issues found in the error handling
> code of 'au1200fb_drv_probe()'.
> The 5 first patches fixes various issues (double free, missing error code,
> un-released resources on error, incorrect IRQ releasing and incomplete
> error handling path)
> 
> The 3 last patches are just cleanups.
> 
> 
> I've spilt the serie in 8 steps that look logical to me. They could
> also be merged together if preferred.
> 
> 
> These patches are provided as-is and ARE NOT even compile-tested (sorry in
> advance if a patch is broken) because I don't have a cross compiler for MIPS
> and won't install one.
> 
> 
> This serie already goes further that the fixes I usually provide, so
> please excuse me if I missed something or if it is somehow broken and/or
> incomplete.
> 
> ---
> V1 previously posted is patch 3/8 of this serie
> 
> Christophe JAILLET (8):
>   video: fbdev: au1200fb: Fix a potential double free
>   video: fbdev: au1200fb: Return an error code if a memory allocation
>     fails
>   video: fbdev: au1200fb: Release some resources if a memory allocation
>     fails
>   video: fbdev: au1200fb: Fix error handling path
>   video: fbdev: au1200fb: Fix error handling path
>   video: fbdev: au1200fb: Remove some dead code
>   video: fbdev: au1200fb: Propagate an error code
>   video: fbdev: au1200fb: Style clean up
> 
>  drivers/video/fbdev/au1200fb.c | 43 ++++++++++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 20 deletions(-)

Thanks, I queued all patches for 4.15.

I also did some minor fixes to the patch #4 while merging it:

* patch summary was changed to "video: fbdev: au1200fb: Fix incorrect IRQ
  freeing") to be different from the patch summary of patch #5

* patch description was changed to silence issues reported by checkpatch.pl:

WARNING: 'succesful' may be misspelled - perhaps 'successful'?
#4: 
'au1200fb_drv_probe()' can not fail after a succesful call to

ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 1630d85a8312 ("au1200fb: fix hardcoded IRQ")'
#9: 
1630d85a8312 ("au1200fb: fix hardcoded IRQ")

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

