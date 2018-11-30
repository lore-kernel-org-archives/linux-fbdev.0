From: Brian Masney <masneyb@onstation.org>
Date: Fri, 30 Nov 2018 13:59:27 +0000
Subject: Re: [PATCH 1/2] dt-bindings: trivial: add ti,lm3630a binding
Message-Id: <20181130135927.GA27500@basecamp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181124141703.29232-1-masneyb@onstation.org>
 <20181127105642.uu56phxjfl7bjl2p@holly.lan>
In-Reply-To: <20181127105642.uu56phxjfl7bjl2p@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: lee.jones@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jonathan@marek.ca, ctatlor97@gmail.com

On Tue, Nov 27, 2018 at 10:56:42AM +0000, Daniel Thompson wrote:
> On Sat, Nov 24, 2018 at 09:17:02AM -0500, Brian Masney wrote:
> > Add a trivial binding for the Texas Instruments LM3630A Backlight Chip.
> 
> It's quite unusual for a backlight device to have a trivial binding.
> 
> The driver supports fairly extensive parametrization via struct
> lm3530a_platform_data. It is really the case that none of these
> properties should ever be set via DT?

Hi Daniel,

I initially assumed that we would let user space configure these values
once the system has booted, but you are right that these should be
available in device tree.
 
The driver has two different LED banks that can be configured
independently. How do you feel about having a single property in
device tree populate the initial values for both banks? I propose that
we could use the property default-brightness-level for leda_init_brt
and ledb_init_brt in struct lm3630a_platform_data. The max-brightness
property can populate leda_max_brt and ledb_max_brt.

I need to look at other bindings this weekend to see if there are any
standard properties that I can use for leda_ctrl/ledb_ctrl, pwm_ctrl,
and pwm_period.

Brian


> 
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > ---
> >  Documentation/devicetree/bindings/trivial-devices.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
> > index 6ab001fa1ed4..86486368dc35 100644
> > --- a/Documentation/devicetree/bindings/trivial-devices.txt
> > +++ b/Documentation/devicetree/bindings/trivial-devices.txt
> > @@ -182,6 +182,7 @@ taos,tsl2550		Ambient Light Sensor with SMBUS/Two Wire Serial Interface
> >  ti,ads7828		8-Channels, 12-bit ADC
> >  ti,ads7830		8-Channels, 8-bit ADC
> >  ti,amc6821		Temperature Monitoring and Fan Control
> > +ti,lm3630a		Texas Instruments LM3630A Backlight Chip
> >  ti,tsc2003		I2C Touch-Screen Controller
> >  ti,tmp102		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
> >  ti,tmp103		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
> > -- 
> > 2.17.2
> > 
