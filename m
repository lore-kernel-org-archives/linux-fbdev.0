From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Date: Mon, 21 Sep 2015 22:30:37 +0000
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Message-Id: <5055506.IbQp3pDAJn@diego>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Boris,

Am Montag, 21. September 2015, 11:33:17 schrieb Boris Brezillon:
> This series adds support for atomic PWM update, or IOW, the capability
> to update all the parameters of a PWM device (enabled/disabled, period,
> duty and polarity) in one go.

I gave this v3 a spin on a rk3288-veyron device with the pwm-regulator 
supplying vdd_logic. Looks really nice and runs fine, so the series

Tested-by: Heiko Stuebner <heiko@sntech.de>
