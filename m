From: Eric Miao <eric.y.miao@gmail.com>
Date: Fri, 20 Nov 2009 04:56:45 +0000
Subject: Re: [PATCH 7/8] pxa: add frame buffer on pxa168 aspenite platform
Message-Id: <f17812d70911192056m64b31c62hd050c0567e098cb@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c34ac520911160134k57023db1we74073a87a3dd454@mail.gmail.com>
	<f17812d70911162229s43ca6826k29c4c4a7e279144f@mail.gmail.com>
	<7c34ac520911190103q4ba79c60w11dfc8255b69abfa@mail.gmail.com>
	<f17812d70911190829u6831a176j7caae7e0bee3fa53@mail.gmail.com>
	<7c34ac520911191838k45fa4708vd8b606e9ad6a8d7@mail.gmail.com>
In-Reply-To: <7c34ac520911191838k45fa4708vd8b606e9ad6a8d7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Nov 19, 2009 at 8:38 PM, Jun Nie <niej0001@gmail.com> wrote:
> 2009/11/20 Eric Miao <eric.y.miao@gmail.com>:
>>> +       int err = 0;
>>> +       if (on) {
>>> +               if (spi_gpio_reset != -1) {
>>> +                       err = gpio_request(spi_gpio_reset, "TPO_LCD_SPI_RESET");
>>> +                       if (err) {
>>> +                               printk(KERN_ERR "failed to request GPIO for TPO LCD RESET\n");
>>> +                               return err;
>>> +                       }
>>> +                       gpio_direction_output(spi_gpio_reset, 0);
>>> +                       msleep(100);
>>
>> This is really a loooong delay, there any specific reason for such a long
>> delay, I'm seeing this to slow down the boot up significantly?
>>
>> Otherwise looks OK to me, and I prefer the defconfig file change to
>> be a separate patch please.
>>
>
> Actually, This is just an example for other real products. There is no
> such spi_reset pin on Aspenite , so machine info set it spi_gpio_reset
> = -1. Or do you think we should delete these lines?
>

I see no reason for it to stay there then, please remove.
