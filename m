From: Ssagarr Patil <hugarsagar@outlook.com>
Date: Sat, 10 Jan 2015 21:19:45 +0000
Subject: RE: SSD1306 OLED driver
Message-Id: <BAY176-W4878FDC2238E6AF9B8218ED3450@phx.gbl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
In-Reply-To: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi=A0Noralf,

> Date: Sat, 10 Jan 2015 14:50:09 +0100
> From: notro@tronnes.org
> To: hugarsagar@outlook.com
> CC: linux-fbdev@vger.kernel.org
> Subject: Re: SSD1306 OLED driver
>
> Den 10.01.2015 13:34, skrev Ssagarr Patil:
>> Hi Noralf,
>>
>>>>> I am now concerned if the driver was tested in first place ?
>>>> No. I just submitted some good looking code that never ever got
>>>> tested.
>>>>
>>>> More seriously, There's a few thing that comes to my mind:
>>>> - Your controller doesn't behave the same way than the ones already
>>>> supported.
>>>> - You haven't posted your changes yet, so maybe you're not doing the
>>>> transfers right
>>>> - Your SPI controller is doing something weird
>>>>
>>>> What happens if you plug a logical analyzer on the bus?
>>>>
>>>> Maxime
>>>>
>>> Hi,
>>>
>>> The major difference between the SSD1306 SPI and I2C interfaces, is that
>>> SPI uses a D/C pin to signal whether it's data or command coming in.
>>> Looking at ssd1307fb, this Data/Command info is embedded as the first
>>> byte in the i2c package/message.
>>> Without looking up the datasheet, I would guess that this is the only
>>> difference, the way the D/C bit is handled.
>>> The rest of the package payload should be the same.
>>> So:
>>> dc=3D0, spi write command
>>> dc=3D1, spi write data (optional)
>>>
>> I was working on ssd1306 itself.
>>
>>> Apart from that, I have SSD1306 SPI support in a project of mine:
>>>
>>> This is the part writing the framebuffer:
>>> https://github.com/notro/fbtft/blob/master/fb_ssd1306.c#L173
>>> This writes commands (for many controllers):
>>> https://github.com/notro/fbtft/blob/master/fbtft-bus.c#L10
>>> This is the SPI specific part:
>>> https://github.com/notro/fbtft/blob/master/fbtft-io.c#L10
>>> Project wiki: https://github.com/notro/fbtft/wiki
>>>
>> Thanks for the pointers that was really helpful.
>>
>> just a quick help the dc pin should be a gpio and be set as output pin
>> to control D/C ?
> Correct.
>
Thanks!

Is there any sample app/library to draw/test =A0this driver?

Thanks,
--Sagar 		 	   		  