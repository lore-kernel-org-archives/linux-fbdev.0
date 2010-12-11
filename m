From: Randy Dunlap <rdunlap@xenotime.net>
Date: Sat, 11 Dec 2010 22:34:54 +0000
Subject: Re: [PATCH v2 1/2] video, sm501: add OF binding to support SM501
Message-Id: <20101211143454.ccc5e296.rdunlap@xenotime.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291451028-22532-1-git-send-email-hs@denx.de>
	<1292049075-1809-1-git-send-email-hs@denx.de>
In-Reply-To: <1292049075-1809-1-git-send-email-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Heiko Schocher <hs@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org, Ben Dooks <ben@simtec.co.uk>, Vincent Sanders <vince@simtec.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org

On Sat, 11 Dec 2010 07:31:15 +0100 Heiko Schocher wrote:

> - add commandline options:
>   sm501.fb_mode:

    sm501.mode:

>     Specify resolution as "<xres>x<yres>[-<bpp>][@<refresh>]"
>   sm501.bpp:
>     Specify bit-per-pixel if not specified mode
> 
> ---
> 
>  Documentation/kernel-parameters.txt          |    7 +
>  Documentation/powerpc/dts-bindings/sm501.txt |   30 +++
>  drivers/mfd/sm501.c                          |  141 ++++++++------
>  drivers/video/sm501fb.c                      |  264 +++++++++++++++++---------
>  include/linux/sm501.h                        |    8 +
>  5 files changed, 299 insertions(+), 151 deletions(-)
>  create mode 100644 Documentation/powerpc/dts-bindings/sm501.txt
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index cdd2a6e..6341541 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -2301,6 +2301,13 @@ and is between 256 and 4096 characters. It is defined in the file
>  			merging on their own.
>  			For more information see Documentation/vm/slub.txt.
>  
> +	sm501.bpp=	SM501 Display driver:
> +			Specify bit-per-pixel if not specified mode

			Specifiy bits-per-pixel if not specified by 'mode'

> +
> +	sm501fb.mode=	SM501 Display driver:

Shouldn't that be sm501.mode ?

> +			Specify resolution as
> +			"<xres>x<yres>[-<bpp>][@<refresh>]"
> +
>  	smart2=		[HW]
>  			Format: <io1>[,<io2>[,...,<io8>]]


However, I think that these shouldn't be added to Documentation/kernel-parameters.txt
but should be added to the Documentation/fb/ sub-directory either by adding to
Documentation/fb/modedb.txt or by adding a new file Documentation/fb/sm501.txt.


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
