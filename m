From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 22 Mar 2017 08:53:02 +0000
Subject: Re: staging: iio: Replace a bit shift by a use of BIT.
Message-Id: <CAK8P3a2sKZK7mRsWKnLsz6b9TYy_LdxhVCUnxUpkEOHZRDrdpA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170322024942.GA21242@arushi-HP-Pavilion-Notebook>
In-Reply-To: <20170322024942.GA21242@arushi-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: outreachy-kernel@googlegroups.com, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Mar 22, 2017 at 3:49 AM, Arushi Singhal
<arushisinghal19971997@gmail.com> wrote:

> @@ -232,7 +232,7 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
>         if (ret < 0)
>                 goto error_ret;
>
> -       cfg = ret & ~((0x03 << 5) | (0x1 << 7));
> +       cfg = ret & ~((0x03 << 5) | (BIT(7)));
>
>         switch (type) {
>         case IIO_EV_TYPE_MAG_ADAPTIVE:

While the change in the #defines is not unusual, this particular change
here makes it harder to read, so I'd recommend leaving it alone, or changing
it to use symbolic names instead of the bit masks.

>  /* Voltage/Temperature Setup Register Bit Designations (AD7746_REG_VT_SETUP) */
> -#define AD7746_VTSETUP_VTEN            (1 << 7)
> +#define AD7746_VTSETUP_VTEN            (BIT(7))
>  #define AD7746_VTSETUP_VTMD_INT_TEMP   (0 << 5)
> -#define AD7746_VTSETUP_VTMD_EXT_TEMP   (1 << 5)
> +#define AD7746_VTSETUP_VTMD_EXT_TEMP   (BIT(5))

Why did you leave one of them unchanged?

    Arnd
