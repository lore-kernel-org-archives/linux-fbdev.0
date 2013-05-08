From: Tomi Valkeinen <tomi.valkeinen@iki.fi>
Date: Wed, 08 May 2013 06:57:24 +0000
Subject: Re: [PATCH 0/4] drivers: video: Optimisations for the ssd1307fb driver
Message-Id: <5189F754.1030402@iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366624945-5708-1-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1366624945-5708-1-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 22/04/13 13:02, Maxime Ripard wrote:
> Hi everyone,
> 
> This is a patchset to improve significantly (by an order of magnitude)
> the refreshing time of the SSD1306 and SSD1307.
> 
> We do so by sending the pixels by batches, instead of 8 at a time,
> combined with some additionnal features found on these controllers
> that allows to send a whole screen content at once.
> 
> This obviously removes the tearing effect that was previously seen
> with these controllers.
> 
> This patchset depends on the "Add support for the Solomon SSD1306 OLED
> Controller" I sent previously.
> 
> Thanks,
> Maxime
> 
> Maxime Ripard (4):
>   ARM: cfa10036: dt: Change i2c0 clock frequency
>   ssd1307fb: Rework the communication functions
>   ssd1307fb: Speed up the communication with the controller
>   ssd1307fb: Make use of horizontal addressing mode
> 
>  arch/arm/boot/dts/imx28-cfa10036.dts |    1 +
>  drivers/video/ssd1307fb.c            |  123 ++++++++++++++++++++++++----------
>  2 files changed, 89 insertions(+), 35 deletions(-)
> 

I've taken the patches 2-4 into fbdev 3.11 branch. The first patch "ARM:
cfa10036: dt: Change i2c0 clock frequency" should preferably go through
arch tree.

 Tomi

