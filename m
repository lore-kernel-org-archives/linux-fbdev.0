From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Mon, 09 Oct 2017 11:14:38 +0000
Subject: Re: [PATCH 1/3] backlight: tdo24m: fix the spi cs between transfers
Message-Id: <0ee32bde-0f3b-52b2-965f-84fa017c7b16@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171006195826.27500-1-robert.jarzmik@free.fr>
In-Reply-To: <20171006195826.27500-1-robert.jarzmik@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Jarzmik <robert.jarzmik@free.fr>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 06/10/17 20:58, Robert Jarzmik wrote:
> Currently the LCD display (TD035S) on the cm-x300 platform is broken and
> remains blank.
> 
> The TD0245S specification requires that the chipselect is toggled
> between commands sent to the panel. This was also the purpose of the
> former patch of commit f64dcac0b124 ("backlight: tdo24m: ensure chip
> select changes between transfers").
> 
> Unfortunately, the "cs_change" field of a SPI transfer is
> misleading. Its true meaning is that for a SPI message holding multiple
> transfers, the chip select is toggled between each transfer, but for the
> last transfer it remains asserted.
> 
> In this driver, all the SPI messages contain exactly one transfer, which
> means that each transfer is the last of its message, and as a
> consequence the chip select is never toggled.
> 
> This fix makes the TD035S work again on a cm-x300 board.
> 
> Fixes: f64dcac0b124 ("backlight: tdo24m: ensure chip select changes
>         between transfers")
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

I'm a tiny bit worried about see-saw bug fixing here but nevertheless 
this change looks correct to me.

Mike's change was eight years ago and it is reasonable to hope that the 
patch was really just working around a (hopefully long fixed) bug in the 
SPI driver!


Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>   drivers/video/backlight/tdo24m.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/tdo24m.c b/drivers/video/backlight/tdo24m.c
> index eab1f842f9c0..e4bd63e9db6b 100644
> --- a/drivers/video/backlight/tdo24m.c
> +++ b/drivers/video/backlight/tdo24m.c
> @@ -369,7 +369,7 @@ static int tdo24m_probe(struct spi_device *spi)
>   
>   	spi_message_init(m);
>   
> -	x->cs_change = 1;
> +	x->cs_change = 0;
>   	x->tx_buf = &lcd->buf[0];
>   	spi_message_add_tail(x, m);
>   
> 

