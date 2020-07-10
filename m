From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 10 Jul 2020 19:17:29 +0000
Subject: Re: [PATCH v1 0/1] dt-bindings: fix simple-framebuffer warning
Message-Id: <20200710191729.GB675682@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200704143544.789345-1-sam@ravnborg.org>
In-Reply-To: <20200704143544.789345-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Cc: David Airlie <airlied@linux.ie>, Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Sat, Jul 04, 2020 at 04:35:43PM +0200, Sam Ravnborg wrote:
> Trivial fix for a long standing warning.
> At least not fixed in drm-msc-next for now.
> Just in case it was not fixed by someone else (Rob?) already.
> 
> 	Sam
> 
> Sam Ravnborg (1):
>       dt-bindings: fix simple-framebuffer example

Applied to drm-misc-next.

	Sam

> 
>  .../bindings/display/simple-framebuffer.yaml       | 45 +++++++++++-----------
>  1 file changed, 23 insertions(+), 22 deletions(-)
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
