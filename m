From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: Re: [RFC 2.6.27 2/2] mach-pxa: add AM300
	platform driver
Date: Tue, 23 Dec 2008 16:47:08 +0800
Message-ID: <f17812d70812230047g54cae195g8cf6297783d2602c@mail.gmail.com>
References: <12298571881580-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <eric.y.miao@gmail.com>) id 1LF2v3-00085B-GB
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 23 Dec 2008 08:47:13 +0000
Received: from rv-out-0708.google.com ([209.85.198.242])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LF2v2-0000Fn-8v for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 23 Dec 2008 08:47:13 +0000
Received: by rv-out-0708.google.com with SMTP id f25so2221700rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 23 Dec 2008 00:47:08 -0800 (PST)
In-Reply-To: <12298571881580-git-send-email-jayakumar.lkml@gmail.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: Eric Miao <eric.miao@marvell.com>, linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>, linux-arm-kernel@lists.arm.linux.org.uk

On Sun, Dec 21, 2008 at 6:59 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> This patch adds support for the AM300 platform driver.
>

Patch looks good, I feel I'm nit-picking. Anyway , see my comments below:

> +/* register offsets for gpio control */
> +#define PWR_GPIO_PIN 16
> +#define CFG_GPIO_PIN 17
> +#define RDY_GPIO_PIN 32
> +#define DC_GPIO_PIN 48
> +#define RST_GPIO_PIN 49
> +#define LED_GPIO_PIN 51
> +#define RD_GPIO_PIN 74
> +#define WR_GPIO_PIN 75
> +#define CS_GPIO_PIN 76
> +#define IRQ_GPIO_PIN 77
> +
> +/* hdb bus */
> +#define DB0_GPIO_PIN 58
> +#define DB15_GPIO_PIN 73

indentation?

> +
> +static int gpios[] = { PWR_GPIO_PIN, CFG_GPIO_PIN, RDY_GPIO_PIN, DC_GPIO_PIN,
> +                       RST_GPIO_PIN, RD_GPIO_PIN, WR_GPIO_PIN, CS_GPIO_PIN,
> +                       IRQ_GPIO_PIN, LED_GPIO_PIN };
> +static char *gpio_names[] = { "PWR", "CFG", "RDY", "DC", "RST", "RD", "WR",
> +                               "CS", "IRQ", "LED" };
> +
> +static int am300_wait_for_rdy(struct broadsheetfb_par *par)
> +{
> +       unsigned long flags;
> +       DEFINE_WAIT(wait);
> +
> +       spin_lock_irqsave(par->lock, flags);
> +       while (!gpio_get_value(RDY_GPIO_PIN)) {
> +               prepare_to_wait(&par->waitq, &wait, TASK_INTERRUPTIBLE);
> +
> +               spin_unlock_irqrestore(par->lock, flags);
> +               schedule();
> +               spin_lock_irqsave(par->lock, flags);
> +       }
> +       finish_wait(&par->waitq, &wait);
> +
> +       spin_unlock_irqrestore(par->lock, flags);

wait_event() might be the perfect choice for the above case, unless your
spin_lock_* is really doing something useful, which I doubt it is actually
protecting something.

> +       return 0;
> +
> +}
> +
> +static int am300_init_gpio_regs(struct broadsheetfb_par *par)
> +{
> +       int i;
> +       int err;
> +       char dbname[8];
> +
> +       for (i = 0; i < ARRAY_SIZE(gpios); i++) {
> +               err = gpio_request(gpios[i], gpio_names[i]);
> +               if (err) {
> +                       dev_err(&am300_device->dev, "failed requesting "
> +                               "gpio %s, err=%d\n", gpio_names[i], err);
> +                       goto err_req_gpio;
> +               }
> +       }
> +
> +       /* we also need to take care of the hdb bus */
> +       for (i = DB0_GPIO_PIN; i <= DB15_GPIO_PIN; i++) {
> +               sprintf(dbname, "DB%d", i);
> +               err = gpio_request(i, dbname);
> +               if (err) {
> +                       dev_err(&am300_device->dev, "failed requesting "
> +                               "gpio %d, err=%d\n", i, err);
> +                       while (i >= DB0_GPIO_PIN)
> +                               gpio_free(i--);
> +                       i = ARRAY_SIZE(gpios) - 1;
> +                       goto err_req_gpio;
> +               }
> +       }
> +
> +       /* setup the outputs and init values */
> +       gpio_direction_output(PWR_GPIO_PIN, 0);
> +       gpio_direction_output(CFG_GPIO_PIN, 1);
> +       gpio_direction_output(DC_GPIO_PIN, 0);
> +       gpio_direction_output(RD_GPIO_PIN, 1);
> +       gpio_direction_output(WR_GPIO_PIN, 1);
> +       gpio_direction_output(CS_GPIO_PIN, 1);
> +       gpio_direction_output(RST_GPIO_PIN, 0);
> +
> +       /* setup the inputs */
> +       gpio_direction_input(RDY_GPIO_PIN);
> +       gpio_direction_input(IRQ_GPIO_PIN);
> +
> +       /* start the hdb bus as an input */
> +       for (i = DB0_GPIO_PIN; i <= DB15_GPIO_PIN; i++)
> +               gpio_direction_output(i, 0);
> +
> +       /* go into command mode */
> +       gpio_set_value(CFG_GPIO_PIN, 1);
> +       gpio_set_value(RST_GPIO_PIN, 0);
> +       mdelay(10);

which deserves a msleep(10) if the timing is relaxed enough.

> +       gpio_set_value(RST_GPIO_PIN, 1);
> +       mdelay(10);
> +       am300_wait_for_rdy(par);
> +
> +       return 0;
> +
> +err_req_gpio:
> +       while (i > 0)
> +               gpio_free(gpios[i--]);
> +
> +       return err;
> +}
> +
> +static int am300_init_board(struct broadsheetfb_par *par)
> +{
> +       int ret;
> +
> +       /* setup pins */
> +       ret = am300_init_gpio_regs(par);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}

which can be shortened to one statement 'return am300_init_gpio_regs(par)'

> +

------------------------------------------------------------------------------
