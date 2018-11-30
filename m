From: Brian Masney <masneyb@onstation.org>
Date: Fri, 30 Nov 2018 14:25:40 +0000
Subject: Re: [PATCH 1/2] dt-bindings: trivial: add ti,lm3630a binding
Message-Id: <20181130142540.GB27500@basecamp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181124141703.29232-1-masneyb@onstation.org>
 <20181127105642.uu56phxjfl7bjl2p@holly.lan>
 <20181130135927.GA27500@basecamp>
 <CAL_Jsq+-AZFf==911Pmf_ObUk+3VQgC+2+BvQ9q8LyQ_v=FdOA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+-AZFf==911Pmf_ObUk+3VQgC+2+BvQ9q8LyQ_v=FdOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt@kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel <dri-devel@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jonathan Marek <jonathan@marek.ca>, Craig Tatlor <ctatlor97@gmail.com>, Dan Murphy <dmurphy@ti.com>

On Fri, Nov 30, 2018 at 08:13:04AM -0600, Rob Herring wrote:
> > > It's quite unusual for a backlight device to have a trivial binding.
> > >
> > > The driver supports fairly extensive parametrization via struct
> > > lm3530a_platform_data. It is really the case that none of these
> > > properties should ever be set via DT?
> >
> > Hi Daniel,
> >
> > I initially assumed that we would let user space configure these values
> > once the system has booted, but you are right that these should be
> > available in device tree.
> >
> > The driver has two different LED banks that can be configured
> > independently.
> 
> That is usually represented with child nodes which makes this anything
> but trivial. Plus, given that we have bindings for LEDs/backlights, no
> LED/backlight controller is a trivial device.

Hi Rob,

I agree and I'm not going to use a trivial binding for v2. See below for
some questions that I have from my last email.


> > How do you feel about having a single property in
> > device tree populate the initial values for both banks? I propose that
> > we could use the property default-brightness-level for leda_init_brt
> > and ledb_init_brt in struct lm3630a_platform_data. The max-brightness
> > property can populate leda_max_brt and ledb_max_brt.
> >
> > I need to look at other bindings this weekend to see if there are any
> > standard properties that I can use for leda_ctrl/ledb_ctrl, pwm_ctrl,
> > and pwm_period.
> >
> > Brian
> >
