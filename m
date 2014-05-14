From: Jyri Sarha <jsarha@ti.com>
Date: Wed, 14 May 2014 10:02:22 +0000
Subject: Re: [alsa-devel] [PATCH 00/19] Rework OMAP4+ HDMI audio support
Message-Id: <53733F2E.4030803@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1399884780.git.jsarha@ti.com> <CAGhQ9VzjndCBp+ZHS3XPPvS4ors6u9BfHf4NY_HNYN5ynyQOYQ@mail.gmail.com>
In-Reply-To: <CAGhQ9VzjndCBp+ZHS3XPPvS4ors6u9BfHf4NY_HNYN5ynyQOYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joachim Eastwood <manabian@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, broonie@kernel.org, peter.ujfalusi@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Benoit Cousson <bcousson@baylibre.com>

On 05/13/2014 12:13 AM, Joachim Eastwood wrote:
> On 12 May 2014 11:12, Jyri Sarha <jsarha@ti.com> wrote:
...
>
> hey, this worked straight away :)
>
> But there seems to be something wrong with the channel mapping.
>
> For stereo (speaker-test -c 2) the mapping is correct.
>
> But for -c 4 and -c 8 it gets weird:
> speaker-test -c 4 -s X # where X is 1-4
> 1: Front Left is Rear Left
> 2: Front Right is Rear Right
> 3: Rear Right is Front Right
> 4: Rear Left is Front Left
>
> speaker-test -c 8 -s X # where X is 1-8
> 1: Front Left is Rear Left
> 2: Center is Rear Left
> 3: Front Right is Rear Right
> 4: Side Right is Front Right
> 5: Rear Right is silent
> 6: Rear Left is Center
> 7: Side Left is Front Left
> 8: LFE - Rear Right
>
> I think you need to check what channel order ALSA expects. I believe
> speaker-test does the right thing on my HTPC normally connected to my
> receiver.
>

I checked the implementation and there was indeed something weird there, 
but the implementation can not explain the FL and FR channels jumping 
around. FL and FL should always be the first two channels in all 
configurations and the implementation does not touch them.

The implementation uses 8ch HDMI setup for anything above 2ch with 
"Audio InfoFrame Data Byte 4" set to 0x13. According to CEA-861 specs 
this means following channel order: FL, FR, LFE, FC, RL, RR, RLC, RRC

This is a closest match to ALSA 8ch mapping (according to 
sound/core/pcm_lib.c) which is: FL, FR, FC, LFE, RL, RR, SL, SR

Current implementation has FLE and FC channels correctly swapped, but it 
shifts them to last two channels and RL, RR, SL, SR are shifted down to 
fill the place. This is all wrong and I'll try to come up with a fix for 
that. Unfortunately I can not test anything beyond 2 ch myself so I 
would need someone to volunteer to test my patch.

Best regards,
Jyri
