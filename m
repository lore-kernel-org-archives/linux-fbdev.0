From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 23 Jul 2019 15:38:13 +0000
Subject: Re: [PATCH 0/6] video: ssd1307fb: Support more displays
Message-Id: <f0d8be30-4980-7e7c-dcbb-3bd7621cff08@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190618074155epcas1p3fcfe7cf1058162c11e4b1780987ca394@epcas1p3.samsung.com>
 <20190618074111.9309-1-marko.kohtala@okoko.fi>
In-Reply-To: <20190618074111.9309-1-marko.kohtala@okoko.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marko Kohtala <marko.kohtala@okoko.fi>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>


On 6/18/19 9:41 AM, Marko Kohtala wrote:
> The kernel driver for ssd1307fb did not allow for all proper
> initialization for a Densitron 128x36 display. The trend in the driver
> has been to add devicetree properties for the controller initialization
> and these patches continue on that trend.
> 
> There also were some sparse and Coccinelle errors.
> 
> A small bug causing scrolling on display updates with nonzero page_offset
> was a bit surprising. It would seem the driver has only been used with
> page_offset set to zero. Bug has been there since commit
> 301bc0675b677a98475187050d56cd2b39ff0acf ("video: ssd1307fb: Make use of
> horizontal addressing mode").
> 
> Marko Kohtala (6):
>   video: ssd1307fb: Use screen_buffer instead of screen_base
>   video: ssd1307fb: Remove unneeded semicolons
>   video: ssd1307fb: Start page range at page_offset
>   video: ssd1307fb: Handle width and height that are not multiple of 8
>   dt-bindings: display: ssd1307fb: Add initialization properties
>   video: ssd1307fb: Add devicetree configuration of display setup
> 
>  .../devicetree/bindings/display/ssd1307fb.txt |  10 ++
>  drivers/video/fbdev/ssd1307fb.c               | 130 ++++++++++++------
>  2 files changed, 101 insertions(+), 39 deletions(-)
Patch series queued for v5.4, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
