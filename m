From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 24 Jun 2011 08:09:05 +0000
Subject: Re: [PATCH] This patch fixes a problem where a DisplayLink device autoselects a suboptimal framebuff
Message-Id: <20110624080905.GD24184@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308834989-28712-1-git-send-email-william.katsak@alcatel-lucent.com>
In-Reply-To: <1308834989-28712-1-git-send-email-william.katsak@alcatel-lucent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Jun 23, 2011 at 09:16:29AM -0400, William Katsak wrote:
> The situation in which the problem occurred was with a Plugable UGA-2K-A
> connected to a Samsung EX2220X display. The driver indicates that
> 1920x1080 is a valid mode (the first mode available, in fact), but
> proceeds to set the framebuffer size to 1600x1200.
> 
> The patch corrects what seems to be a logic error, regarding unsetting
> the FB_MISC_1ST_DETAIL flag, if the first (top/best) mode is invalid.
> The existing code unset the flag if ANY mode was invalid.
> 
> Signed-off-by: William Katsak <william.katsak@alcatel-lucent.com>

Applied, thanks.
