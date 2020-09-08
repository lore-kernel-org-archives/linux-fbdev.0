From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 08 Sep 2020 11:37:25 +0000
Subject: Re: [PATCH] docs: fb: Correcting the location of FRAMEBUFFER_CONSOLE option.
Message-Id: <35fef2e8-dafd-c1dc-711d-fdbdf80c36a8@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200824145242eucas1p1ed74d79e952a573a80d43864b500e0ca@eucas1p1.samsung.com>
 <20200824145155.42502-1-bilalwasim676@gmail.com>
In-Reply-To: <20200824145155.42502-1-bilalwasim676@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bilal Wasim <bilalwasim676@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, corbet@lwn.net


[ added linux-fbdev ML to Cc: ]

On 8/24/20 4:51 PM, Bilal Wasim wrote:
> fbcon doc mentions FRAMEBUFFER_CONSOLE option to be under
> Device Drivers->Graphics Support->Frame buffer Devices->
> Console display driver support->Framebuffer Console Support,
> while its under Device Drivers->Graphics Support->
> Console display driver support->Framebuffer Console Support.
> 
> Correcting it in the docs.
> 
> Signed-off-by: Bilal Wasim <bilalwasim676@gmail.com>

Applied to drm-misc-next tree, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  Documentation/fb/fbcon.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
> index e57a3d1d085a..a7b487cba307 100644
> --- a/Documentation/fb/fbcon.rst
> +++ b/Documentation/fb/fbcon.rst
> @@ -20,8 +20,8 @@ A. Configuration
>  ========
>  
>  The framebuffer console can be enabled by using your favorite kernel
> -configuration tool.  It is under Device Drivers->Graphics Support->Frame
> -buffer Devices->Console display driver support->Framebuffer Console Support.
> +configuration tool.  It is under Device Drivers->Graphics Support->
> +Console display driver support->Framebuffer Console Support.
>  Select 'y' to compile support statically or 'm' for module support.  The
>  module will be fbcon.
>  
