From: Milo Kim <milo.kim@ti.com>
Date: Thu, 24 Apr 2014 22:42:56 +0000
Subject: Re: [PATCH 09/13] video/backlight: LP8788 needs PWM
Message-Id: <53599370.1070507@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398342509-10243-1-git-send-email-peter.griffin@linaro.org> <1398342509-10243-10-git-send-email-peter.griffin@linaro.org>
In-Reply-To: <1398342509-10243-10-git-send-email-peter.griffin@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

On 04/24/2014 09:28 PM, Peter Griffin wrote:
> The LP8788 driver cannot be successfully built if we don't
> enable the PWM subsystem. This patch makes that dependency
> explicit in Kconfig and prevents broken randconfig builds.
>
> Based on Arnd Bergmann patch but split out into seperate
> commits per driver based on feedback.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Thanks!

Acked-by: Milo Kim <milo.kim@ti.com>


