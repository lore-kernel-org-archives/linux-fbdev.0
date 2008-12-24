From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.27 2/2] mach-pxa: add AM300
	platform driver
Date: Wed, 24 Dec 2008 00:25:18 -0500
Message-ID: <45a44e480812232125k2feb1daar57cb6fbe44f050cc@mail.gmail.com>
References: <12298571881580-git-send-email-jayakumar.lkml@gmail.com>
	<f17812d70812230047g54cae195g8cf6297783d2602c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jayakumar.lkml@gmail.com>) id 1LFMFM-0001us-Nm
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 24 Dec 2008 05:25:28 +0000
Received: from rv-out-0708.google.com ([209.85.198.243])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LFMFE-0008Ns-1q for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 24 Dec 2008 05:25:28 +0000
Received: by rv-out-0708.google.com with SMTP id f25so2632236rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 23 Dec 2008 21:25:18 -0800 (PST)
In-Reply-To: <f17812d70812230047g54cae195g8cf6297783d2602c@mail.gmail.com>
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
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Eric Miao <eric.miao@marvell.com>, linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>, linux-arm-kernel@lists.arm.linux.org.uk

On Tue, Dec 23, 2008 at 3:47 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Sun, Dec 21, 2008 at 6:59 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>> This patch adds support for the AM300 platform driver.
>>
>
> Patch looks good, I feel I'm nit-picking. Anyway , see my comments below:
>
>> +/* register offsets for gpio control */
>> +#define PWR_GPIO_PIN 16
>> +#define CFG_GPIO_PIN 17
>> +#define RDY_GPIO_PIN 32
>> +#define DC_GPIO_PIN 48
>> +#define RST_GPIO_PIN 49
>> +#define LED_GPIO_PIN 51
>> +#define RD_GPIO_PIN 74
>> +#define WR_GPIO_PIN 75
>> +#define CS_GPIO_PIN 76
>> +#define IRQ_GPIO_PIN 77
>> +
>> +/* hdb bus */
>> +#define DB0_GPIO_PIN 58
>> +#define DB15_GPIO_PIN 73
>
> indentation?

Ok, will fix.


>> +       gpio_set_value(RST_GPIO_PIN, 0);
>> +       mdelay(10);
>
> which deserves a msleep(10) if the timing is relaxed enough.

True. Will fix.

>
>> +       gpio_set_value(RST_GPIO_PIN, 1);
>> +       mdelay(10);
>> +       am300_wait_for_rdy(par);
>> +
>> +       return 0;
>> +
>> +err_req_gpio:
>> +       while (i > 0)
>> +               gpio_free(gpios[i--]);
>> +
>> +       return err;
>> +}
>> +
>> +static int am300_init_board(struct broadsheetfb_par *par)
>> +{
>> +       int ret;
>> +
>> +       /* setup pins */
>> +       ret = am300_init_gpio_regs(par);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return 0;
>> +}
>
> which can be shortened to one statement 'return am300_init_gpio_regs(par)'
>

Yes, sorry, there was other stuff I had been doing in that function
while trying to trim down the board init to the minimum needed for
things to work. Okay, will fix.

Thanks,
jaya

------------------------------------------------------------------------------
