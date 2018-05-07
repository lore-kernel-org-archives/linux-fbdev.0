From: Rob Herring <robh@kernel.org>
Date: Mon, 07 May 2018 16:45:34 +0000
Subject: Re: [PATCH V2 2/5] backlight: qcom-wled: Add support for WLED4 peripheral
Message-Id: <20180507164534.GB21042@rob-hp-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1525342352-25072-1-git-send-email-kgunda@codeaurora.org>
 <1525342352-25072-3-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1525342352-25072-3-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, bjorn.andersson@linaro.org, linux-fbdev@vger.kernel.org, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-arm-msm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org

On Thu, May 03, 2018 at 03:42:29PM +0530, Kiran Gunda wrote:
> WLED4 peripheral is present on some PMICs like pmi8998
> and pm660l. It has a different register map and also
> configurations are different. Add support for it.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
>  .../bindings/leds/backlight/qcom-wled.txt          | 172 ++++-

Please split bindings to a separate patch.

This is also a whole lot of churn re-formatting. That is fine, but don't 
mix actual changes to the binding with re-formatting. You can do 2 
patches in this case: 

- move and reformat (as long as the move shows up as a move 
and not a remove and add) 
- additions for new chips

>  drivers/video/backlight/qcom-wled.c                | 749 +++++++++++++++------
>  2 files changed, 696 insertions(+), 225 deletions(-)
