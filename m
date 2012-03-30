From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 30 Mar 2012 01:16:32 +0000
Subject: Re: [PATCH] video/console: Clip the right margin clear to the visible region
Message-Id: <4F750970.6040801@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1332793022-29292-1-git-send-email-chris@chris-wilson.co.uk>
In-Reply-To: <1332793022-29292-1-git-send-email-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Chris,

On 03/26/2012 08:17 PM, Chris Wilson wrote:
> For some unknown reason, yres_virtual was 2x larger the the size specified
> by i915 and so when blit_clear_margins() tried to clear the full virtual
> right-hand margin it tried to write far beyond the end of the buffer.
> 
> This limits the clear to only the visible portion of the right-hand
> margin, similar to how the bottom margin is treated.
> 
> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id8138

as you also found the root of the problem and posted a patch to fix i915
(or rather all KMS-based framebuffers) by validating the virtual
resolution in check var, I don't see any reason to apply this one. I'm
not sure about it, but changing the behaviour of this function might
cause some undesired changes in user experience and as there is no
problem with this code as is, I'd prefer to not change it.


Best regards,

Florian Tobias Schandinat

> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> ---
>  drivers/video/console/bitblit.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/console/bitblit.c b/drivers/video/console/bitblit.c
> index 28b1a83..9f89e5a 100644
> --- a/drivers/video/console/bitblit.c
> +++ b/drivers/video/console/bitblit.c
> @@ -219,9 +219,9 @@ static void bit_clear_margins(struct vc_data *vc, struct fb_info *info,
>  
>  	if (rw && !bottom_only) {
>  		region.dx = info->var.xoffset + rs;
> -		region.dy = 0;
> +		region.dy = info->var.yoffset;
>  		region.width = rw;
> -		region.height = info->var.yres_virtual;
> +		region.height = info->var.yres;
>  		info->fbops->fb_fillrect(info, &region);
>  	}
>  

