From: Dzianis Kahanovich <mahatma@bspu.unibel.by>
Date: Mon, 06 Dec 2010 13:53:14 +0000
Subject: Re: [PATCH v5+] viafb: I2C/DDC LCD detection for VIA framebuffer
Message-Id: <4CFCEACA.3050600@bspu.unibel.by>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4CF8DA25.4020204@bspu.unibel.by>
In-Reply-To: <4CF8DA25.4020204@bspu.unibel.by>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Florian Tobias Schandinat wrote:

> As Jon already mentioned, via-core.c is the wrong file for such things because
> via-core is meant for managing shared resources (between video capture and
> framebuffer at the moment) and EDID is only interesting for the framebuffer.
> Probably viafbdev.c would be the best choice.

I think about moving code, but another sense was - this code mix (eclectic)
calls from various places and called from here, then...

But OK.

>> +            if (!viafb_active_dev) {
>> +                viafb_DVI_ON >> +                    viaparinfo->tmds_setting_info->max_hres ?
>> +                    STATE_ON : STATE_OFF;
> 
> Doing such thing here looks wrong as this loop does not influence
> viaparinfo->tmds_setting_info

I have only card, incompatible with current tmds code - Chrome9 (0x3371). But
while I send patch, I think "legacy" DDC code must at least be compatible with
current code and not brake it. Really I have no tmds identifyed and this place
only disabling DVI if so (default enabled).

>> +                if (viafbinfo->monspecs.input & FB_DISP_DDI) {
>> +                    viafb_LCD_ON = STATE_ON;
> 
> It can happen that we enable LCD and DVI for the same device? Well nearly the
> only difference between LCD and DVI is backlight handling, so it should work,
> but it is ugly.

Then I must not enable LCD if DVI/tmds detected?
if ((viafbinfo->monspecs.input & FB_DISP_DDI) && !viafb_DVI_ON) {

- right? If there are only change I may make - do it if you will use this code.

Or just on start of function:
if (viaparinfo->tmds_setting_info->max_hres)
	return;

What is better?

> I like your EDID parsing code (the fact that you are using existing functions).
> But as we already have a poor open-coded EDID parser and as it would be very
> ugly to have two different methods of EDID parsing in the same driver you really
> should investigate whether your parser can't fully replace the one in dvi.c

Current parser just don't work with my card. But this - at least found good
resolution and whole LCD. Default I have dead DVI and CRT. And LCD resolution
not detected. I must change type to "17" (1024x600), default - "2" (1024x768).
This code is just working for me.

> And you should care about where the EDID information comes from:
> 0x21 => CRT, do not set lvds or tmds information
> 0x31 => DVP1:
[...]

OK. I will play with this.


-- 
WBR, Dzianis Kahanovich AKA Denis Kaganovich, http://mahatma.bspu.unibel.by/
