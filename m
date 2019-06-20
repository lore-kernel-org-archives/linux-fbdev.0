From: Jonathan Corbet <corbet@lwn.net>
Date: Thu, 20 Jun 2019 19:55:44 +0000
Subject: Re: [PATCH] docs: fb: Add TER16x32 to the available font names
Message-Id: <20190620135544.4a56b62a@lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190619053943.6320-1-tiwai@suse.de>
In-Reply-To: <20190619053943.6320-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Randy Dunlap <rdunlap@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 19 Jun 2019 07:39:43 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> The new font is available since recently.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
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

Applied, thanks.

jon
