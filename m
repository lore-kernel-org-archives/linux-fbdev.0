From: Jun Nie <niej0001@gmail.com>
Date: Fri, 20 Nov 2009 02:38:18 +0000
Subject: Re: [PATCH 7/8] pxa: add frame buffer on pxa168 aspenite platform
Message-Id: <7c34ac520911191838k45fa4708vd8b606e9ad6a8d7@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c34ac520911160134k57023db1we74073a87a3dd454@mail.gmail.com>
	<f17812d70911162229s43ca6826k29c4c4a7e279144f@mail.gmail.com>
	<7c34ac520911190103q4ba79c60w11dfc8255b69abfa@mail.gmail.com>
	<f17812d70911190829u6831a176j7caae7e0bee3fa53@mail.gmail.com>
In-Reply-To: <f17812d70911190829u6831a176j7caae7e0bee3fa53@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

2009/11/20 Eric Miao <eric.y.miao@gmail.com>:
>> + =A0 =A0 =A0 int err =3D 0;
>> + =A0 =A0 =A0 if (on) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi_gpio_reset !=3D -1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D gpio_request(spi_g=
pio_reset, "TPO_LCD_SPI_RESET");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KER=
N_ERR "failed to request GPIO for TPO LCD RESET\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_output(spi_=
gpio_reset, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(100);
>
> This is really a loooong delay, there any specific reason for such a long
> delay, I'm seeing this to slow down the boot up significantly?
>
> Otherwise looks OK to me, and I prefer the defconfig file change to
> be a separate patch please.
>

Actually, This is just an example for other real products. There is no
such spi_reset pin on Aspenite , so machine info set it spi_gpio_reset
=3D -1. Or do you think we should delete these lines?
