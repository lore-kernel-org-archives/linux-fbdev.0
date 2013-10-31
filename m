From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 31 Oct 2013 23:06:00 +0000
Subject: Re: [PATCH v3 21/32] drm/exynos: Move dp driver from video/ to drm/
Message-Id: <000701ced68d$c3cd7d80$4b687880$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383063198-10526-1-git-send-email-seanpaul@chromium.org>
 <1383063198-10526-22-git-send-email-seanpaul@chromium.org>
 <031801ced626$7cca5820$765f0860$%dae@samsung.com>
In-Reply-To: <031801ced626$7cca5820$765f0860$%dae@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Inki Dae' <inki.dae@samsung.com>, 'Sean Paul' <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org
Cc: 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Jean-Christophe PLAGNIOL-VILLARD' <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, airlied@linux.ie, tomasz.figa@gmail.com, marcheu@chromium.org, 'Jingoo Han' <jg1.han@samsung.com>

On Thursday, October 31, 2013 7:47 PM, Inki Dae wrote:
> 
> CCing Jingoo,
> 
> Is that ok to remove eDP driver from video/exynos? Isn't this driver really
> used by Linux framebuffer driver, s3c-fb.c?

+cc Tomi Valkeinen, Jean-Christophe PLAGNIOL-VILLARD,
     linux-fbdev list, linux-samsung-soc list

Yes, it is used by s3c-fb.c.

> 
> Of course, now s3c-fb driver is dead code because this driver doesn't
> support device tree yet but we would need more reviews and discussions about
> moving this driver into drm side. Let's watch new rules for device tree
> bindings of DRM world. So I'd not like to merge this driver yet.

's3c-fb' driver is still used for other mass products projects.
Just, device tree support patch is not yet submitted.


Sean Paul,
When moving the driver, notify related Maintainers of that driver.
Please use 'scripts/get_maintainer.pl' next time.

Best regards,
Jingoo Han

