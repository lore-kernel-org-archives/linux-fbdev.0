From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 17 Oct 2020 06:28:08 +0000
Subject: Re: [PATCH] video: fbdev: sis: remove unneeded semicolon
Message-Id: <20201017062808.GG2242298@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200910140536.1191150-1-yanaijie@huawei.com>
In-Reply-To: <20200910140536.1191150-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jason Yan <yanaijie@huawei.com>
Cc: linux-fbdev@vger.kernel.org, b.zolnierkie@samsung.com, thomas@winischhofer.net, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Hulk Robot <hulkci@huawei.com>

On Thu, Sep 10, 2020 at 10:05:36PM +0800, Jason Yan wrote:
> Eliminate the following coccicheck warning:
> 
> drivers/video/fbdev/sis/sis_accel.h:143:72-73: Unneeded semicolon
> drivers/video/fbdev/sis/sis_accel.h:144:72-73: Unneeded semicolon
> drivers/video/fbdev/sis/sis_accel.h:145:72-73: Unneeded semicolon
> drivers/video/fbdev/sis/sis_accel.h:273:75-76: Unneeded semicolon
> drivers/video/fbdev/sis/sis_accel.h:274:75-76: Unneeded semicolon
> drivers/video/fbdev/sis/sis_accel.h:275:73-74: Unneeded semicolon
> drivers/video/fbdev/sis/sis_accel.h:276:75-76: Unneeded semicolon
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied to drm-misc-next.
checkpatch was not happy with the patch - but I ignored these warnings
as this is an old code base.

	Sam
