From: Gyungoh Yoo <gyungoh@gmail.com>
Date: Thu, 05 Feb 2015 04:59:10 +0000
Subject: Re: [PATCH v10 4/6] devicetree: Add new SKY81452 backlight binding
Message-Id: <20150205045910.GA4234@jack-ThinkPad-T520>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421994515-3070-1-git-send-email-jack.yoo@skyworksinc.com>
 <1421994515-3070-5-git-send-email-jack.yoo@skyworksinc.com>
 <CAL_JsqJHvpmBY4RDBWFA3RqQ9h_Yf25iSFxQe9oTNdSPybi87g@mail.gmail.com>
In-Reply-To: <CAL_JsqJHvpmBY4RDBWFA3RqQ9h_Yf25iSFxQe9oTNdSPybi87g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org, hs-ynQEQJNshbs@public.gmane.org, "Opensource [Steve Twiss]" <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, matti.vaittinen-OYasijW0DpE@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, Andrew Lunn <andrew@l>

On Wed, Feb 04, 2015 at 09:11:22AM -0600, Rob Herring wrote:
> On Fri, Jan 23, 2015 at 12:28 AM,  <gyungoh@gmail.com> wrote:
> > From: Gyungoh Yoo <jack.yoo@skyworksinc.com>
> >
> > Signed-off-by: Gyungoh Yoo <jack.yoo@skyworksinc.com>
> > Acked-by: Bryan Wu <cooloney@gmail.com>
> > ---
> > Changes v10:
> > Nothing
> >
> > Changes v9:
> > Nothing
> >
> > Changes v8:
> > Renamed property names for backlight with vendor prefix
> > Modified gpio-enable property to generic property for GPIO
> > Made up the example for backlight DT
> >
> > Changes v7:
> > Nothing
> >
> > Changes v6:
> > Nothing
> >
> > Changes v5:
> > Nothing
> >
> > Changes v4:
> > Nothing
> >
> > Changes v3:
> > Nothing
> >
> > Changes v2:
> > Added reg attribute for I2C slave address
> 
> You did? Where is it?

It was just changes on version 2.
Since that version, the patch series was separted.

> 
> >  .../video/backlight/sky81452-backlight.txt         | 29 ++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/video/backlight/sky81452-backlight.txt
> >
> > diff --git a/Documentation/devicetree/bindings/video/backlight/sky81452-backlight.txt b/Documentation/devicetree/bindings/video/backlight/sky81452-backlight.txt
> > new file mode 100644
> > index 0000000..8daebf5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/video/backlight/sky81452-backlight.txt
> > @@ -0,0 +1,29 @@
> > +SKY81452-backlight bindings
> > +
> > +Required properties:
> > +- compatible           : Must be "skyworks,sky81452-backlight"
> > +
> > +Optional properties:
> > +- name                 : Name of backlight device. Default is 'lcd-backlight'.
> > +- gpios                        : GPIO to use to EN pin.
> > +                       See Documentation/devicetree/bindings/gpio/gpio.txt
> > +- skyworks,en-channels : Enable mask for current sink channel 1 to 6.
> 
> Does led-sources property being added in 3.20 work for this?

I think so. I will modify it.

> 
> > +- skyworks,ignore-pwm  : Ignore both PWM input
> > +- skyworks,dpwm-mode   : Enable DPWM dimming mode, otherwise Analog dimming.
> > +- skyworks,phase-shift : Enable phase shift mode
> > +- skyworks,ovp-level   : Over-voltage protection level.
> > +                       Should be between 14 or 28V.
> 
> Please append units (-volt)

I will append it and resubmit the patch.

Thanks.

> 
> > +- skyworks,short-detection-threshold   : It should be one of 4, 5, 6 and 7V.
> 
> Please append units (-volt)
> 
> > +- skyworks,current-limit       : It should be 2300mA or 2750mA.
> 
> Please append units (-mA)
> 
> > +
> > +Example:
> > +
> > +       backlight {
> > +               compatible = "skyworks,sky81452-backlight";
> > +               name = "pwm-backlight";
> > +               skyworks,en-channels = <0x3f>;
> > +               skyworks,ignore-pwm;
> > +               skyworks,phase-shift;
> > +               skyworks,ovp-level = <20>;
> > +               skyworks,current-limit = <2300>;
> > +       };
> > --
> > 1.9.1
> >
