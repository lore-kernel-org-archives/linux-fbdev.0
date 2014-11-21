From: Jyri Sarha <jsarha@ti.com>
Date: Fri, 21 Nov 2014 12:35:07 +0000
Subject: Re: [PATCH v7.1 00/19] Rework OMAP4+ HDMI audio support
Message-Id: <546F317B.9030004@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1415803064.git.jsarha@ti.com> <20141112222344.GU3815@sirena.org.uk> <54646648.5030807@ti.com> <546DC9A0.8060700@ti.com> <20141121112317.GQ3815@sirena.org.uk>
In-Reply-To: <20141121112317.GQ3815@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com

On 11/21/2014 01:23 PM, Mark Brown wrote:
> With this specific series I also need to figure out what all the video
> side is about (like I said earlier a lot of the patches look like
> they're supposed to be simple fixes for the video code not terribly
> closely tied to the rest of the series but none of them are getting
> applied) and what the end goal is beyond mechanically moving code.

(Sorry, I forgot to comment this part.)

The end goal of this series is to fix OMAP HDMI audio, that got broken 
couple of releases ago. At the same time I cleaned up the old complex 
scheme to make the connection between the video and audio parts and 
allow multiple HDMI devices (DSS side is not ready for this yet, but 
audio side is).

Another target was to make configuring the audio as simple as possible. 
Because everything needed for HDMI audio is always there if the video 
side is correctly configured, there should be no need for any additional 
configuration (in DT or otherwise) to get the audio working. Now simply 
selecting omap-hdmi-audio is enough. There is no complex cross 
dependencies to the video side any more, the audio driver simply does 
find its device if the HDMI video driver is not probed.

But indeed, in functional sense the whole series - apart from the couple 
of fixes in the beginning - is just moving the code around.

Best regards,
Jyri
