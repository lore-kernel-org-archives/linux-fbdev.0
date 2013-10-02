From: Stephen Warren <swarren@wwwdotorg.org>
Date: Wed, 02 Oct 2013 16:16:34 +0000
Subject: Re: [PATCH 1/2] simplefb: fix unmapping fb during destruction
Message-Id: <524C46E2.5040804@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1380725919-1961-1-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1380725919-1961-1-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Tom Gundersen <teg@jklm.no>, Alexandre Courbot <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On 10/02/2013 08:58 AM, David Herrmann wrote:
> Unfortunately, fbdev does not create its own "struct device" for
> framebuffers. Instead, it attaches to the device of the parent layer. This
> has the side-effect that devm_* managed resources are not cleaned up on
> framebuffer-destruction but rather during destruction of the
> parent-device. In case of fbdev this might be too late, though.
> remove_conflicting_framebuffer() may remove fbdev devices but keep the
> parent device as it is.
> 
> Therefore, we now use plain ioremap() and unmap the framebuffer in the
> fb_destroy() callback. Note that we must not free the device here as this
> might race with the parent-device removal. Instead, we rely on
> unregister_framebuffer() as barrier and we're safe.

So, once the .fb_destroy callback has been executed, there's no other
callback to resurrect it? The framebuffer itself is still registered
until the device's remove, yet after .fb_destroy, the memory is
unmapped, which would be dangerous if the FB can be re-started.

If that's not an issue, this patch seems fine, so
Acked-by: Stephen Warren <swarren@nvidia.com>

> I know that simplefb was supposed to stay "as simple as possible" but I really
> think this series is the last set of fixes I have. Unfortunately framebuffer DRM
> handover is mandatory so we cannot ignore it in simplefb.

I don't think this patch adds any significant complexity, so I'm not
worried at least.
