From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 10 Aug 2015 11:47:18 +0000
Subject: Re: [PATCH] drm: Remove two-level menu in Kconfig
Message-Id: <20150810114718.GU17734@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438963817-9695-1-git-send-email-thierry.reding@gmail.com>
 <55C87DA8.1010206@ti.com>
In-Reply-To: <55C87DA8.1010206@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, dri-devel@lists.freedesktop.org

On Mon, Aug 10, 2015 at 01:32:08PM +0300, Tomi Valkeinen wrote:
> 
> 
> On 07/08/15 19:10, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > The Direct Rendering Manager Kconfig option is already a separate menu,
> > so remove the extra level to make it easier to navigate.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/video/Kconfig | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > index 8bf495ffb020..e0606c01e8ac 100644
> > --- a/drivers/video/Kconfig
> > +++ b/drivers/video/Kconfig
> > @@ -22,9 +22,7 @@ source "drivers/gpu/vga/Kconfig"
> >  source "drivers/gpu/host1x/Kconfig"
> >  source "drivers/gpu/ipu-v3/Kconfig"
> >  
> > -menu "Direct Rendering Manager"
> >  source "drivers/gpu/drm/Kconfig"
> > -endmenu
> >  
> >  menu "Frame buffer Devices"
> >  source "drivers/video/fbdev/Kconfig"
> > 
> 
> Thanks, queued for 4.3.

Oops failed to send out my usual mail, but I picked this already up in
topic/drm-misc.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
