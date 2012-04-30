From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Mon, 30 Apr 2012 04:54:03 +0000
Subject: Re: [PATCH v2] backlight: Add LMS501KF03 LCD panel driver
Message-Id: <CAK9yfHxYBGXRjmadC9y_r8OSThTrhuGsKaKtLY-tRPFKHP5ExA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1334835208-32055-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1334835208-32055-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 30/04/2012, Jingoo Han <jg1.han@samsung.com> wrote:
> On 28 April 2012 11:02, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>> Any comments on the revised patch?
>>
>> On 19 April 2012 17:03, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>> > LMS501KF03 is a 480x800 LCD module with brightness control.
>> > The driver uses 3-wired SPI inteface.
>> >
<snip>

>> > +
>> > +#define POWER_IS_ON(power)     ((power) <= FB_BLANK_NORMAL)
>
> This could have been implemented as a regular lower-case C function.
> They're better than macros.
>
> Please refer to ams369fg06 amoled panel driver.

OK. Will modify.

>

<snip>
>> > +
>> > +const unsigned short SEQ_DISPLAY_OFF[] = {
>> > +       0x10,
>> > +       ENDDEF
>> > +};
>> > +
>
>
> It's not irregular that these symbols are all-uppercase.
> How about replacing them with lower-case?
> ex) SEQ_xxx -> seq_xxx

OK. Will modify.

>
>
<snip>

>> > +static int lms501kf03_set_brightness(struct backlight_device *bd)
>> > +{
>> > +       int ret = 0;
>> > +       int brightness = bd->props.brightness;
>> > +
>> > +       if (brightness < MIN_BRIGHTNESS ||
>> > +               brightness > bd->props.max_brightness) {
>> > +               dev_err(&bd->dev, "lcd brightness should be %d to
>> > %d.\n",
>> > +                       MIN_BRIGHTNESS, MAX_BRIGHTNESS);
>> > +               return -EINVAL;
>> > +       }
>> > +
>> > +       return ret;
>> > +}
>> > +
>
> Are these backlight control functions really necessary?
> As I am concerned, this LMS501KF03 uses PWM backlight as backlight control.
> If PWM backlight driver is used, these backlight control functions are
> superfluous.

Yes, you are right.  If PWM driver is used for backlight control, then
these functions are not necessary. However for the sake of
completeness of this driver, I have added them so that they could be
used to control backlight in cases where PWM is not used. Please let
me know your opinion.

>
>> > +static struct lcd_ops lms501kf03_lcd_ops = {
<snip>

>> > +
>> > +       lcd->lcd_pd = (struct lcd_platform_data
>> > *)spi->dev.platform_data;
>
> This is an unnecessary cast of void*.

OK. Will remove it.

>
>

Thank you for reviewing the patch and providing your comments. I will
modify and send the updated patch after I get your opinion about
backlight control.


-- 
With warm regards,
Sachin
