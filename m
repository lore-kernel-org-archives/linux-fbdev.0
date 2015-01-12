From: Ssagarr Patil <hugarsagar@outlook.com>
Date: Mon, 12 Jan 2015 09:56:36 +0000
Subject: RE: SSD1306 OLED driver
Message-Id: <BAY176-W146F7737FA1C4D4543845DD3430@phx.gbl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
In-Reply-To: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi Noralf,


>>>> just a quick help the dc pin should be a gpio and be set as output pin
>>>> to control D/C ?
>>> Correct.
>>>
>> Thanks!
>>
>> Is there any sample app/library to draw/test this driver?
> I find it easy to just use the framebuffer console for simple testing:
> con2fbmap (or X windows)
> I have also used Geert's fbtest.
>
Thanks.

I got it compiled against my kernel, but not sure how to add it in my board=
 file (My platform
has no DT support). Should it be registered as spi slave device , I tried a=
dding the following,

=A0=A0=A0 {
=A0=A0=A0 =A0=A0=A0 .modalias=A0=A0=A0 =3D "fb_ssd1306",
=A0=A0=A0 =A0=A0=A0 .irq=A0=A0=A0 =A0=A0=A0 =3D -1,
=A0=A0=A0 =A0=A0=A0 .max_speed_hz=A0=A0=A0 =3D 16000000,
=A0=A0=A0 =A0=A0=A0 .bus_num=A0=A0=A0 =3D 2,
=A0=A0=A0 =A0=A0=A0 .chip_select=A0=A0=A0 =3D 0,
=A0=A0=A0 =A0=A0=A0 .mode=A0=A0=A0 =A0=A0=A0 =3D SPI_MODE_0,
=A0=A0=A0 },

But nothing came up how do I register ? any quick pointer would be helpful.

Thanks And Regards,
Sagar
 		 	   		  