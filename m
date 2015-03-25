From: Olliver Schinagl <oliver@schinagl.nl>
Date: Wed, 25 Mar 2015 15:49:47 +0000
Subject: Re: [PATCHv5 04/11] fbdev: ssd1307fb: Unify init code and obtain hw specific bits from DT
Message-Id: <5512D91B.9090709@schinagl.nl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de> <1427232238-21099-1-git-send-email-niederp@physik.uni-kl.de> <1427232238-21099-5-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1427232238-21099-5-git-send-email-niederp@physik.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?VGhvbWFzIE5pZWRlcnByw7xt?= <niederp@physik.uni-kl.de>, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com, kernel@pengutronix.de, shawn.guo@linaro.org, robh+dt@kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hey Thomas,

awesome the time you put into this driver. It does what I was working on 
the last few weeks, but with a much bigger bang ;)

I personally have a ssd1309 and will be submitting the patches for that 
after testing your patch-set.

On 24-03-15 22:23, Thomas Niederprüm wrote:
> The 130X controllers are very similar from the configuration point of view.
> The configuration registers for the SSD1305/6/7 are bit identical (except the
> the VHCOM register and the the default values for clock setup register). This
> patch unifies the init code of the controller and adds hardware specific
> properties to DT that are needed to correctly initialize the device.
>
> The SSD130X can be wired to the OLED panel in various ways. Even for the
> same controller this wiring can differ from one display module to another
> and can not be probed by software. The added DT properties reflect these
> hardware decisions of the display module manufacturer.
> The 'com-sequential', 'com-lrremap' and 'com-invdir' values define different
> possibilities for the COM signals pin configuration and readout direction
> of the video memory. The 'segment-no-remap' allows the inversion of the
> memory-to-pin mapping ultimately inverting the order of the controllers
> output pins. The 'prechargepX' values need to be adapted according to the
> capacitance of the OLEDs pixel cells.
>
> So far these hardware specific bits are hard coded in the init code, making
> the driver usable only for one certain wiring of the controller. This patch
> makes the driver usable with all possible hardware setups, given a valid hw
> description in DT. If these values are not set in DT the default values,
> as they are set in the ssd1307 init code right now, are used. This implies
> that without the corresponding DT property "segment-no-remap" the segment
> remap of the ssd130X controller gets activated. Even though this is not the
> default behaviour according to the datasheet it maintains backward
> compatibility with older DTBs.
>
> Note that the SSD1306 does not seem to be using the configuration written to
> the registers at all. Therefore this patch does not try to maintain these
> values without changes in DT. For reference an example is added to the DT
> bindings documentation that reproduces the configuration that is set in the
> current init code.
>
> Signed-off-by: Thomas Niederprüm <niederp@physik.uni-kl.de>
> ---
>   .../devicetree/bindings/video/ssd1307fb.txt        |  21 +++
>   drivers/video/fbdev/ssd1307fb.c                    | 192 ++++++++++++---------
>   2 files changed, 134 insertions(+), 79 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/video/ssd1307fb.txt b/Documentation/devicetree/bindings/video/ssd1307fb.txt
> index 7a12542..637690f 100644
> --- a/Documentation/devicetree/bindings/video/ssd1307fb.txt
> +++ b/Documentation/devicetree/bindings/video/ssd1307fb.txt
> @@ -15,6 +15,16 @@ Required properties:
>
>   Optional properties:
>     - reset-active-low: Is the reset gpio is active on physical low?
> +  - solomon,segment-no-remap: Display needs normal (non-inverted) data column
> +                              to segment mapping
> +  - solomon,com-sequential: Display uses sequential COM pin configuration
> +  - solomon,com-lrremap: Display uses left-right COM pin remap
> +  - solomon,com-invdir: Display uses inverted COM pin scan direction
> +  - solomon,com-offset: Number of the COM pin wired to the first display line
> +  - solomon,prechargep1: Length of deselect period (phase 1) in clock cycles.
> +  - solomon,prechargep2: Length of precharge period (phase 2) in clock cycles.
> +                         This needs to be the higher, the higher the capacitance
> +                         of the OLED's pixels is
Aren't the height, width and page-offset also optional? They should be 
set to sane defaults when not supplied. Though the default (which is the 
max really) width/height depends on the actual attached display to the 
chip (I mention this in the vcomh section too below, the controller's 
width/height would be the absolute maximum values, the display can 
always be smaller).

Same goes to say for the precharge, and probably other parameters. I 
don't think we have a proper framework to handle the attached displays 
to a controller chip at the moment anyhow?

>
>   [0]: Documentation/devicetree/bindings/pwm/pwm.txt
>
<snip>
> +
> +	/* Set COM direction */
> +	com_invdir = 0xc0 | (par->com_invdir & 0xf) << 3;
Shouldn't this be par->com_invdir & 0x1 ?
The datasheet only mentions 1 bit change for the ssd1306, ssd1307 and 
ssd1309. I dont' know what the ssd1305 does here though.

> +	ret = ssd1307fb_write_cmd(par->client,  com_invdir);
>   	if (ret < 0)
>   		return ret;
<snip>
>
> -	ret = ssd1307fb_write_cmd(par->client, 0x14);
> -	if (ret < 0)
> -		return ret;
> +		ret = ssd1307fb_write_cmd(par->client, 0x14);
> +		if (ret < 0)
> +			return ret;
> +	};
I had to look hard for this setting, as my old datasheet had omitted the 
charge pump def.

but wouldn't you want something like (0x10 | 
par->device_info->need_chargepump & 0x1 << 2) & 0x14 to follow your 
previous styles?

Only bit 2 determines the state of the charge-pump. And I guess it 
should be safe to use on the other chips as well. My 1309 doesn't seem 
to have a problem with it, I'm working a lot on this display so it will 
be tested thoroughly in the next few weeks.

>
>   	/* Switch to horizontal addressing mode */
>   	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_ADDRESS_MODE);
> @@ -393,6 +390,7 @@ static int ssd1307fb_ssd1306_init(struct ssd1307fb_par *par)
>   	if (ret < 0)
>   		return ret;
>
<snip>
>
> -static struct ssd1307fb_ops ssd1307fb_ssd1306_ops = {
> -	.init	= ssd1307fb_ssd1306_init,
> +static struct ssd1307fb_deviceinfo ssd1307fb_ssd1306_deviceinfo = {
> +	.default_vcomh = 0x20,
> +	.default_dclk_div = 0,
> +	.default_dclk_frq = 8,
> +	.need_pwm = 0,
> +	.need_chargepump = 1,
> +};
This device info struct, is this really always fixed data? We use a 
ssd1309 with a MI12864MO i think and the combination of these two parts 
defines atleast the vcomh I would imagine? There are only a very limited 
number of consumers of this driver so for now it won't make much of a 
difference, just mentioning it as it is a configurable so it may matter 
depending on the physical display.
> +
> +static struct ssd1307fb_deviceinfo ssd1307fb_ssd1307_deviceinfo = {
> +	.default_vcomh = 0x20,
> +	.default_dclk_div = 1,
> +	.default_dclk_frq = 12,
> +	.need_pwm = 1,
> +	.need_chargepump = 0,
>   };
>
>   static const struct of_device_id ssd1307fb_of_match[] = {
>   	{
>   		.compatible = "solomon,ssd1306fb-i2c",
> -		.data = (void *)&ssd1307fb_ssd1306_ops,
> +		.data = (void *)&ssd1307fb_ssd1306_deviceinfo,
>   	},
>   	{
>   		.compatible = "solomon,ssd1307fb-i2c",
> -		.data = (void *)&ssd1307fb_ssd1307_ops,
> +		.data = (void *)&ssd1307fb_ssd1307_deviceinfo,
>   	},
>   	{},
>   };
> @@ -468,8 +479,8 @@ static int ssd1307fb_probe(struct i2c_client *client,
>   	par->info = info;
>   	par->client = client;
>
> -	par->ops = (struct ssd1307fb_ops *)of_match_device(ssd1307fb_of_match,
> -							   &client->dev)->data;
> +	par->device_info = (struct ssd1307fb_deviceinfo *)of_match_device(
> +			ssd1307fb_of_match, &client->dev)->data;
>
>   	par->reset = of_get_named_gpio(client->dev.of_node,
>   					 "reset-gpios", 0);
> @@ -487,6 +498,27 @@ static int ssd1307fb_probe(struct i2c_client *client,
>   	if (of_property_read_u32(node, "solomon,page-offset", &par->page_offset))
>   		par->page_offset = 1;
While your re-doing the whole driver, why use a default page_offset of 
1? 0 makes far more sense (its the default on my board also) and 
logically, we'd start counting at 0 as programmers ;) Also, the 
datasheet uses 0 as a default preset.

>
> +	if (of_property_read_u32(node, "solomon,com-offset", &par->com_offset))
> +		par->com_offset = 0;
> +
> +	if (of_property_read_u32(node, "solomon,prechargep1", &par->prechargep1))
> +		par->prechargep1 = 2;
> +
> +	if (of_property_read_u32(node, "solomon,prechargep2", &par->prechargep2))
> +		par->prechargep2 = 0;
Why set the default to 0 here? The datasheet sets it to 0x2 by default 
for example.
> +
> +	par->seg_remap = !of_property_read_bool(node, "solomon,segment-no-remap");
> +	par->com_seq = of_property_read_bool(node, "solomon,com-sequential");
all the other parameters are somewhat abbreviated, or the property name 
matches the variable name. I'd just abbreviate it to com-seq clear and 
short.


Overal, the driver works and can have a Tested-by: Olliver Schinagl 
<o.schinagl@ultimaker.com> from me (for the 1309 which I'll submit very 
soon.

Olliver

P.S. Do you have a link for your display? I'm curious as to how it looks.
