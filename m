From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 13 May 2012 20:36:29 +0000
Subject: Re: [PULL for v3.5] SH Mobile LCDC overlay support
Message-Id: <4FB01B4D.4060700@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5022250.LOHRC1DPLO@avalon>
In-Reply-To: <5022250.LOHRC1DPLO@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Laurent,

On 04/24/2012 11:31 AM, Laurent Pinchart wrote:
> Hi Florian,
> 
> Could you please pull the following patches that add overlay support for the 
> SH Mobile LCDC ? They have been posted for review as part of a bigger series 
> some time ago.

Well, besides that I dislike everyone inventing his/her own overlay API
and just not having time to propose something that fits everyone your
patch looks mostly okay. Two things:

"That's fine, but you need a Documentation/ABI entry for any new sysfs
file you create." [Greg K-H]
So as far as I understand Gregs statement and your code correct you
should add such thing.

I'm not convinced that you don't leak resources. Is the memory you
allocate with dma_alloc_coherent for the overlays really freed after
normal use and in error paths?


Best regards,

Florian Tobias Schandinat

> 
> The following changes since commit d313a86d2efb2c5568832389663322e93e291c59:
> 
>   i.MX28: Shut down the LCD controller to avoid BootROM sampling bug 
> (2012-04-21 21:53:12 +0000)
> 
> are available in the git repository at:
>   git://linuxtv.org/pinchartl/fbdev.git planes
> 
> Laurent Pinchart (3):
>       fbdev: sh_mobile_lcdc: Constify sh_mobile_lcdc_fix structure
>       fbdev: sh_mobile_lcdc: Rename fb operation handlers with a common prefix
>       fbdev: sh_mobile_lcdc: Implement overlays support
> 
>  drivers/video/sh_mobile_lcdcfb.c | 1004 +++++++++++++++++++++++++++++++++----
>  include/video/sh_mobile_lcdc.h   |    7 +
>  2 files changed, 915 insertions(+), 96 deletions(-)
> 

