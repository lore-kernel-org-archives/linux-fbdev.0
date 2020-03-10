From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 10 Mar 2020 15:27:19 +0000
Subject: Re: [PATCH V3 2/4] backlight: qcom-wled: Add callback functions
Message-Id: <20200310152719.5hpzh6osq22y4qbn@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1583760362-26978-1-git-send-email-kgunda@codeaurora.org>
 <1583760362-26978-3-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1583760362-26978-3-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, b.zolnierkie@samsung.com, jingoohan1@gmail.com, Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, bjorn.andersson@linaro.org, robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, linux-arm-msm@vger.kernel.org, lee.jones@linaro.org, linux-leds@vger.kernel.org

On Mon, Mar 09, 2020 at 06:56:00PM +0530, Kiran Gunda wrote:
> Add cabc_config, sync_toggle, wled_ovp_fault_status and wled_ovp_delay
> callback functions to prepare the driver for adding WLED5 support.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>

Overall this code would a lot easier to review if
> ---
>  drivers/video/backlight/qcom-wled.c | 196 +++++++++++++++++++++++-------------
>  1 file changed, 126 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index 3d276b3..b73f273 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -128,6 +128,7 @@ struct wled_config {
>  	bool cs_out_en;
>  	bool ext_gen;
>  	bool cabc;
> +	bool en_cabc;

Does this ever get set to true?

>  	bool external_pfet;
>  	bool auto_detection_enabled;
>  };
> @@ -147,14 +148,20 @@ struct wled {
>  	u32 max_brightness;
>  	u32 short_count;
>  	u32 auto_detect_count;
> +	u32 version;
>  	bool disabled_by_short;
>  	bool has_short_detect;
> +	bool cabc_disabled;
>  	int short_irq;
>  	int ovp_irq;
>  
>  	struct wled_config cfg;
>  	struct delayed_work ovp_work;
>  	int (*wled_set_brightness)(struct wled *wled, u16 brightness);
> +	int (*cabc_config)(struct wled *wled, bool enable);
> +	int (*wled_sync_toggle)(struct wled *wled);
> +	int (*wled_ovp_fault_status)(struct wled *wled, bool *fault_set);
> +	int (*wled_ovp_delay)(struct wled *wled);

Let's get some doc comments explaining what these callbacks do (and
which versions they apply to).

cabc_config() in particular appears to have a very odd interface for
wled4.  It looks like it relies on being initially called with enable
set a particular way and prevents itself from acting again. Therefore if
the comment you end up writing doesn't sound "right" then please also
fix the API!

Finally, why is everything except cabc_config() prefixed with wled?


Daniel.
