From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 16 Nov 2010 01:14:52 +0000
Subject: Re: [PATCH] fbdev: sh_mobile_lcdcfb: fix bug in reconfig()
Message-Id: <20101116011452.GB28879@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1289857402-27180-1-git-send-email-arnd@arndnet.de>
In-Reply-To: <1289857402-27180-1-git-send-email-arnd@arndnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Nov 15, 2010 at 10:43:22PM +0100, Arnd Hannemann wrote:
> The function sh_mobile_fb_reconfig() contained a bug,
> which caused the line_length to be set wrongly, if a mode
> with a different X-resolution than the default one was chosen.
> This caused 1080p24 mode to not work on AP4EVB.
> Additionally the notifier chain was also called with the wrong 
> mode.
> 
> This patch fixes this, by using the X-resolution of the new
> mode instead of the old one to calculate line length and
> hands over the correct mode to the notifier chain.
> 
> Signed-off-by: Arnd Hannemann <arnd@arndnet.de>

Applied, thanks.
