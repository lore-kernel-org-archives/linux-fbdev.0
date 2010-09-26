From: Daniel Drake <dsd@laptop.org>
Date: Sun, 26 Sep 2010 14:57:23 +0000
Subject: Re: [PATCH 2/2] viafb: Add OLPC XO-1.5 port configs
Message-Id: <AANLkTim-cmTwc_pJ0AwB15hEBS2kXfOMTyku9CWhwBka@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100921153726.21D609D401B@zog.reactivated.net>
In-Reply-To: <20100921153726.21D609D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 21 September 2010 18:54, Florian Tobias Schandinat
<FlorianSchandinat@gmx.de> wrote:
> *after a deeper look at the patch*
> Hm, one of my patches enables 0x26 also as I2C. So the only difference
> between the current config and your config is whether 0x2c is GPIO or I2C
> where your version make a lot more sense.
> Jon, do you agree that this should become the default config?
> Handling a GPIO device as such and not as an I2C device sounds right to me,
> although we have to take care about the old code which is doing so.

Jon, ping :)

Something possibly of relevance:
In addition to enabling the camera and DCON, changing the port config
of 0x2c from VIA_MODE_I2C to VIA_MODE_GPIO makes a fairly substantial
difference in the viafb init paths for XO-1.5.

On linus master, before making the change in my patch, viafb init
takes a long time, maybe 10 seconds. With linux-next 20100924, it
takes 2.5 seconds. After the patch, it takes 0.07 seconds.

Timings from linux-next:

[    1.021495] VIA Graphics Intergration Chipset framebuffer 2.4 initializing
[    1.029309] viafb 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    2.970023] viafb_init_dvi_size: DVI panel size undetected!
[    3.475728] Console: switching to colour frame buffer device 100x40

And from the same kernel with the port config adjusted:

[    1.025436] VIA Graphics Intergration Chipset framebuffer 2.4 initializing
[    1.033234] viafb 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.057799] viafb_init_dvi_size: DVI panel size undetected!
[    1.090548] Console: switching to colour frame buffer device 100x40

So, changing this value makes a pretty significant difference. If you
changed it globally I'm wondering if you'd be breaking current non-XO
systems, for example you'd be presumably affecting the behaviour of
viafb_lvds_trasmitter_identify()

At the same time, I don't fully understand what these port configs
actually are, so I might be far off point.

Daniel
