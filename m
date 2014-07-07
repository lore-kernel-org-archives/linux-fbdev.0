From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Mon, 07 Jul 2014 20:00:05 +0000
Subject: Re: [PATCH] video: backlight: jornada720_lcd.c: Cleaning up variable that is never used
Message-Id: <CAFo99gZinnNUteRiWH303h+ZANhup_niOA3E79tumm60WsKiLg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404670906-17335-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
	<20140707104635.GA6407@lee--X1>
In-Reply-To: <20140707104635.GA6407@lee--X1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

2014-07-07 12:46 GMT+02:00 Lee Jones <lee.jones@linaro.org>:
>> Variable ar assigned a value that is never used.
>> I have also removed all the code that thereby serves no purpose.
>>
>> This was found using a static code analysis program called cppcheck
>>
>> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
>> ---
>>  drivers/video/backlight/jornada720_lcd.c |    4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> Solve it the other way around.
>
> Add a check and return the value if an error is returned.

Hi

Ok, I take the opportunity to make a bigger change to clarify the
similarities in function.
Hope you like it, otherwise I can make the minor change instead.

Kind regards
Rickard Strandqvist
