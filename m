From: Jacek Anaszewski <j.anaszewski@samsung.com>
Date: Mon, 07 Sep 2015 14:10:14 +0000
Subject: Re: [PATCH 1/3] leds: Add of_led_get() and led_put()
Message-Id: <55ED9AC6.3020505@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440502442-19531-1-git-send-email-tomi.valkeinen@ti.com>
 <1440502442-19531-2-git-send-email-tomi.valkeinen@ti.com>
 <55DC6CB9.5060301@samsung.com> <55ED8E99.9060004@ti.com>
In-Reply-To: <55ED8E99.9060004@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

On 09/07/2015 03:18 PM, Tomi Valkeinen wrote:
> Hi,
>
> On 25/08/15 16:25, Jacek Anaszewski wrote:
>> Hi Tomi,
>>
>> Thanks for the patch. Generally, I'd prefer to add files
>> drivers/leds/of.c and include/linux/of_leds.h and put related functions
>> there. Those functions' names should begin with "of_". Please provide
>
> So I presume leds/of.c should be linked together with led-class.c.
> Afaics, that means I need to either rename the resulting led-class.ko or
> led-class.c, so that I can do it in the Makefile. Any preferences?

Let's rename led-class.ko to led-class-objs.ko.

> Alternatively I could create a led-of.ko, but that doesn't feel right.


-- 
Best Regards,
Jacek Anaszewski
