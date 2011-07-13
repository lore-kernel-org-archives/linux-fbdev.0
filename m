From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 13 Jul 2011 08:19:03 +0000
Subject: Re: [PATCH] video: s3c2410: remove unused variable
Message-Id: <20110713081903.GF13701@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1310034037-5090-1-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1310034037-5090-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Jul 07, 2011 at 12:20:37PM +0200, Wolfram Sang wrote:
> Fixes:
> 
> drivers/video/s3c2410fb.c: In function 's3c2410fb_cpufreq_transition':
> drivers/video/s3c2410fb.c:770:24: warning: unused variable 'freqs'
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Paul Mundt <lethal@linux-sh.org>

Applied, thanks.
