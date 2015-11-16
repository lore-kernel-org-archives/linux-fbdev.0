From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Date: Mon, 16 Nov 2015 14:45:17 +0000
Subject: Re: [PATCH v4 00/24] pwm: add support for atomic update
Message-Id: <3500453.9dNCEh5KzI@diego>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Boris,

Am Montag, 16. November 2015, 09:56:23 schrieb Boris Brezillon:
> Hello,
> 
> This series adds support for atomic PWM update, or IOW, the capability
> to update all the parameters of a PWM device (enabled/disabled, period,
> duty and polarity) in one go.

you already include my tested-by tags, but anyway, the series still works 
nicely on 4.4-rc1 on my veyron chromebook.


Heiko
