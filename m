From: Sasha Levin <sashal@kernel.org>
Date: Sat, 11 Jan 2020 16:29:57 +0000
Subject: Re: [PATCH][RESEND] video: hyperv_fb: Fix hibernation for the deferred IO feature
Message-Id: <20200111162957.GK1706@sasha-vm>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1578350511-130150-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1578350511-130150-1-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, sthemmin@microsoft.com, b.zolnierkie@samsung.com, haiyangz@microsoft.com, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, weh@microsoft.com, kys@microsoft.com, Alexander.Levin@microsoft.co, mikelley@microsoft.com

On Mon, Jan 06, 2020 at 02:41:51PM -0800, Dexuan Cui wrote:
>fb_deferred_io_work() can access the vmbus ringbuffer by calling
>fbdefio->deferred_io() -> synthvid_deferred_io() -> synthvid_update().
>
>Because the vmbus ringbuffer is inaccessible between hvfb_suspend()
>and hvfb_resume(), we must cancel info->deferred_work before calling
>vmbus_close() and then reschedule it after we reopen the channel
>in hvfb_resume().
>
>Fixes: a4ddb11d297e ("video: hyperv: hyperv_fb: Support deferred IO for Hyper-V frame buffer driver")
>Fixes: 824946a8b6fb ("video: hyperv_fb: Add the support of hibernation")
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>Reviewed-by: Wei Hu <weh@microsoft.com>
>---
>
>This is a RESEND of https://lkml.org/lkml/2019/11/20/73 .
>
>The only change is the addition of Wei's Review-ed-by.
>
>Please review.
>
>If it looks good, Sasha Levin, can you please pick it up via the
>hyperv/linux.git tree, as you did last time for this driver?

Like with the input driver, if the relevant maintainers here are okay
with this type of patches going through the hyperv tree I'll be happy to
do it, otherwise I need an explicit ack from them on this patch.

-- 
Thanks,
Sasha
