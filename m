From: Noralf Tronnes <notro@tronnes.org>
Date: Sat, 10 Jan 2015 00:03:04 +0000
Subject: Re: SSD1306 OLED driver
Message-Id: <54B06C38.6040207@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
In-Reply-To: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Den 09.01.2015 23:31, skrev maxime.ripard@free-electrons.com:
> On Fri, Jan 09, 2015 at 06:13:43PM +0530, Ssagarr Patil wrote:
>> Hi Maxime,
>>
>> Thanks for your response!
>>
>>> On Fri, Jan 09, 2015 at 03:45:01PM +0530, Ssagarr Patil wrote:
>>>> Hi Maxime,
>>>>
>>>>>>> Thanks for the pointer, I am using spi_write() call and I see /dev/=
fb0 node created.
>>>>>>> but when I do echo "1121"> /dev/fb0 nothing comes up on oled any po=
inters on this ?
>>>>>> You can't use it like that. It's a standard framebuffer, that is
>>>>>> represented as an array of pixels, so you need to use a font renderi=
ng
>>>>>> software if you want to output some text.
>>>>>>
>>>>> can fbtest
>>>>> (https://git.kernel.org/cgit/linux/kernel/git/geert/fbtest.git/)
>>>>> be used to to draw something ?
>>>>>
>>>> how do I set pixels of it ? Please if you can point me to some stuff t=
hat would be helpful.
>>> Last time I tried, fbtest didn't support monochrome display.
>>>
>>> And you'll find anything you need in the documentation.
>>> https://www.kernel.org/doc/Documentation/fb/framebuffer.txt
>>>
>> In my case I see that init is done but I dont see any pixels on the
>> screen at all.
>>
>> I am now concerned if the driver was tested in first place ?
> No. I just submitted some good looking code that never ever got
> tested.
>
> More seriously, There's a few thing that comes to my mind:
>    - Your controller doesn't behave the same way than the ones already
>      supported.
>    - You haven't posted your changes yet, so maybe you're not doing the
>      transfers right
>    - Your SPI controller is doing something weird
>
> What happens if you plug a logical analyzer on the bus?
>
> Maxime
>
Hi,

The major difference between the SSD1306 SPI and I2C interfaces, is that=20
SPI uses a D/C pin to signal whether it's data or command coming in.
Looking at ssd1307fb, this Data/Command info is embedded as the first=20
byte in the i2c package/message.
Without looking up the datasheet, I would guess that this is the only=20
difference, the way the D/C bit is handled.
The rest of the package payload should be the same.
So:
dc=3D0, spi write command
dc=3D1, spi write data (optional)


Apart from that, I have SSD1306 SPI support in a project of mine:

This is the part writing the framebuffer:=20
https://github.com/notro/fbtft/blob/master/fb_ssd1306.c#L173
This writes commands (for many controllers):=20
https://github.com/notro/fbtft/blob/master/fbtft-bus.c#L10
This is the SPI specific part:=20
https://github.com/notro/fbtft/blob/master/fbtft-io.c#L10
Project wiki: https://github.com/notro/fbtft/wiki

The code isn't particularly pretty, it was my first venture into the kernel.
It has recently been submitted for the staging tree:=20
https://github.com/notro/fbtft/issues/161#issuecomment-68431405

I'm currently rewriting the project armed with better knowledge of the=20
kernel and the various LCD controllers.
I haven't done the SSD1306 controller yet, but the principle is almost=20
the same for all these MIPI DBI like controllers.
The major difference is that it's monochrome and has a different=20
register map.
In my rewrite I have made an abstraction for the LCD register:=20
https://github.com/notro/fbdbi/blob/master/core/lcdreg.h#L46
SPI part matching several controller variations:=20
https://github.com/notro/fbdbi/blob/master/core/lcdreg-spi.c

In case you wonder: In my code I set the the window where the update is=20
to take place every time, whereas ssd1307fb does this only once in init.
I do this because controllers supporting higher resolutions can be sped=20
up using partial updates (set_addr_win).


Regards,
Noralf Tr=F8nnes

