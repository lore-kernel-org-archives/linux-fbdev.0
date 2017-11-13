From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 13 Nov 2017 17:20:11 +0000
Subject: Re: [PATCH] fbcon: Initialize ops->info early
Message-Id: <1603816.FMahT1RJZd@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171113094554epcas3p2eb67a3b7263176dfabc719e3bddb792c@epcas3p2.samsung.com>
 <20171113094546.16593-1-thierry.reding@gmail.com>
In-Reply-To: <20171113094546.16593-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Kees Cook <keescook@chromium.org>

On Monday, November 13, 2017 10:45:46 AM Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> During console takeover, which happens for all DRM/KMS setups using the
> fbdev helpers, fbcon_startup() is called before fbcon_init() and as a
> result con2fb_acquire_newinfo() will not be called (info->fbcon_par was
> set to non-NULL in fbcon_startup()) to assign ops->info.
> 
> This causes the cursor_timer_handler() to unreference a NULL pointer.
> 
> Avoid this by unconditionally assigning ops->info during fbcon_startup()
> so that it will be available early, but keep the additional assignment
> in con2fb_acquire_newinfo() to support console remapping at runtime.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Patch queued for 4.15, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

