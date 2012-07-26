From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 26 Jul 2012 17:14:33 +0000
Subject: Re: [GIT PULL] SH Mobile LCDC and MERAM patches
Message-Id: <50117AF9.4050002@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2980452.38e8VA4mF5@avalon>
In-Reply-To: <2980452.38e8VA4mF5@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Laurent,

On 07/24/2012 09:16 AM, Laurent Pinchart wrote:
> Hi Florian,
> 
> The following changes since commit 6fcdbc0c3a683003a00f383fceac80da1b7852ff:
> 
>   s3fb: Add Virge/MX (86C260) (2012-07-08 14:03:50 +0000)
> 
> are available in the git repository at:
>   git://linuxtv.org/pinchartl/fbdev.git for-next

Merged. Should I also apply your followup patch
"[PATCH] fbdev: sh_mobile_lcdc: Fix vertical panning step"
?


Best regards,

Florian Tobias Schandinat

> 
> Laurent Pinchart (9):
>       sh_mobile_meram: Rename operations to cache_[alloc|free|update]
>       sh_mobile_meram: Use direct function calls for the public API
>       sh_mobile_meram: Add direct MERAM allocation API
>       fbdev: sh_mobile_lcdc: Destroy mutex at remove time
>       fbdev: sh_mobile_lcdc: Fix line pitch computation
>       fbdev: sh_mobile_lcdc: Use channel configuration to initialize fb device
>       fbdev: sh_mobile_lcdc: Support horizontal panning
>       fbdev: sh_mobile_lcdc: Fix overlay registers update during pan operation
>       fbdev: sh_mobile_lcdc: Fix pan offset computation in YUV mode
> 
>  drivers/video/sh_mobile_lcdcfb.c |  209 +++++++++++++++++----------------
>  drivers/video/sh_mobile_lcdcfb.h |    5 +-
>  drivers/video/sh_mobile_meram.c  |  235 ++++++++++++++++++++-----------------
>  include/video/sh_mobile_meram.h  |   71 ++++++++----
>  4 files changed, 293 insertions(+), 227 deletions(-)
> 

