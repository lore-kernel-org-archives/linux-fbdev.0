From: kgunda@codeaurora.org
Date: Mon, 20 Nov 2017 11:54:58 +0000
Subject: Re: [PATCH V1 2/4] qcom: spmi-wled: Add support for short circuit handling
Message-Id: <55de69a721a1806ed9beec6ae36b6572@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1510834717-21765-1-git-send-email-kgunda@codeaurora.org>
 <1510834717-21765-3-git-send-email-kgunda@codeaurora.org>
 <20171117203014.66r2n6x5mwuc6doe@rob-hp-laptop>
In-Reply-To: <20171117203014.66r2n6x5mwuc6doe@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Mark Rutland <mark.rutland@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org

On 2017-11-18 02:00, Rob Herring wrote:
> On Thu, Nov 16, 2017 at 05:48:35PM +0530, Kiran Gunda wrote:
>> Handle the short circuit(SC) interrupt and check if the SC interrupt
>> is valid. Re-enable the module to check if it goes away. Disable the
>> module altogether if the SC event persists.
>> 
>> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
>> ---
>>  .../bindings/leds/backlight/qcom-spmi-wled.txt     |  22 ++++
> 
> ... and also put all the binding in one patch. I want to review the 
> full
> view of the h/w, not piecemeal.
> 
Sure. Will send the next series with the changes suggested.
>>  drivers/video/backlight/qcom-spmi-wled.c           | 126 
>> ++++++++++++++++++++-
>>  2 files changed, 142 insertions(+), 6 deletions(-)
