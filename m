From: Milo Kim <milo.kim@ti.com>
Date: Thu, 24 Apr 2014 22:43:51 +0000
Subject: Re: [PATCH 12/13] video/backlight: LP855X needs PWM
Message-Id: <535993A7.3060504@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398342509-10243-1-git-send-email-peter.griffin@linaro.org> <1398342509-10243-13-git-send-email-peter.griffin@linaro.org>
In-Reply-To: <1398342509-10243-13-git-send-email-peter.griffin@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

On 04/24/2014 09:28 PM, Peter Griffin wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The LP855X driver cannot be successfully built if we don't
> enable the PWM subsystem. This patch makes that dependency
> explicit in Kconfig and prevents broken randconfig builds.
>

Thanks!

Acked-by: Milo Kim <milo.kim@ti.com>


