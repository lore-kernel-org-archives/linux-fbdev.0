From: Ssagarr Patil <hugarsagar@outlook.com>
Date: Mon, 05 Jan 2015 11:15:22 +0000
Subject: RE: SSD1306 OLED driver
Message-Id: <BAY176-W42E8756E92F0B784531CDBD3580@phx.gbl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
In-Reply-To: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
I have done the spi probing stuff, now only stuck with changing this to SPI=
 calls,

static int ssd1307fb_write_array(struct i2c_client *client,
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0struct ssd1307fb_array *array, u=
32 len)
{
=A0=A0=A0 int ret;

=A0=A0=A0 len +=3D sizeof(struct ssd1307fb_array);

=A0=A0=A0 ret =3D i2c_master_send(client, (u8 *)array, len);
=A0=A0=A0 if (ret !=3D len) {
=A0=A0=A0 =A0=A0=A0 dev_err(&client->dev, "Couldn't send I2C command.\n");
=A0=A0=A0 =A0=A0=A0 return ret;
=A0=A0=A0 }

=A0=A0=A0 return 0;
}

Any help on this would be appreciated!

Thanks,
Sagar
 		 	   		  