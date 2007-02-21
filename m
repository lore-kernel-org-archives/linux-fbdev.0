From: Paul Sokolovsky <pmiscml@gmail.com>
Subject: Re: [PATCH 1/1] PXAFB: Support for backlight control
Date: Wed, 21 Feb 2007 18:26:08 +0200
Message-ID: <1741775233.20070221182608@gmail.com>
References: <20070221145353.GA23916@enneenne.com> <1056908425.20070221180037@gmail.com> <20070221161210.GL4641@enneenne.com>
Reply-To: Paul Sokolovsky <pmiscml@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422662AbXBUQ0J@vger.kernel.org>
In-Reply-To: <20070221161210.GL4641@enneenne.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Richard Purdie <rpurdie@rpsys.net>

Hello Rodolfo,

Wednesday, February 21, 2007, 6:12:10 PM, you wrote:

> On Wed, Feb 21, 2007 at 06:00:37PM +0200, Paul Sokolovsky wrote:
>> 
>>   On the other hand, there's already
>> drivers/video/backlight/backlight.c which provides generic BL support,
>> implemented using notifier callback for FB core. Moreover, there's

> My patch _uses_ that support.

  Sorry if I missed it in quick review, as I told, there's a bit much
code ;-I

>> corgi_bl.c driver which, contrary to its name is a generic driver for
>> embedded/PDA device backlight. It essentially subclassses pretty
>> abstract backlight.c, and provides good implementation for most BL
>> implementation. What you really need to do to use it, is to supply
>> single machine-dependent method, set_bl_intensity(). That method is
>> usually <10 lines.

> I see, but in this manner you need to make a complete file for each
> board, while with my patch you can just put few lines into machine's
> definition file (a struct and 2 functions).

  Why? It's the same, except that it already exists, generic one (not
limited to pxafb), and requires 1 function (too bad that C doesn't
support lambda's):

==============
static void h4000_set_bl_intensity(int intensity)
{
        /* LCD brightness is driven by PWM0.
         * We'll set the pre-scaler to 8, and the period to 1024, this
         * means the backlight refresh rate will be 3686400/(8*1024) =
         * 450 Hz which is quite enough.
         */
        PWM_CTRL0 = 7;            /* pre-scaler */
        PWM_PWDUTY0 = intensity; /* duty cycle */
        PWM_PERVAL0 = H4000_MAX_INTENSITY;      /* period */

        if (intensity > 0) {
                pxa_set_cken(CKEN0_PWM0, 1);
                asic3_set_gpio_out_b(&h4000_asic3.dev,
                        GPIOB_BACKLIGHT_POWER_ON, GPIOB_BACKLIGHT_POWER_ON);
        } else {
                pxa_set_cken(CKEN0_PWM0, 0);
                asic3_set_gpio_out_b(&h4000_asic3.dev,
                        GPIOB_BACKLIGHT_POWER_ON, 0);
        }
}

static struct corgibl_machinfo h4000_bl_machinfo = {
        .default_intensity = H4000_MAX_INTENSITY / 4,
        .limit_mask = 0x0fff,
        .max_intensity = H4000_MAX_INTENSITY,
        .set_bl_intensity = h4000_set_bl_intensity,
};

struct platform_device h4000_bl = {
        .name = "corgi-bl",
        .dev = {
                .platform_data = &h4000_bl_machinfo,
        },
};
==============

>>   With this in mind, adhoc backlight handlers in pxafb and few other
>> drivers are artifacts of older times. And it's sad they are tried to
>> be resurrected instead of being removed.

> IMHO, the actual backlight support is not so much, infact I'd like to
> generalize it to support also backlighted keyboards (or input
> devices). :)

  I sent a bit of criticism for that too ;-). YMMV, but kernel
solutions are just bound to be pretty simple and generic and lack
any "niceties", which you'd likely want to do anyway eventually. For
example, what if you'll want to implement "fade out" effect for
keyboard backlight? Doing it in adhoc manner in kernel? Whereas with
the LCD classdev, you can write generic "fade out" trigger and
attach/detach it from userspace.

> Ciao,

> Rodolfo




-- 
Best regards,
 Paul                            mailto:pmiscml@gmail.com
