From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 16 Oct 2015 09:36:59 +0000
Subject: Re: [PATCH v2] pwm-backlight: fix the panel power sequence
Message-Id: <1444988219.3541.3.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444987060-48202-1-git-send-email-yh.huang@mediatek.com>
In-Reply-To: <1444987060-48202-1-git-send-email-yh.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Am Freitag, den 16.10.2015, 17:17 +0800 schrieb YH Huang:
> In order to match the panel power sequence, disable the enable_gpio
> in the probe function. Also, reorder the code in the power_on and
> power_off function to match the timing.

Could you also have a look at the "pwm-backlight: Avoid backlight
flicker when probed from DT" patch?
I think in case of a panel left enabled by the bootloader, your patch
will disable the backlight for a short time.

best regards
Philipp

