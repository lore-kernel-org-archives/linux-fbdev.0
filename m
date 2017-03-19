From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 19 Mar 2017 14:04:09 +0000
Subject: Re: [Outreachy kernel] [PATCH v3] staging: sm750fb: Code readability is improved
Message-Id: <CAMuHMdU_jvNSbi5mfexMZHjvXqny6v+3F4Cc_OCTpD0jngWaQQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170319130744.GA24605@arushi-HP-Pavilion-Notebook> <alpine.DEB.2.20.1703191409140.2108@hadrien>
In-Reply-To: <alpine.DEB.2.20.1703191409140.2108@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Arushi Singhal <arushisinghal19971997@gmail.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, driverdevel <devel@driverdev.osuosl.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, outreachy-kernel@googlegroups.com

On Sun, Mar 19, 2017 at 2:11 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> On Sun, 19 Mar 2017, Arushi Singhal wrote:
>> New variables are added to make the code more readable.
>>
>> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
>> ---
>>  changes in v3
>>  -try to make the code much more readable.
>>
>>  drivers/staging/sm750fb/ddk750_mode.c | 61 ++++++++++++++++++++---------------
>>  1 file changed, 35 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
>> index eea5aef2956f..5f18ce4d10de 100644
>> --- a/drivers/staging/sm750fb/ddk750_mode.c
>> +++ b/drivers/staging/sm750fb/ddk750_mode.c
>> @@ -81,33 +81,42 @@ static int programModeRegisters(mode_parameter_t *pModeParam, struct pll_value *
>>       if (pll->clockType = SECONDARY_PLL) {
>>               /* programe secondary pixel clock */
>>               poke32(CRT_PLL_CTRL, sm750_format_pll_reg(pll));
>> -             poke32(CRT_HORIZONTAL_TOTAL,
>> -                    (((pModeParam->horizontal_total - 1) <<
>> -                      CRT_HORIZONTAL_TOTAL_TOTAL_SHIFT) &
>> -                     CRT_HORIZONTAL_TOTAL_TOTAL_MASK) |
>> -                    ((pModeParam->horizontal_display_end - 1) &
>> -                     CRT_HORIZONTAL_TOTAL_DISPLAY_END_MASK));
>> -
>> -             poke32(CRT_HORIZONTAL_SYNC,
>> -                    ((pModeParam->horizontal_sync_width <<
>> -                      CRT_HORIZONTAL_SYNC_WIDTH_SHIFT) &
>> -                     CRT_HORIZONTAL_SYNC_WIDTH_MASK) |
>> -                    ((pModeParam->horizontal_sync_start - 1) &
>> -                     CRT_HORIZONTAL_SYNC_START_MASK));
>>
>> -             poke32(CRT_VERTICAL_TOTAL,
>> -                    (((pModeParam->vertical_total - 1) <<
>> -                      CRT_VERTICAL_TOTAL_TOTAL_SHIFT) &
>> -                     CRT_VERTICAL_TOTAL_TOTAL_MASK) |
>> -                    ((pModeParam->vertical_display_end - 1) &
>> -                     CRT_VERTICAL_TOTAL_DISPLAY_END_MASK));
>> -
>> -             poke32(CRT_VERTICAL_SYNC,
>> -                    ((pModeParam->vertical_sync_height <<
>> -                      CRT_VERTICAL_SYNC_HEIGHT_SHIFT) &
>> -                     CRT_VERTICAL_SYNC_HEIGHT_MASK) |
>> -                    ((pModeParam->vertical_sync_start - 1) &
>> -                     CRT_VERTICAL_SYNC_START_MASK));
>> +             unsigned int a = (pModeParam->horizontal_total - 1) <<
>> +                             CRT_HORIZONTAL_TOTAL_TOTAL_SHIFT;
>> +             unsigned int b = a & CRT_HORIZONTAL_TOTAL_TOTAL_MASK;
>> +             unsigned int c = (pModeParam->horizontal_display_end - 1) &
>> +                             CRT_HORIZONTAL_TOTAL_DISPLAY_END_MASK;
>> +             unsigned int temp = b | c;
>> +
>> +             poke32(CRT_HORIZONTAL_TOTAL, temp);
>> +
>> +             unsigned int a = (pModeParam->horizontal_sync_width <<
>> +                             CRT_HORIZONTAL_SYNC_WIDTH_SHIFT);
>> +             unsigned int b = a & CRT_HORIZONTAL_SYNC_WIDTH_MASK;
>> +             unsigned int c = (pModeParam->horizontal_sync_start - 1) &
>> +                             CRT_HORIZONTAL_SYNC_START_MASK;
>> +             unsigned int temp = b | c;
>
> This is back to the original incorrect solution.  You can't declare
> variables on the fly in Linux code.  Variables have to be declared at the
> top of a block.

Arushi: have you tried to compile this?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
