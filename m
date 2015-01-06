From: Ssagarr Patil <hugarsagar@outlook.com>
Date: Tue, 06 Jan 2015 13:12:01 +0000
Subject: RE: SSD1306 OLED driver
Message-Id: <BAY176-W49BEC63D9EFBC8C381FAABD3590@phx.gbl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
In-Reply-To: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Maxime,

>>>
>>> You need to had support for SPI probing, and then provide some generic
>>> accessors the rest of the code can use to wrap around the i2c and spi
>>> calls.
>>>
>> I have done the spi probing stuff, now only stuck with changing this to SPI calls,
>>
>> static int ssd1307fb_write_array(struct i2c_client *client,
>>                  struct ssd1307fb_array *array, u32 len)
>> {
>>     int ret;
>>
>>     len += sizeof(struct ssd1307fb_array);
>>
>>     ret = i2c_master_send(client, (u8 *)array, len);
>>     if (ret != len) {
>>         dev_err(&client->dev, "Couldn't send I2C command.\n");
>>         return ret;
>>     }
>>
>>     return 0;
>> }
>>
>> Any help on this would be appreciated!
>
> I'm not sure what help you are expecting.
>
> This is a simple function that takes an array and sends it over I2C.
>
> It's probably even easier with SPI. Have you considered reading
> include/spi/spi.h?
>
Thanks for the pointer, I am using spi_write() call and I see /dev/fb0 node created.
but when I do echo "1121"> /dev/fb0 nothing comes up on oled any pointers on this ?

Thanks & Regards,
--Sagar
 		 	   		  