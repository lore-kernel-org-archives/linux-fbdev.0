From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Thu, 10 Dec 2015 17:00:19 +0000
Subject: Re: [PATCH RFC 0/9] omapdrm/omapfb/omapdss split
Message-Id: <CACvgo51Yezd4Rzcc8A1wrCUH4YX9gjhgpuYrt5dEPwhc=v03fA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
 <CAF6AEGsCi_-YwQHYjfO_ao7Fg8QmQ=Gka1rG+OgkNqNaRsA5vw@mail.gmail.com>
In-Reply-To: <CAF6AEGsCi_-YwQHYjfO_ao7Fg8QmQ=Gka1rG+OgkNqNaRsA5vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Clark <robdclark@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>

On 10 December 2015 at 14:53, Rob Clark <robdclark@gmail.com> wrote:

> It would be nice to see omapdrm eventually using the panel framework,
> etc.  But I think copy/paste to decouple omapdrm from omapfb/vout as
> the first step makes sense.
>
Moar panels/bridges :-P

But seriously, I think that this is the better idea, despite the
duplication that'll exist in the first place. Otherwise you'll end up
pulling your hairs out trying to balance everything drm and fbdev/vout
working.

A suggestion... do throw a big scary warning in the fbdev copy - "Here
be dragons... old, mostly maintained code, bugfixes only please".
Otherwise some poor soul might decide to port the drm patches back
into the fbdev copy, or try to de-duplicate things :-)

-Emil
