From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 10 Sep 2018 12:51:01 +0000
Subject: Re: [PATCH 3/4] fbdev: Add FBINFO_HIDE_SMEM_START flag
Message-Id: <20180910125103eucas1p1e7da7341048a5e54a89e21a94559f576~TCuHaF7jg0750707507eucas1p1q@eucas1p1.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180822085405.10787-1-daniel.vetter@ffwll.ch>
        <CGME20180822085420epcas1p1725a9444c93e8deb30d253d0fea2d5d6@epcas1p1.samsung.com>
        <20180822085405.10787-3-daniel.vetter@ffwll.ch>
In-Reply-To: <20180822085405.10787-3-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>, linux-fbdev@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>


On 08/22/2018 10:54 AM, Daniel Vetter wrote:
> DRM drivers really, really, really don't want random userspace to
> share buffer behind it's back, bypassing the dma-buf buffer sharing
> machanism. For that reason we've ruthlessly rejected any IOCTL
> exposing the physical address of any graphics buffer.
> 
> Unfortunately fbdev comes with that built-in. We could just set
> smem_start to 0, but that means we'd have to hand-roll our own fb_mmap
> implementation. For good reasons many drivers do that, but
> smem_start/length is still super convenient.
> 
> Hence instead just stop the leak in the ioctl, to keep fb mmap working
> as-is. A second patch will set this flag for all drm drivers.
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
