From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 29 Jun 2018 16:20:13 +0000
Subject: Re: [PATCH] fbcon: introduce for_each_registered_fb() helper
Message-Id: <ffe03b382ee84dbef8567b7377b929e4a8d6c23c.camel@linux.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1530202809-24105-1-git-send-email-ysxie@foxmail.com>
In-Reply-To: <1530202809-24105-1-git-send-email-ysxie@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yisheng Xie <ysxie@foxmail.com>, b.zolnierkie@samsung.com, keescook@chromium.org, j.w.r.degoede@gmail.com, david@lechnology.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2018-06-29 at 00:20 +0800, Yisheng Xie wrote:
> Following pattern is often used:
> 
>  for (i = 0; i < FB_MAX; i++) {
>         if (registered_fb[i]) {
>                 ...
>         }
>  }
> 
> Therefore, as Andy's suggestion, for_each_registered_fb() helper can

Suggested-by then ?

> be introduced to make the code easier to read and write by reducing
> indentation level. It also saves few lines of code in each occurrence.
> 
> This patch convert all part here at the same time.

LGTM except macro implementation. That's why I have mentioned
for_each_pci_bridge() to look at.

> +#define for_each_registered_fb(i)		\
> +	for (i = 0; i < FB_MAX; i++)		\
> +		if (registered_fb[i])
> +

This needs to be protected against nested conditionals.
Otherwise compiler issues a warning and even may generate wrong code.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
