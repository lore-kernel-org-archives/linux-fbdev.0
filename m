From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Mon, 20 Apr 2020 16:17:20 +0000
Subject: Re: [PATCH V5 2/4] backlight: qcom-wled: Add callback functions
Message-Id: <20200420161720.cuxponga4vxitrwi@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1586274430-28402-1-git-send-email-kgunda@codeaurora.org>
 <1586274430-28402-3-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1586274430-28402-3-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, b.zolnierkie@samsung.com, jingoohan1@gmail.com, Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, bjorn.andersson@linaro.org, robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, linux-arm-msm@vger.kernel.org, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, lee.jones@linaro.org, linux-leds@vger.kernel.org

On Tue, Apr 07, 2020 at 09:17:08PM +0530, Kiran Gunda wrote:
> Add wled_cabc_config, wled_sync_toggle, wled_ovp_fault_status
> and wled_ovp_delay and wled_auto_detection_required callback
> functions to prepare the driver for adding WLED5 support.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> Signed-off-by: Subbaraman Narayanamurthy <subbaram@codeaurora.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
