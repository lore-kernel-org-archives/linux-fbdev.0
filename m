From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 29 Nov 2019 20:16:42 +0000
Subject: Re: [PATCH v2 14/14] auxdisplay: constify fb ops
Message-Id: <CANiq72kRGg1AZHC-pR_uKykMxmcMPM2+qbXVPVQhHrZRzu723Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575022735.git.jani.nikula@intel.com>
 <94a33cf0a587e803bcadcf80e8152eac9b196f34.1575022735.git.jani.nikula@intel.com>
 <20191129152424.GG624164@phenom.ffwll.local>
In-Reply-To: <20191129152424.GG624164@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Jani Nikula <jani.nikula@intel.com>, Robin van der Gracht <robin@protonic.nl>, linux-fbdev@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org

On Fri, Nov 29, 2019 at 4:24 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> Oh, another display subsystem? Intriguing ...
>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

It is intended for displays that are not intended as the usual/main
display, e.g. very small LCDs :)

Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
