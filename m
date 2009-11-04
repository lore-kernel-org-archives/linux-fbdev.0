From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH v3 0/3] DRM/KMS framebuffer fixes
Date: Wed, 04 Nov 2009 09:40:36 +0100
Message-ID: <4AF13E04.8000005@ladisch.de>
References: <4AEE8CDD.10600@ladisch.de> <4AEE8D6F.60209@ladisch.de> <alpine.LFD.2.00.0911021431360.30135@casper.infradead.org> <4AF01F72.2030605@ladisch.de> <4AF01FFD.50409@ladisch.de> <alpine.LFD.2.00.0911031718160.14442@casper.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753145AbZKDIkf@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.0911031718160.14442@casper.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Dave Airlie <airlied@redhat.com>, dri-devel@lists.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

James Simmons wrote:
> > @@ -905,6 +905,9 @@ int drm_fb_helper_single_fb_probe(struct
> >  
> >  	if (new_fb) {
> >  		info->var.pixclock = 0;
> > +		ret = fb_alloc_cmap(&info->cmap, crtc->gamma_size, 0);
> > +		if (ret)
> > +			return ret;
> 
> >  		if (register_framebuffer(info) < 0) {
> 			fb_dealloc_cmap(info->cmap);	
> >  			return -EINVAL;
> 		}
> 
> Plug memory leak.

Oops.  Thanks again.
New patch set follows:

 include/drm/drm_crtc.h          |    2 +-
 drivers/gpu/drm/drm_fb_helper.c |   14 ++++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

v2: incorporated suggestions by James Simmons
v3: bugfix by James Simmons
