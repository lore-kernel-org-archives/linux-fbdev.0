From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 03 Jan 2020 11:51:46 +0000
Subject: Re: [PATCH v3 1/3] fbdev: fix numbering of fbcon options
Message-Id: <209fe07a-96d7-98db-7c3b-81a932291bd9@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190827110854.12574-1-peda@axentia.se>
 <CGME20190827110923epcas1p1ef1052284e2b565746491c0d63a39c1b@epcas1p1.samsung.com>
 <20190827110854.12574-2-peda@axentia.se>
In-Reply-To: <20190827110854.12574-2-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Rosin <peda@axentia.se>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>


On 8/27/19 1:09 PM, Peter Rosin wrote:
> Three shall be the number thou shalt count, and the number of the
> counting shall be three. Four shalt thou not count...
> 
> One! Two! Five!
> 
> Fixes: efb985f6b265 ("[PATCH] fbcon: Console Rotation - Add framebuffer console documentation")
> Signed-off-by: Peter Rosin <peda@axentia.se>

Thanks, patch queued for v5.6 (also sorry for the delay).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  Documentation/fb/fbcon.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
> index ebca41785abe..65ba40255137 100644
> --- a/Documentation/fb/fbcon.rst
> +++ b/Documentation/fb/fbcon.rst
> @@ -127,7 +127,7 @@ C. Boot options
>  	is typically located on the same video card.  Thus, the consoles that
>  	are controlled by the VGA console will be garbled.
>  
> -4. fbcon=rotate:<n>
> +5. fbcon=rotate:<n>
>  
>  	This option changes the orientation angle of the console display. The
>  	value 'n' accepts the following:
> @@ -152,21 +152,21 @@ C. Boot options
>  	Actually, the underlying fb driver is totally ignorant of console
>  	rotation.
>  
> -5. fbcon=margin:<color>
> +6. fbcon=margin:<color>
>  
>  	This option specifies the color of the margins. The margins are the
>  	leftover area at the right and the bottom of the screen that are not
>  	used by text. By default, this area will be black. The 'color' value
>  	is an integer number that depends on the framebuffer driver being used.
>  
> -6. fbcon=nodefer
> +7. fbcon=nodefer
>  
>  	If the kernel is compiled with deferred fbcon takeover support, normally
>  	the framebuffer contents, left in place by the firmware/bootloader, will
>  	be preserved until there actually is some text is output to the console.
>  	This option causes fbcon to bind immediately to the fbdev device.
>  
> -7. fbcon=logo-pos:<location>
> +8. fbcon=logo-pos:<location>
>  
>  	The only possible 'location' is 'center' (without quotes), and when
>  	given, the bootup logo is moved from the default top-left corner
