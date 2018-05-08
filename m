From: Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Tue, 08 May 2018 17:19:36 +0000
Subject: Re: [PATCH V1 4/5] backlight: qcom-wled: Add support for OVP interrupt handling
Message-Id: <20180508171936.GK2259@tuxbook-pro>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1525341432-15818-1-git-send-email-kgunda@codeaurora.org>
 <1525341432-15818-5-git-send-email-kgunda@codeaurora.org>
 <20180507172152.GD2259@tuxbook-pro>
 <3736480b2712e2dd401fed0a635a25d7@codeaurora.org>
In-Reply-To: <3736480b2712e2dd401fed0a635a25d7@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kgunda@codeaurora.org
Cc: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org

On Tue 08 May 05:26 PDT 2018, kgunda@codeaurora.org wrote:

> On 2018-05-07 22:51, Bjorn Andersson wrote:
> > On Thu 03 May 02:57 PDT 2018, Kiran Gunda wrote:
[..]
> > > @@ -220,7 +255,12 @@ static int wled_module_enable(struct wled
> > > *wled, int val)
> > >  				WLED3_CTRL_REG_MOD_EN,
> > >  				WLED3_CTRL_REG_MOD_EN_MASK,
> > >  				WLED3_CTRL_REG_MOD_EN_MASK);
> > > -	return rc;
> > > +	if (rc < 0)
> > > +		return rc;
> > > +
> > > +	schedule_delayed_work(&wled->ovp_work, WLED_SOFT_START_DLY_US);
> > 
> > Do you really want to delay the work on disable?
> > 
> > Wouldn't it be better to use a delay worker for the enablement and in
> > the disable case you cancel the work and just disable_irq() directly
> > here.
> > 
> Sure. Will do it in the next series.
> > But more importantly, if this is only related to auto detection, do you
> > really want to enable/disable the ovp_irq after you have detected the
> > string configuration?
> > 
> Ok. This is used for the genuine OVP detection and for the auto detection as
> well.

What is the expected outcome of detecting an OVP condition, outside auto
detection?

Regards,
Bjorn
