From: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Subject: Re: [RFC 2.6.27 1/1] gpiolib: add support for batch set of pins
Date: Wed, 26 Nov 2008 11:09:49 +0200
Message-ID: <492D125D.5010607@teltonika.lt>
References: <12276535632759-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <12276535632759-git-send-email-jayakumar.lkml@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>, David Brownell <david-b@pacbell.net>, Sam Ravnborg <sam@ravnborg.org>, Jean Delvare <khali@linux-fr.org>, Eric Miao <eric.miao@marvell.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <rmk@arm.linux.org.uk>, Ben Gardner <bgardner@wabtec.com>, Greg KH <greg@kroah.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Jaya Kumar wrote:
> Beloved friends,
> 
> I would like to request your feedback on the following idea. I hope I have
> made sure to CC all the right people and the right lists! If not, PLEASE
> let me know! I couldn't find a MAINTAINERS entry for gpiolib so I just
> used what I saw in the git log and have also added people and lists that
> I think may be interested.
> 
> This is just an RFC. If you all feel it is looking like the right approach
> then I'll clean it up and make it a patch.
> 
> Thanks,
> jaya
> 
> am300epd was doing 800*600*16*gpio_set_value for each framebuffer transfer
> (it uses 16-pins of gpio as its data bus). I found this caused a wee
> performance limitation. This patch adds an API for gpio_set_value_bus
> which allows users to set batches of consecutive gpio together in a single
> call. I have done a test implementation on gumstix (pxa255) with am300epd
> and it provides a nice improvement in performance.
> 
> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
> Cc: David Brownell <dbrownell@users.sourceforge.net>
> Cc: David Brownell <david-b@pacbell.net>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Jean Delvare <khali@linux-fr.org>
> Cc: Eric Miao <eric.miao@marvell.com>
> Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
> Cc: Philipp Zabel <philipp.zabel@gmail.com>
> Cc: Russell King <rmk@arm.linux.org.uk>
> Cc: Ben Gardner <bgardner@wabtec.com>
> CC: Greg KH <greg@kroah.com>
> Cc: linux-arm-kernel@lists.arm.linux.org.uk
> Cc: linux-fbdev-devel@lists.sourceforge.net
> Cc: linux-kernel@vger.kernel.org
> 
> ---
>  arch/arm/mach-pxa/am300epd.c          |    9 ++++++
>  arch/arm/mach-pxa/gpio.c              |   28 +++++++++++++++++++++
>  arch/arm/mach-pxa/include/mach/gpio.h |   24 ++++++++++++++++++
>  drivers/gpio/gpiolib.c                |   44 +++++++++++++++++++++++++++++++++
>  include/asm-generic/gpio.h            |    6 ++++
>  5 files changed, 111 insertions(+), 0 deletions(-)
> 

[...]

> diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
> index 81797ec..9747517 100644
> --- a/include/asm-generic/gpio.h
> +++ b/include/asm-generic/gpio.h
> @@ -44,6 +44,8 @@ struct module;
>   *	returns either the value actually sensed, or zero
>   * @direction_output: configures signal "offset" as output, or returns error
>   * @set: assigns output value for signal "offset"
> + * @set_bus: batch assigns output values for consecutive signals starting at
> + *	"offset" with width in bits "bitwidth"
>   * @to_irq: optional hook supporting non-static gpio_to_irq() mappings;
>   *	implementation may not sleep
>   * @dbg_show: optional routine to show contents in debugfs; default code
> @@ -84,6 +86,9 @@ struct gpio_chip {
>  						unsigned offset, int value);
>  	void			(*set)(struct gpio_chip *chip,
>  						unsigned offset, int value);
> +	void			(*set_bus)(struct gpio_chip *chip,
> +						unsigned offset, int values,

I think values should be unsigned

> +						int bitwidth);
>  
>  	int			(*to_irq)(struct gpio_chip *chip,
>  						unsigned offset);
> @@ -124,6 +129,7 @@ extern void gpio_set_value_cansleep(unsigned gpio, int value);
>   */
>  extern int __gpio_get_value(unsigned gpio);
>  extern void __gpio_set_value(unsigned gpio, int value);
> +extern void __gpio_set_value_bus(unsigned gpio, int values, int bitwidth);
>  
>  extern int __gpio_cansleep(unsigned gpio);
>  

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
