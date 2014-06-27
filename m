From: Jyri Sarha <jsarha@ti.com>
Date: Fri, 27 Jun 2014 12:26:35 +0000
Subject: Re: [PATCH 04/12] OMAPDSS: hdmi_audio: Integrated ASoC DAI component driver implementation
Message-Id: <53AD62FB.10402@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1403807781.git.jsarha@ti.com> <69f5b1481bd8b8a005b5d9142626f3529a0d71c7.1403807781.git.jsarha@ti.com> <53AD5F65.2010107@ti.com>
In-Reply-To: <53AD5F65.2010107@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, jyri.sarha@iki.fi

On 06/27/2014 03:11 PM, Tomi Valkeinen wrote:
> On 26/06/14 22:20, Jyri Sarha wrote:
...
>> +static struct asoc_simple_card_info card_info = {
>> +	.name = "HDMI",
>> +	.card = "OMAPHDMI",
>> +	.codec_dai.name = "hdmi-hifi",
>> +};
>
> The above is not const. That, and the contents of the struct make me
> wonder, what happens if we have two HDMI instances?
>
> I know the core driver doesn't work with multiple instances yet, but as
> I mentioned, it has to be done sooner or later. And on the core driver
> side it should be quite straightforward.
>
> I'd rather not introduce new restrictions for that goal.
>

Ok, I'll alloc that with devm_kzalloc().

Cheers,
Jyri
