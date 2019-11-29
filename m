From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Date: Fri, 29 Nov 2019 14:12:02 +0000
Subject: Re: [PATCH v2 01/14] video: fb_defio: preserve user fb_ops
Message-Id: <b9c25f8d-c1e4-3c72-c6ed-903015a69e63@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575022735.git.jani.nikula@intel.com>
 <022c82429da15d6450ff9ac1a897322ec3124db4.1575022735.git.jani.nikula@intel.com>
In-Reply-To: <022c82429da15d6450ff9ac1a897322ec3124db4.1575022735.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jani Nikula <jani.nikula@intel.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org



Den 29.11.2019 11.29, skrev Jani Nikula:
> Modifying fb_ops directly to override fb_mmap with fb_deferred_io_mmap
> and then resetting it to NULL afterwards causes problems all over the
> place. First, it prevents making the fbops member of struct fb_info a
> const pointer, which means we can't make struct fb_ops const
> anywhere. Second, a few places have to go out of their way to restore
> the original fb_mmap pointer that gets reset to NULL.
> 
> Since the only user of the fbops->fb_mmap hook is fb_mmap() in fbmem.c,
> call fb_deferred_io_mmap() directly when deferred IO is enabled, and
> avoid modifying fb_ops altogether.
> 
> Simply use info->fbdefio to determine whether deferred IO should be used
> or not. This should be accurate enough for all use cases, although
> perhaps not pedantically correct.
> 
> v2: Simplify considerably by calling fb_deferred_io_mmap() directly
>     (Daniel, Ville)
> 
> Cc: Jaya Kumar <jayalk@intworks.biz>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---

Nice simple solution:

Acked-by: Noralf Trønnes <noralf@tronnes.org>
