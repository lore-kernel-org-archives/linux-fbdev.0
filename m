From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 10 Feb 2016 13:58:55 +0000
Subject: Re: [PATCH] video: ARM CLCD: Added dt support to set tim2 register
Message-Id: <CACRpkdZZBQUc4oPTPb+67C9A2r7qRV3zXRC7uusvDpNnM=i1eg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424898082-1522-1-git-send-email-arun.ramamurthy@broadcom.com>
In-Reply-To: <1424898082-1522-1-git-send-email-arun.ramamurthy@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Jonathan Richardson <jonathar@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>

On Wed, Feb 25, 2015 at 10:01 PM, Arun Ramamurthy
<arun.ramamurthy@broadcom.com> wrote:

> Added code based on linaro tree:
> http://git.linaro.org/kernel/linux-linaro-stable.git
> with commit id:6846e7822c4cab5a84672baace3b768c2d0db142
> at drivers/video/amba-clcd.c. This lets the driver set
> certain tim2 register bits after reading them from
> device tree.
>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>

I have now implemented this properly in this patch:
http://marc.info/?l=linux-fbdev&m5459469913983&w=2

Please provide your Tested-by/Reviewed-by/Ack if you're
still working on this.

Yours,
Linus Walleij
