From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 11 Mar 2013 23:50:18 +0000
Subject: Re: [PATCH] backlight: fix typo "MACH_SAM9...EK" three times
Message-Id: <008b01ce1eb3$2f8bbf70$8ea33e50$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363034823.3137.110.camel@x61.thuisdomein>
In-Reply-To: <1363034823.3137.110.camel@x61.thuisdomein>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Paul Bolle' <pebolle@tiscali.nl>, 'Andrew Morton' <akpm@linux-foundation.org>
Cc: 'Richard Purdie' <rpurdie@rpsys.net>, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, March 12, 2013 5:47 AM, Paul Bolle wrote:
> 
> Fix three typos (originally) introduced by commit
> a9a84c37d1ee50db8f3752b117caf2b48dcd4f8a ("atmel_lcdfb: backlight
> control").
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

CC'ed Andrew Morton.

It looks good.

Acked-by: Jingoo Han <jg1.han@samsung.com>


Best regards,
Jingoo Han


> ---
> 0) Tested by grepping the tree.
> 
> 1) So two of these typos were introduced in v2.6.25. (The third was
> introduced in commit 915190f7d4f08e413e5fde6b0abcd5375aeacdf4 ("[ARM]
> 5614/1: at91: atmel_lcdfb: add at91sam9g10 support to atmel LCD
> driver")). Checking these commits reveals that the default value of 'y'
> has never been set automatically in all releases since v2.6.25! Perhaps
> this line might as well be dropped.
> 
>  drivers/video/backlight/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index db10d01..a4481df 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -161,7 +161,7 @@ if BACKLIGHT_CLASS_DEVICE
>  config BACKLIGHT_ATMEL_LCDC
>  	bool "Atmel LCDC Contrast-as-Backlight control"
>  	depends on FB_ATMEL
> -	default y if MACH_SAM9261EK || MACH_SAM9G10EK || MACH_SAM9263EK
> +	default y if MACH_AT91SAM9261EK || MACH_AT91SAM9G10EK || MACH_AT91SAM9263EK
>  	help
>  	  This provides a backlight control internal to the Atmel LCDC
>  	  driver.  If the LCD "contrast control" on your board is wired
> --
> 1.7.11.7
> 


