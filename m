From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 11 Apr 2019 15:45:46 +0000
Subject: Re: [PATCH -next] video: fbdev: remove set but not used variable 'size'
Message-Id: <068ec894-c1f1-1e89-3c5d-0dc28ddc0982@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190330021509epcas4p47a2e10cc5ad02812441a3eae3814a950@epcas4p4.samsung.com>
 <20190330022626.97340-1-yuehaibing@huawei.com>
In-Reply-To: <20190330022626.97340-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: YueHaibing <yuehaibing@huawei.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-fbdev@vger.kernel.org, Kees Cook <keescook@chromium.org>, kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org, Andrew Morton <akpm@linux-foundation.org>, Ira Weiny <ira.weiny@intel.com>


On 03/30/2019 03:26 AM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/video/fbdev/pvr2fb.c: In function 'pvr2fb_init':
> drivers/video/fbdev/pvr2fb.c:1074:6: warning:
>  variable 'size' set but not used [-Wunused-but-set-variable]
> 
> It's not used since commit 9cd1c6743454 ("pvr2fb: Fix oops when
> pseudo_palette is written")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch queued for v5.2 with minor change in the patch summary
("video: fbdev: pvr2fb: remove set but not used variable 'size'"),
thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
