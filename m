From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Wed, 11 Mar 2020 10:30:47 +0000
Subject: Re: [PATCH V3 2/4] backlight: qcom-wled: Add callback functions
Message-Id: <20200311103047.v7rt5ii3saack22a@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1583760362-26978-1-git-send-email-kgunda@codeaurora.org>
 <1583760362-26978-3-git-send-email-kgunda@codeaurora.org>
 <20200310152719.5hpzh6osq22y4qbn@holly.lan>
 <05ab744dfbd83b6704bd394ce3c3dfc9@codeaurora.org>
In-Reply-To: <05ab744dfbd83b6704bd394ce3c3dfc9@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kgunda@codeaurora.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, b.zolnierkie@samsung.com, jingoohan1@gmail.com, Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, bjorn.andersson@linaro.org, robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, linux-arm-msm@vger.kernel.org, lee.jones@linaro.org, linux-arm-msm-owner@vger.kernel.org, linux-leds@vger.kernel.org

On Wed, Mar 11, 2020 at 12:11:00PM +0530, kgunda@codeaurora.org wrote:
> On 2020-03-10 20:57, Daniel Thompson wrote:
> > On Mon, Mar 09, 2020 at 06:56:00PM +0530, Kiran Gunda wrote:
> > > Add cabc_config, sync_toggle, wled_ovp_fault_status and wled_ovp_delay
> > > callback functions to prepare the driver for adding WLED5 support.
> > > 
> > > Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> > 
> > Overall this code would a lot easier to review if
> > > ---
> > >  drivers/video/backlight/qcom-wled.c | 196
> > > +++++++++++++++++++++++-------------
> > >  1 file changed, 126 insertions(+), 70 deletions(-)
> > > 
> > > diff --git a/drivers/video/backlight/qcom-wled.c
> > > b/drivers/video/backlight/qcom-wled.c
> > > index 3d276b3..b73f273 100644
> > > --- a/drivers/video/backlight/qcom-wled.c
> > > +++ b/drivers/video/backlight/qcom-wled.c
> > > @@ -128,6 +128,7 @@ struct wled_config {
> > >  	bool cs_out_en;
> > >  	bool ext_gen;
> > >  	bool cabc;
> > > +	bool en_cabc;
> > 
> > Does this ever get set to true?
> > 
> Yes. If user wants use the cabc pin to control the brightness and
> use the "qcom,cabc" DT property in the device tree.

That sounds like what you intended the code to do!

Is the code that does this present in the patch? I could not find
it.


Daniel.
