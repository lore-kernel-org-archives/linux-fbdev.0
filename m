From: Ssagarr Patil <hugarsagar@outlook.com>
Date: Fri, 09 Jan 2015 12:55:43 +0000
Subject: RE: SSD1306 OLED driver
Message-Id: <BAY176-W192A1C77E7FC52307B4C6D3440@phx.gbl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
In-Reply-To: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Maxime,

Thanks for your response!

> On Fri, Jan 09, 2015 at 03:45:01PM +0530, Ssagarr Patil wrote:
>>
>> Hi Maxime,
>>
>>>>> Thanks for the pointer, I am using spi_write() call and I see /dev/fb0 node created.
>>>>> but when I do echo "1121"> /dev/fb0 nothing comes up on oled any pointers on this ?
>>>>
>>>> You can't use it like that. It's a standard framebuffer, that is
>>>> represented as an array of pixels, so you need to use a font rendering
>>>> software if you want to output some text.
>>>>
>>> can fbtest
>>> (https://git.kernel.org/cgit/linux/kernel/git/geert/fbtest.git/)
>>> be used to to draw something ?
>>>
>> how do I set pixels of it ? Please if you can point me to some stuff that would be helpful.
>
> Last time I tried, fbtest didn't support monochrome display.
>
> And you'll find anything you need in the documentation.
> https://www.kernel.org/doc/Documentation/fb/framebuffer.txt
>
In my case I see that init is done but I dont see any pixels on the screen at all.
I am now concerned if the driver was tested in first place ?

Thanks And Regards,
Sagar

 		 	   		  