From: Brian Masney <masneyb@onstation.org>
Date: Wed, 17 Apr 2019 15:10:49 +0000
Subject: Re: [PATCH v4 2/3] dt-bindings: backlight: add lm3630a bindings
Message-Id: <20190417151049.GA18138@basecamp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190416235350.13742-1-masneyb@onstation.org>
 <20190416235350.13742-3-masneyb@onstation.org>
 <CAL_Jsq+YnjDGmLODXy6M1GpixMV=spfc809atGkrighvy=QPHg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+YnjDGmLODXy6M1GpixMV=spfc809atGkrighvy=QPHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Mark Rutland <mark.rutland@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>, Jonathan Marek <jonathan@marek.ca>

On Wed, Apr 17, 2019 at 08:34:33AM -0500, Rob Herring wrote:
> On Tue, Apr 16, 2019 at 6:54 PM Brian Masney <masneyb@onstation.org> wrote:
> >
> > Add new backlight bindings for the TI LM3630A dual-string white LED.
> >
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > ---
> > Rob: Since the common bindings aren't converted to the new JSON schema
> > yet, I'm not sure how to do led-sources here. I would expect that we'd
> > have the uint32-array on the common binding once it exists. I had to
> > add it here to keep 'make dt_binding_check' happy. I left the
> > description off though for that property since that'll come from common
> > once its converted.
> 
> What was the error? '$ref' shouldn't be needed for this. The tooling
> has no knowledge whether there's common schema or not. So you probably
> have some pattern the meta-schema doesn't like and we need to fix.

Ahh, you're right... it works without the $ref. I just needed the
minItems and maxItems to fix the error I originally saw.

I'll wait for feedback from Dan before I send out another version with
your changes.

Thanks,

Brian
