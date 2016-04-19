From: Dave Airlie <airlied@gmail.com>
Date: Tue, 19 Apr 2016 21:33:07 +0000
Subject: Re: [PATCH] drm/vc4: Kick out the simplefb framebuffer before we set up KMS.
Message-Id: <CAPM=9tyAZJns5aAaWWMaCPtG_=H2hiPYhPeXfNLJ+ExF18mmBQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461098229-8664-1-git-send-email-eric@anholt.net>
In-Reply-To: <1461098229-8664-1-git-send-email-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eric Anholt <eric@anholt.net>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Hans de Goede <hdegoede@redhat.com>, linux-rpi-kernel@lists.infradead.org

On 20 April 2016 at 06:37, Eric Anholt <eric@anholt.net> wrote:
> If we don't, then simplefb stays loaded on /dev/fb0 even though
> scanout isn't happening from simplefb's memory area any more, and you
> end up with no console.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>
> Dave: It would be nice if I could merge this patch through
> bcm2835-dt-next, where I'm trying to get the VC4 DT merged even though
> the defconfig includes both VC4 and simplefb.  There aren't any
> conflicts with anything I'm merging through drm-next.

sounds fine.

Acked-by: Dave Airlie <airlied@redhat.com>

Dave.
