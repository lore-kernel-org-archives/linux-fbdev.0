From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 11 Dec 2010 01:59:48 +0000
Subject: Re: [PATCH] fbdev: Fix fb_find_nearest_mode refresh comparison
Message-Id: <20101211015948.GD3750@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1292019888.2896.17.camel@kephart>
In-Reply-To: <1292019888.2896.17.camel@kephart>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Dec 10, 2010 at 04:24:48PM -0600, Andrew Kephart wrote:
> Refresh rate nearness is not calculated or reset when nearest resolution
> changes.
> 
> This patch resets the refresh rate differential measurement whenever a
> new nearest resolution is discovered.  This fixes two error cases;
> first, wherein the first mode's refresh rate differential is never
> calculated and second, when the closest refresh rate from a previous
> nearest resolution is erroneously preserved.
> 
You're missing a signed-off-by tag.
