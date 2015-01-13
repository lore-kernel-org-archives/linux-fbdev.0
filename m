From: Ssagarr Patil <hugarsagar@outlook.com>
Date: Tue, 13 Jan 2015 13:45:37 +0000
Subject: RE: SSD1306 OLED driver
Message-Id: <BAY176-W3FC7B986964DBB4A27278D3400@phx.gbl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
In-Reply-To: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Noralf,

>> },
>>
>> But nothing came up how do I register ? any quick pointer would be helpful.
>
> Copy/symlink fbtft.h to include/fbtft.h and do it like this:
> https://github.com/notro/fbtft/wiki/Build-kernel-and-fbtft-drivers#configure-devices
>
> Or use the fbtft_device module:
> https://github.com/notro/fbtft/wiki/fbtft_device
> ssd1306 entry:
> https://github.com/notro/fbtft/blob/master/fbtft_device.c#L272
> The values can be set/changed using module arguments.
>

Thanks for the pointers that helped!

will the regwidth and buswidth be populated ?
I am not sure what these two should be set to.

Thanks And Regards,
--Sagar
 		 	   		  