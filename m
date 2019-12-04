From: Sakari Ailus <sakari.ailus@iki.fi>
Date: Wed, 04 Dec 2019 11:33:16 +0000
Subject: Re: [PATCH v3 10/12] media: constify fb ops across all drivers
Message-Id: <20191204113315.GG5282@valkosipuli.retiisi.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575390740.git.jani.nikula@intel.com>
 <71794337f8611271f2c1fdb3882119a58e743a87.1575390741.git.jani.nikula@intel.com>
In-Reply-To: <71794337f8611271f2c1fdb3882119a58e743a87.1575390741.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-fbdev@vger.kernel.org, Andy Walls <awalls@md.metrocast.net>, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil@xs4all.nl>, ivtv-devel@ivtvdriver.org, linux-media@vger.kernel.org

On Tue, Dec 03, 2019 at 06:38:52PM +0200, Jani Nikula wrote:
> Now that the fbops member of struct fb_info is const, we can start
> making the ops const as well.
> 
> Remove the redundant fbops assignments while at it.
> 
> v2:
> - actually add const in vivid
> - fix typo (Christophe de Dinechin)
> 
> Cc: Hans Verkuil <hverkuil@xs4all.nl>
> Cc: Andy Walls <awalls@md.metrocast.net>
> Cc: linux-media@vger.kernel.org
> Cc: ivtv-devel@ivtvdriver.org
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
