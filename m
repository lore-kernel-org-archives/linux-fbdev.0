From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 02 Jun 2011 08:15:04 +0000
Subject: Re: [PATCH] savagefb: Use panel CVT mode as default
Message-Id: <20110602081504.GG6087@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sat, May 28, 2011 at 05:06:11PM +0200, Tormod Volden wrote:
> From: Tormod Volden <debian.tormod@gmail.com>
> 
> If there is no EDID but an LCD panel is detected, generate a CVT
> mode from the panel resolution (at 60 Hz), and use this as a
> default mode instead of the hardcoded 800x600x8 mode.
> 
> Signed-off-by: Tormod Volden <debian.tormod@gmail.com>
> 
Applied, thanks.
