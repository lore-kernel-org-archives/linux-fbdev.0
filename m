From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 05 Dec 2018 11:02:04 +0000
Subject: Re: [PATCH] Fonts: New Terminus large console font
Message-Id: <20181205110204.GA17143@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181126092115.754-1-amanoeladawod@gmail.com>
In-Reply-To: <20181126092115.754-1-amanoeladawod@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Amanoel Dawod <amanoeladawod@gmail.com>
Cc: akpm@linux-foundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 04:21:15AM -0500, Amanoel Dawod wrote:
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

Can you please run scripts/checkpatch.pl and fix up the issues that it
finds in this patch.  It's a lot:
	total: 1792 errors, 2058 warnings, 2127 lines checked

thanks,

greg k-h
