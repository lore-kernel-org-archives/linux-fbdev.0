From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 21 Jun 2019 11:06:45 +0000
Subject: Re: [PATCH] video: fbdev: pvr2fb: fix build warning when compiling as module
Message-Id: <b54d11f4-bc25-3e1a-1a7e-2c61555be39b@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2376f0a7-2511-b52d-c0d1-9162382f8693@samsung.com>
 <CGME20190621110647eucas1p2d7b803b54304d653e5755677d28e3117@eucas1p2.samsung.com>
In-Reply-To: <2376f0a7-2511-b52d-c0d1-9162382f8693@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>


On 6/14/19 12:43 PM, Bartlomiej Zolnierkiewicz wrote:
> Add missing #ifndef MODULE around pvr2_get_param_val().
> 
> Fixes: 0f5a5712ad1e ("video: fbdev: pvr2fb: add COMPILE_TEST support")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

I queued the patch for v5.3.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
