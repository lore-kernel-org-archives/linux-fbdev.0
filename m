From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 31 Mar 2019 19:01:18 +0000
Subject: Re: [PATCH v2 6/7] fbdev: sm712fb: Kconfig: add information about docs.
Message-Id: <20190331190118.3kaf7erdbk25yd5n@debian>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190322051759.15007-1-tomli@tomli.me>
 <20190322051759.15007-7-tomli@tomli.me>
In-Reply-To: <20190322051759.15007-7-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yifeng Li <tomli@tomli.me>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Fri, Mar 22, 2019 at 01:17:58PM +0800, Yifeng Li wrote:
> This commits update the Kconfig description of sm712fb,
> and inform the user about the existence of documentation.
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> ---
>  Documentation/fb/sm712fb.txt | 44 ++++++++++++++++++++----------------
>  drivers/video/fbdev/Kconfig  |  4 ++++
>  2 files changed, 29 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/fb/sm712fb.txt b/Documentation/fb/sm712fb.txt
> index 906b48aa40e4..c9a8fe059ac7 100644
> --- a/Documentation/fb/sm712fb.txt
> +++ b/Documentation/fb/sm712fb.txt
> @@ -18,9 +18,10 @@ and it was also an inexpensive platform for non-x86 hobbyists to explore.
>  How to use it?
>  =======
>  
> -You should not compile-in vesafb, since SM7xx can be used in a VGA
> -compatible mode, resulting conflicts with this driver. In addition,
> -the VGA compatible mode was never tested by the maintainers.
> +SM7xx can be used in a VGA compatible mode and a native framebuffer mode,
> +this driver is a native driver. By default, it has no problem taking over
> +the VGA driver automatically, but you should not attempt to use both at
> +the same time.

You added this in the documentation with just the previous patch.

>  

<snip>

>  
>  2D acceleration
>  =======
> @@ -97,7 +103,7 @@ Missing Features
>  
>  The following features are not implemented in this driver,
>  
> -	* 2D acceleration on SM720 and Big-Endian CPUs.
> +	* 2D acceleration on Big-Endian CPUs.
>  	* More VGA modes.
>  	* dual-head support
>  	* hardware cursor support

You might want to squash the two patches for documentation instead of
having a separate patch to fix what you added in a previous patch.

--
Regards
Sudip
