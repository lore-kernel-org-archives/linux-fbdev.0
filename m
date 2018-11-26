From: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 26 Nov 2018 06:57:12 +0000
Subject: Re: [PATCH] Fonts: New Terminus large console font
Message-Id: <20181126065712.GB9680@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181126034734.9423-1-amanoeladawod@gmail.com>
In-Reply-To: <20181126034734.9423-1-amanoeladawod@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nimrud <amanoeladawod@gmail.com>
Cc: akpm@linux-foundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 10:47:34PM -0500, nimrud wrote:
> This patch adds an option to compile-in a high resolution and large
> Terminus (ter16x32) bitmap console font for use with HiDPI and Retina screens.
> 
> The font was convereted from standard Terminus ter-i32b.psf (size 16x32)
> with the help of psftools and minor hand editing deleting useless characters.
> 
> This patch is non-intrusive, no options are enabled by default so most
> users won't notice a thing.
> 
> I am placing my changes under the GPL 2.0 just as source Terminus font.
> 
> Signed-off-by: Amanoel Dawod <amanoeladawod@gmail.com>

Also, your "From:" line on your email does not match this name, so that
needs to be fixed before we could take the patch :(

thanks,

greg k-h
