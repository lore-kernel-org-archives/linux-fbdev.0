From: Rob Herring <robh@kernel.org>
Date: Mon, 26 Nov 2018 13:49:36 +0000
Subject: Re: [PATCH fbdev-for-next 2/2] video: ssd1307fb: Add support for the reset-active-low property
Message-Id: <CAL_JsqKninqSUJwcoH6+797r2zt_bviraPTUR2QhEp67EcNpgg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1541170556-75032-1-git-send-email-michal.vokac@ysoft.com>
 <1541170556-75032-2-git-send-email-michal.vokac@ysoft.com>
 <5bea0e9c.1c69fb81.1f3c8.be5a@mx.google.com> <db9537dc-2ba5-b8fc-ae3c-7d85841b0797@ysoft.com>
 <CAL_Jsq+KOqWVdudDGZNJSJ1SZSX1FK2GOSu-4VfmRV-KZrYJZA@mail.gmail.com> <f0389ca6-076b-b450-ffd5-d496627d1c58@ysoft.com>
In-Reply-To: <f0389ca6-076b-b450-ffd5-d496627d1c58@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <Michal.Vokac@ysoft.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, Jyri Sarha <jsarha@ti.com>

On Mon, Nov 26, 2018 at 6:25 AM Vokáč Michal <Michal.Vokac@ysoft.com> wrote:
>
> On 19.11.2018 23:32, Rob Herring wrote:
> > On Mon, Nov 19, 2018 at 9:12 AM Vokáč Michal <Michal.Vokac@ysoft.com> wrote:
> >> On 12.11.2018 17:55, Rob Herring wrote:
> >>> On Fri, Nov 02, 2018 at 02:56:35PM +0000, Vokáč Michal wrote:
> >>>> The SSD130x OLED display reset signal is active low. Now the reset
> >>>> sequence is implemented in such a way that DTS authors are forced to
> >>>> define the reset-gpios property with GPIO_ACTIVE_HIGH to make the reset
> >>>> work.
> >>>>
> >>>> Add the reset-active-low property so the signal is inverted once again
> >>>> and the GPIO_ACTIVE_LOW work as expected.
> >>>>
> >>>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> >>>> ---
> >>>>    drivers/video/fbdev/ssd1307fb.c | 6 ++++--
> >>>>    1 file changed, 4 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
> >>>> index e7ae135..790f1c4 100644
> >>>> --- a/drivers/video/fbdev/ssd1307fb.c
> >>>> +++ b/drivers/video/fbdev/ssd1307fb.c
> >>>> @@ -608,6 +608,7 @@ static int ssd1307fb_probe(struct i2c_client *client,
> >>>>       struct fb_deferred_io *ssd1307fb_defio;
> >>>>       u32 vmem_size;
> >>>>       struct ssd1307fb_par *par;
> >>>> +    bool reset_active_low;
> >>>>       u8 *vmem;
> >>>>       int ret;
> >>>>
> >>>> @@ -671,6 +672,7 @@ static int ssd1307fb_probe(struct i2c_client *client,
> >>>>       par->com_seq = of_property_read_bool(node, "solomon,com-seq");
> >>>>       par->com_lrremap = of_property_read_bool(node, "solomon,com-lrremap");
> >>>>       par->com_invdir = of_property_read_bool(node, "solomon,com-invdir");
> >>>> +    reset_active_low = of_property_read_bool(node, "reset-active-low");
> >>>>
> >>>>       par->contrast = 127;
> >>>>       par->vcomh = par->device_info->default_vcomh;
> >>>> @@ -728,9 +730,9 @@ static int ssd1307fb_probe(struct i2c_client *client,
> >>>>
> >>>>       if (par->reset) {
> >>>>               /* Reset the screen */
> >>>> -            gpiod_set_value_cansleep(par->reset, 0);
> >>>> +            gpiod_set_value_cansleep(par->reset, reset_active_low);
> >>>>               udelay(4);
> >>>> -            gpiod_set_value_cansleep(par->reset, 1);
> >>>> +            gpiod_set_value_cansleep(par->reset, !reset_active_low);
> >>>
> >>> I think you and whomever wrote the original code are misinterpretting
> >>> how the gpiod API works. 1 means make the signal active and this case
> >>> active is low.
> >>
> >> I totally agree and I think I understand that correctly.
> >>
> >>> It is strange, but does mean a reset sequence should always be set to a
> >>> 1 and then a 0 and it will work with either polarity in the DT.
> >>
> >> I agree the reset should be done as a 0 -> 1 -> 0 sequence and that should
> >> just work. The problem is it is implemented vice versa and so it works only
> >> if you have GPIO_ACTIVE_HIGH in DT for a signal that is actually active low.
> >>
> >> And what it actually does is that it holds the controller in reset since
> >> the GPIO is successfully acquired (because of GPIOD_OUT_LOW here [1]) and
> >> later on it only releases the reset.
> >>
> >> As a DT author I would like to somehow clearly state that the OLED display
> >> uses active low reset in my DT.
> >>
> >> My first attempt to fix this was to change the reset sequence [2].
> >> It was applied and then reverted as it is not backward compatible with
> >> deployed DTB files [3].
> >>
> >> [1] https://elixir.bootlin.com/linux/v4.20-rc3/source/drivers/video/fbdev/ssd1307fb.c#L570
> >> [2] https://patchwork.kernel.org/patch/10617729/
> >> [3] https://patchwork.kernel.org/patch/10617731/
> >
> > Okay, now I understand the background. We've hit this somewhere else too.
> >
> > Rather than have a binding demonstrating what not to do, I'd like to
> > fix this in another way. I also don't want to live with this forever
> > when there's only 1 board affected (in tree at least) and there's only
> > an ABI if someone notices (I'm happy though that the maintainers
> > caught this). There's 2 other options. The 1st is add a fixup to the
> > DT for this platform to ensure that the GPIO is configured active low
> > (the Versatile platform code has an example fixup). With that, apply
> > what was originally applied (or revert the revert). The fixup could be
> > applied only after someone complains their display broke. The 2nd
> > option is just add an of_machine_is_compatible check within this
> > driver. In that case, you wouldn't fix dts file for the platform
> > (unless you also want to manually check reset-gpios).
>
> Hi Rob,
>
> I am still trying to figure out what exactly you meant by the 1st and
> 2nd option. Both concepts are new to me.
>
> Regarding the 1st option, what you meant by "this platform" here:
> > Add a fixup to the DT for this platform
> The only board in tree that uses the OLED (imx28-cfa10036) and its
> dts file?

Yes, that one.

>
> I am also not sure where to look for the example. When you say
> Versatile platform code I tend to look into plat-versatile or
> mach-versatile. I could not find anything I could use as an example
> in there. I think that is not what you meant.

See versatile_dt_pci_init(). Or look for other callers of of_update_property().

> Regarding the 2nd option, you suggest to use of_machine_is_compatible
> to decide what reset sequence to use? In case of imx28-cfa10036 use
> the old 0 -> 1, in all other cases use a new correct sequence 1 -> 0?
> That also does not seem right.

Correct. Though if you fix imx28-cfa10036 dts, then you have to handle
that case too.

Why is it not right? Ugly yes, but it's not wrong.

Rob
