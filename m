From: Dzianis Kahanovich <mahatma@bspu.unibel.by>
Date: Fri, 17 Dec 2010 20:57:11 +0000
Subject: Re: [PATCH v3] (new way) I2C/DDC defaults & I2C/DDC detection for
Message-Id: <4D0BCEA7.6080509@bspu.unibel.by>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4D00D508.1060106@bspu.unibel.by>
In-Reply-To: <4D00D508.1060106@bspu.unibel.by>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Florian Tobias Schandinat wrote:

I'm don't read my mail even more, sorry.
OK, I will try to complete most of your recommendations. But few questions:

> I'm wondering which tree are you using as a base?
> Your patch does not apply and not compile. Please use at least latest mainline
> as a base or even better current linux-next.

OK. First I was use linux-git, but may be (now not check) fall to release (at
home) (git & release differs over line numbers only on that moment). Now I will
use only linux-next latest.

[...]
> 
> You are trying to do 2 sorts of things in this function:
> 
> - You are trying to detect the lcd_panel_hres/vres. This is usually a good thing
> but you shouldn't blindly call them after the existing detection is done but
> rather sanely integrate it in (extend) the already "detection" in lcd.c (I am
> not happy that this would move the EDID code in the LCD area but as long as we
> modify the lvds structure the only sane way is to call it from lcd.c)

IMHO this tasks are not too same, but I will think. Really I detect not LCD, but
"any EDID". But while my CRT (second device) don't return EDID and I unable to
sure detect something else - I detect LCD only. Againg, various data required
after detection. But I will look to code and think.

> 
> - You are trying to change the global default configuration. This is a lot
> trickier as it is easy to make it work for you but break it for others. If you
> do this you have to prove (code does the obvious correct thing) that it is
> closer to what everybody needs

HMM. May be I do wrong. But IMHO defaults vs. "dead device" (this is dead by
default for anybody, exclude CRT) is not crime ;)

>>      viafb_init_chip_info(vdev->chip_type);
>> +    /* detect dual_fb & SAMM_ON, but let's keep it to options */
>> +#if 0
>> +    viafb_detect_dev(0, vdev);
> 
> As this is never true, please remove it. Adding dead code is strictly forbidden
> and I've spent lots of days kicking such code out of the driver. Removing it of
> course includes removing your whole stage stuff.

OK. I just keep dual/SAMM detection working up to last moment. But finally I
start to think, SAMM/dual defaults are not same with "viafb_active_dev" and may
be better to keep it (I don't know now if SAMM/dual not set by user). But it it
work even on my not "dual_fb" card (CRT+LCD workd anymore) and if anybody think
this is good... But while you say about changing defaults is wrong - I will
remove it.

In terms of "best default config" SAMM/dual detection is good, but in terms of
"don't touch" - no. Still unsure even now ;)

> Perhaps you should send this one as a separate patch. It is unrelated to your
> other stuff and looks good to me.

OK, I separate it. But relative related - while it is completely "dead code" and
don't used nowhere else and I cared to using it. ;)


About CRT detection: I think, CRT don't detected becouse it must be detected via
i2c+gpio. No? But i2c+gpio broken in many places (includes pieces of dead
i2c+gpio code, newer be reached now). May be it related more to
drivers/i2c/busses/i2c-gpio.ko, even it start and bint to viafb (after some i2c
code fixes), but without results and I don't understand how it must work with
current code and while it not completed, I think there are not too trivial task.
Are you know how CRT/DDC must/may be detected?

Summary: I will think more, then IMHO first I will send separated patches with
this behaviour...

-- 
WBR, Dzianis Kahanovich AKA Denis Kaganovich, http://mahatma.bspu.unibel.by/
