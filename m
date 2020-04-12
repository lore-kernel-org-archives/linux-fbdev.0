From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 12 Apr 2020 20:34:03 +0000
Subject: Re: [PATCH] fbdev: mx3fb: const pointer to ipu_di_signal_cfg
Message-Id: <20200412203402.GA27677@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200408162551.3928330-1-arnd@arndb.de> <87pnchhp2s.fsf@intel.com>
 <20200408180216.GC24828@ravnborg.org>
 <20200408182926.GA21997@ravnborg.org>
 <20200408200141.GM4881@pendragon.ideasonboard.com>
In-Reply-To: <20200408200141.GM4881@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jani Nikula <jani.nikula@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Enrico Weigelt <info@metux.net>

On Wed, Apr 08, 2020 at 11:01:41PM +0300, Laurent Pinchart wrote:
> Hi Sam,
> 
> Thank you for the patch.
> 
> On Wed, Apr 08, 2020 at 08:29:26PM +0200, Sam Ravnborg wrote:
> > Laurent Pinchart <laurent.pinchart@ideasonboard.com> and
> > Jani Nikula <jani.nikula@intel.com> both
> > suggested to make the pointer to struct ipu_di_signal_cfg const.
> > 
> > Fix this.
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Fixes: 3f6c93ec9254 ("fbdev: mx3fb: avoid warning about psABI change")
> > Cc: Jani Nikula <jani.nikula@intel.com>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Enrico Weigelt <info@metux.net>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: linux-fbdev@vger.kernel.org
> 
> Assuming this is compile-tested,
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks. Applied and pushed out to drm-misc-next.

	Sam
