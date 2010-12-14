From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 14 Dec 2010 09:05:08 +0000
Subject: Re: [PATCH] fbdev: Fix fb_find_nearest_mode refresh comparison
Message-Id: <20101214090507.GB14606@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1292019888.2896.17.camel@kephart>
In-Reply-To: <1292019888.2896.17.camel@kephart>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Dec 13, 2010 at 09:46:34AM -0600, Andrew Kephart wrote:
> Refresh rate nearness is not calculated or reset when nearest resolution
> changes.
> 
> This patch resets the refresh rate differential measurement whenever a
> new nearest resolution is discovered.  This fixes two error cases;
> first, wherein the first mode's refresh rate differential is never
> calculated and second, when the closest refresh rate from a previous
> nearest resolution is erroneously preserved.
> 
> Signed-off-by: Andrew Kephart <andrew.kephart@alereon.com>

The patch itself is line-wrapped, so please check your mailer settings
for future patches. I've applied it by hand this time, thanks.
