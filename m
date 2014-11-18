From: Ssagarr Patil <hugarsagar@outlook.com>
Date: Tue, 18 Nov 2014 14:59:58 +0000
Subject: RE: SSD1306 OLED driver
Message-Id: <BAY176-W50F6CA99F384A4E69870EFD3880@phx.gbl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
In-Reply-To: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Maxime,

>
> On Fri, Nov 14, 2014 at 05:09:09PM +0530, Ssagarr Patil wrote:
>> Hi,
>>
>> I have the SSD1306 oled device connected via spi, will the same
>> driver work ? as the current one is based on i2c what all mods would
>> be required to have it working with SPI ?
>
> It won't work out of the box, but it should be fairly easy to support.
>
> You need to had support for SPI probing, and then provide some generic
> accessors the rest of the code can use to wrap around the i2c and spi
> calls.
>
> I'm not sure regmap can be used for this, but this would be something
> worth looking into to do that.
>
Thanks for the inputs :)

Does the driver work as a standard fbdev driver, is there any library on top
of it to ease the user space ?

Thanks & Regards,
--Sagar
 		 	   		  