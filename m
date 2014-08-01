From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Fri, 01 Aug 2014 18:27:03 +0000
Subject: Re: [PATCH] video: amba-clcd: Select FB_MODE_HELPERS
Message-Id: <20140801182703.GU30282@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1406908430-18487-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1406908430-18487-1-git-send-email-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Aug 01, 2014 at 04:53:50PM +0100, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> The AMBA CLCD driver uses fb_videomode_from_videomode() so it needs to
> select DB_MODE_HELPERS as well as VIDEOMODE_HELPERS.

It doesn't, not as I designed it at least.  It depends what other people
have done to my driver...

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
