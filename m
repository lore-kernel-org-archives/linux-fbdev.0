From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 14 Mar 2013 13:58:05 +0000
Subject: Re: [PATCH 10/10] drivers: misc: use module_platform_driver_probe()
Message-Id: <201303141358.05616.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363266691-15757-1-git-send-email-fabio.porcedda@gmail.com>
 <1363266691-15757-12-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1363266691-15757-12-git-send-email-fabio.porcedda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday 14 March 2013, Fabio Porcedda wrote:
> This patch converts the drivers to use the
> module_platform_driver_probe() macro which makes the code smaller and
> a bit simpler.
> 
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/misc/atmel_pwm.c  | 12 +-----------
>  drivers/misc/ep93xx_pwm.c | 13 +------------
>  2 files changed, 2 insertions(+), 23 deletions(-)

The patch itself seems fine, but there are two issues around it:

* The PWM drivers should really get moved to drivers/pwm and converted to the new
  PWM subsystem. I don't know if Hartley or Hans-Christian have plans to do
  that already.

* Regarding the use of module_platform_driver_probe, I'm a little worried about
  the interactions with deferred probing. I don't think there are any regressions,
  but we should probably make people aware that one cannot return -EPROBE_DEFER
  from a platform_driver_probe function.

	Arnd
