From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 29 Nov 2019 20:30:07 +0000
Subject: Re: [PATCH v2 14/14] auxdisplay: constify fb ops
Message-Id: <20191129203007.GV624164@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575022735.git.jani.nikula@intel.com>
 <94a33cf0a587e803bcadcf80e8152eac9b196f34.1575022735.git.jani.nikula@intel.com>
 <20191129152424.GG624164@phenom.ffwll.local>
 <CANiq72kRGg1AZHC-pR_uKykMxmcMPM2+qbXVPVQhHrZRzu723Q@mail.gmail.com>
In-Reply-To: <CANiq72kRGg1AZHC-pR_uKykMxmcMPM2+qbXVPVQhHrZRzu723Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>, Robin van der Gracht <robin@protonic.nl>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org

On Fri, Nov 29, 2019 at 09:16:42PM +0100, Miguel Ojeda wrote:
> On Fri, Nov 29, 2019 at 4:24 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > Oh, another display subsystem? Intriguing ...
> >
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> It is intended for displays that are not intended as the usual/main
> display, e.g. very small LCDs :)

Well we do have very small lcd display drivers in drm, and before that in
fbdev. And you have a fbdev framebuffer driver in there, which looks a bit
misplaced ...

Afaiui you also have some even tinier lcd drivers where you don't address
pixels, but just directly upload text, and those obviously don't fit into
drm/fbdev world. But anything where you can address pixels very much does.
-Daniel

> 
> Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> 
> Cheers,
> Miguel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
