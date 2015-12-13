From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 13 Dec 2015 19:08:52 +0000
Subject: Re: [PATCH RFC 8/9] drm/omap: move omapdss & displays under omapdrm
Message-Id: <13812119.EOZzmrY4TL@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
 <1449757535-5674-9-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1449757535-5674-9-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi Tomi,

Thank you for the patch.

On Thursday 10 December 2015 16:25:34 Tomi Valkeinen wrote:
> Now that omapfb has its own copy of omapdss and display drivers, we can
> move omapdss and display drivers which omapdrm uses to omapdrm's
> directory.
> 
> We also need to change the main drm Makefile so that omapdrm directory
> is always entered, because omapdss has a file that always needs to be
> built-in.

Which file is that ? omapdss-boot-init.c ? I would say "that can't be built as 
a module' instead of 'that always needs to be built-in' as the later implies 
(at least for me) that the file always have to be built-in regardless of 
whether omapdss support is enabled or not.

> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

-- 
Regards,

Laurent Pinchart

