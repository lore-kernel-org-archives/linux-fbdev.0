From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 06 Jan 2011 07:26:58 +0000
Subject: Re: [PATCH 4/9] fb: export fb mode db table
Message-Id: <20110106072658.GB15914@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
	<1291902441-24712-5-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1291902441-24712-5-git-send-email-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Dec 09, 2010 at 02:47:16PM +0100, Sascha Hauer wrote:
> The different modes can be useful for drivers. Currently there is
> no way to expose the modes to sysfs, so export them.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

I'll admit I don't really like the idea of exposing the modedb to drivers
in this way, but given that we're already doing it for the vesa and cea
modes, allowing drivers to copy ranges in to their modelist from the
standard db is probably something we can live with.

The mode list dumping is basically a blatant sysfs abuse already though,
and it would be much cleaner simply to back the mode store with an
fb_find/try_mode() pair that grovels all the right places in addition to
doing a pass over the fb_info's modelist.
