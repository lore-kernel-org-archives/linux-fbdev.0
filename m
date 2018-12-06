From: Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 06 Dec 2018 00:42:03 +0000
Subject: Re: [PATCH v2] Fonts: New Terminus large console font
Message-Id: <ccfa900f-114a-0a4d-1d20-22f8d390ce84@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181205110204.GA17143@kroah.com>
 <20181205235637.1079-1-amanoeladawod@gmail.com>
In-Reply-To: <20181205235637.1079-1-amanoeladawod@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Amanoel Dawod <amanoeladawod@gmail.com>
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On 12/5/18 3:56 PM, Amanoel Dawod wrote:
> This patch adds an option to compile-in a high resolution
> and large Terminus (ter16x32) bitmap console font for use with
> HiDPI and Retina screens.
> 
> The font was convereted from standard Terminus ter-i32b.psf

               converted

Where does "ter-i32b.psf" come from?
I.e., where can I find it?

> (size 16x32) with the help of psftools and minor hand editing
> deleting useless characters.
> 
> This patch is non-intrusive, no options are enabled by default so most
> users won't notice a thing.
> 
> I am placing my changes under the GPL 2.0 just as source Terminus font.
> 
> Signed-off-by: Amanoel Dawod <amanoeladawod@gmail.com>
> ---


> +const struct font_desc font_ter_16x32 = {
> +	.idx	= TER16x32_IDX,
> +	.name	= "TER16x32",
> +	.width	= 16,
> +	.height = 32,
> +	.data	= fontdata_ter16x32,

Please update Documentation/fb/fbcon.txt with the addition of that font name
if that is applicable.

thanks,
-- 
~Randy
