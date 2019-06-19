From: Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 19 Jun 2019 15:25:48 +0000
Subject: Re: [PATCH] docs: fb: Add TER16x32 to the available font names
Message-Id: <0bfb2789-158c-5e78-1621-2aaefea08d80@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190619053943.6320-1-tiwai@suse.de>
In-Reply-To: <20190619053943.6320-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>, Jonathan Corbet <corbet@lwn.net>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 6/18/19 10:39 PM, Takashi Iwai wrote:
> The new font is available since recently.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/fb/fbcon.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
> index cfb9f7c38f18..1da65b9000de 100644
> --- a/Documentation/fb/fbcon.rst
> +++ b/Documentation/fb/fbcon.rst
> @@ -82,7 +82,7 @@ C. Boot options
>  
>  	Select the initial font to use. The value 'name' can be any of the
>  	compiled-in fonts: 10x18, 6x10, 7x14, Acorn8x8, MINI4x6,
> -	PEARL8x8, ProFont6x11, SUN12x22, SUN8x16, VGA8x16, VGA8x8.
> +	PEARL8x8, ProFont6x11, SUN12x22, SUN8x16, TER16x32, VGA8x16, VGA8x8.
>  
>  	Note, not all drivers can handle font with widths not divisible by 8,
>  	such as vga16fb.
> 


-- 
~Randy
