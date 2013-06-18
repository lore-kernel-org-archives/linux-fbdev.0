From: David Airlie <airlied@redhat.com>
Date: Tue, 18 Jun 2013 23:00:09 +0000
Subject: Re: [PATCH v2 1/2] video: fbmem: Use 'const char' in fb_get_options()
Message-Id: <728837318.19851077.1371596409062.JavaMail.root@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1371568723-27486-1-git-send-email-fabio.estevam@freescale.com>
In-Reply-To: <1371568723-27486-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org



----- Original Message -----
> From: "Fabio Estevam" <fabio.estevam@freescale.com>
> To: plagnioj@jcrosoft.com
> Cc: linux-fbdev@vger.kernel.org, festevam@gmail.com, geert@linux-m68k.org, "Fabio Estevam"
> <fabio.estevam@freescale.com>, "Ville Syrjälä" <ville.syrjala@linux.intel.com>, "Daniel Vetter"
> <daniel.vetter@ffwll.ch>, "Dave Airlie" <airlied@redhat.com>
> Sent: Wednesday, 19 June, 2013 1:18:42 AM
> Subject: [PATCH v2 1/2] video: fbmem: Use 'const char' in fb_get_options()
> 
> Commit d20d31748 (drm: Constify the pretty-print functions) causes the
> following
> build warning:

This patch should already be merged into the fbdev tree, at least the maintainer said it was, hence why I didn't merge it into
my drm-next tree.

Is the fbdev queue not in the drm-next?

Dave.
