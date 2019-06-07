From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 07 Jun 2019 12:34:41 +0000
Subject: Re: [PATCH v3 2/2] video: fbdev: pvr2fb: add COMPILE_TEST support
Message-Id: <df3ac4b0-2da5-1611-6ec2-be3f4cd3c935@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <e59b45f6-b8a5-ed99-f294-072df1a1d222@samsung.com>
        <CGME20190607123439eucas1p16f9538b5b30f57daa4a11c2ea78015a9@eucas1p1.samsung.com>
In-Reply-To: <e59b45f6-b8a5-ed99-f294-072df1a1d222@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org


On 5/24/19 1:58 PM, Bartlomiej Zolnierkiewicz wrote:
> Add COMPILE_TEST support to pvr2fb driver for better compile
> testing coverage.
> 
> While at it:
> 
> - mark pvr2fb_interrupt() and pvr2fb_common_init() with
>   __maybe_unused tag (to silence build warnings when
>   !SH_DREAMCAST)
> 
> - convert mmio_base in struct pvr2fb_par to 'void __iomem *'
>   from 'unsigned long' (needed to silence build warnings on
>   ARM).
> 
> - split pvr2_get_param() on pvr2_get_param_name() and
>   pvr2_get_param_val() (needed to silence build warnings on
>   x86).
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
I queued the patch for v5.3.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
