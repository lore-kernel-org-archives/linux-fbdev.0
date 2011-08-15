From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Mon, 15 Aug 2011 13:06:22 +0000
Subject: Re: [PATCH] backlight: Fix broken regulator API usage in l4f00242t03
Message-Id: <20110815130619.GB3927@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1313372500-28017-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20110815064242.GR31404@pengutronix.de>
In-Reply-To: <20110815064242.GR31404@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Aug 15, 2011 at 08:42:42AM +0200, Sascha Hauer wrote:

> Maybe you could change these pr_err to dev_err on the way. The rest of
> the driver already uses dev_*.

Minimal diff and all that...
