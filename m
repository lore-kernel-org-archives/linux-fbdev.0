From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 02 Jun 2011 08:13:26 +0000
Subject: Re: [PATCH] fbdev: bf537-lq035: add missing blacklight properties type
Message-Id: <20110602081326.GF6087@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sun, May 29, 2011 at 11:23:36PM -0400, Mike Frysinger wrote:
> From: Steven Miao <realmz6@gmail.com>
> 
> Seems this new field was missed, probably due to this driver being merged
> around the time this new backlight field was being added.  At any rate,
> initial the type field to avoid ugly WARN() dumps.
> 
> Signed-off-by: Steven Miao <realmz6@gmail.com>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

Applied, thanks.
