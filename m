From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 24 May 2011 06:38:05 +0000
Subject: Re: [GIT PULL] OMAP DSS updates for 2.6.40
Message-Id: <20110524063803.GC11986@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1306151004.1871.36.camel@deskari>
In-Reply-To: <1306151004.1871.36.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: lo-ml <linux-omap@vger.kernel.org>, lfbdev-ml <linux-fbdev@vger.kernel.org>

On Mon, May 23, 2011 at 02:43:24PM +0300, Tomi Valkeinen wrote:
> Here are the OMAP Display Subsystem updates for 2.6.40.
> 
> Most of the patches are OMAP4 related, either fixing the old code to
> allow us to implement new OMAP4 features, or implementing those new
> features. Other bigger changes are ULPS power management feature and
> moving the DSS header file from arch/arm/plat-omap/include to
> include/video.
> 
Pulled and pushed out, thanks. There were a couple of conflicts, so you
may want to doublecheck to make sure nothing was inadvertently broken.
