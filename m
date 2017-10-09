From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Mon, 09 Oct 2017 18:30:13 +0000
Subject: Re: [PATCH 1/3] backlight: tdo24m: fix the spi cs between transfers
Message-Id: <87tvz8dvii.fsf@belgarion.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171006195826.27500-1-robert.jarzmik@free.fr>
        <0ee32bde-0f3b-52b2-965f-84fa017c7b16@linaro.org>
In-Reply-To: <0ee32bde-0f3b-52b2-965f-84fa017c7b16@linaro.org> (Daniel
        Thompson's message of "Mon, 9 Oct 2017 12:14:38 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>, Andrea Adami <andrea.adami@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Daniel Thompson <daniel.thompson@linaro.org> writes:

> On 06/10/17 20:58, Robert Jarzmik wrote:
>
> I'm a tiny bit worried about see-saw bug fixing here but nevertheless this
> change looks correct to me.
>
> Mike's change was eight years ago and it is reasonable to hope that the patch
> was really just working around a (hopefully long fixed) bug in the SPI driver!
Actually I think it's the case.
And the driver bug fix is here :
  a52db659c79c ("spi: pxa2xx: Fix cs_change management")

And please don't apply this as there are 2 other LCDs which are affected by the
same issue and reported by Andrea, for which I had not correlated the issue
until yesterday, so I'll have to respin this 2 others files, namely :
 - drivers/video/backlight/corgi_lcd.c.
 - drivers/video/backlight/tosa_lcd.c.

There 2 other candidates I won't touch as they are not under my maintainance,
and I have no way to test them :
 - ili922x.c
 - ltv350qv.c

> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Thanks, but there will be a v2 with exactly the same fix in 3 files.

Cheers.

--
Robert
