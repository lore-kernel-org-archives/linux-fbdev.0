From: Marcin Slusarz <marcin.slusarz@gmail.com>
Date: Sun, 11 Apr 2010 17:09:00 +0000
Subject: Re: [PATCH 3/3] fbmem, drm/nouveau: kick firmware framebuffers as
Message-Id: <20100411170900.GB4016@joi.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1270929334-3742-1-git-send-email-marcin.slusarz@gmail.com>
	<1270929334-3742-3-git-send-email-marcin.slusarz@gmail.com>
In-Reply-To: <1270929334-3742-3-git-send-email-marcin.slusarz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>
Cc: linux-fbdev@vger.kernel.org, Didier Spaier <didier.spaier@epsm.fr>, nouveau@lists.freedesktop.org, Peter Jones <pjones@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Dave Airlie <airlied@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

On Sat, Apr 10, 2010 at 09:55:34PM +0200, marcin.slusarz@gmail.com wrote:
> Currently vesafb/efifb/... is kicked when hardware driver is registering
> framebuffer. To do it hardware must be fully functional, so there's a short
> window between start of initialisation and framebuffer registration when
> two drivers touch the hardware. Unfortunately sometimes it breaks nouveau
> initialisation.
> 
> Fix it by kicking firmware driver(s) before we start touching the hardware.
> 
> Reported-by: Didier Spaier <didier.spaier@epsm.fr>
> Signed-off-by: Marcin Slusarz <marcin.slusarz@gmail.com>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Peter Jones <pjones@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---

With this little patch below:
Tested-by: Didier Spaier <didier.spaier@epsm.fr>

---
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index f5297a0..42ae782 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1524,6 +1524,7 @@ void remove_conflicting_framebuffers(struct apertures_struct *a, const char *nam
 		}
 	}
 }
+EXPORT_SYMBOL(remove_conflicting_framebuffers);
 
 /**
  *	register_framebuffer - registers a frame buffer device

