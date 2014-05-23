From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 23 May 2014 13:48:43 +0000
Subject: Re: [PATCH v2 1/3] video: clps711x: Add new Cirrus Logic CLPS711X framebuffer driver
Message-Id: <6345733.X7CKDAOT61@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Friday 23 May 2014 17:13:58 Alexander Shiyan wrote:
> If there will be two drivers, I will do the following: remove the non-DT
> support (for new driver) and will create a patch for 3.16 (this patch will
> no affect to arm-soc).
> After that, I will do optional multiplatform support for this CPU and move
> the boards, which do not use FB.
> After this architecture will be ready to add DT support, and after all boards
> will be converted, I'll remove the old version of the driver.
> 
> OK?
> 

Sounds good to me.

	Arnd
