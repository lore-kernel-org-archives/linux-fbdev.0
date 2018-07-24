From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Jul 2018 15:18:30 +0000
Subject: Re: [PATCH v2 fbdev-for-next 1/2] fbcon: introduce for_each_registered_fb() helper
Message-Id: <3211840.FYfgcvebvD@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180630073004epcas2p2d87aa0abbbae08dafd661c8378ba1de1@epcas2p2.samsung.com>
 <1530343789-4237-1-git-send-email-ysxie@foxmail.com>
In-Reply-To: <1530343789-4237-1-git-send-email-ysxie@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yisheng Xie <ysxie@foxmail.com>
Cc: linux-fbdev@vger.kernel.org, j.w.r.degoede@gmail.com, keescook@chromium.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, andriy.shevchenko@linux.intel.com, david@lechnology.com

On Saturday, June 30, 2018 03:29:49 PM Yisheng Xie wrote:
> Following pattern is often used:
> 
>  for (i = 0; i < FB_MAX; i++) {
>         if (registered_fb[i]) {
>                 ...
>         }
>  }
> 
> Therefore, as Andy's suggestion, for_each_registered_fb() helper can
> be introduced to make the code easier to read and write by reducing
> indentation level. It also saves few lines of code in each occurrence.
> 
> This patch convert all part here at the same time.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Yisheng Xie <ysxie@foxmail.com>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

