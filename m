From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date: Tue, 28 Oct 2014 16:47:22 +0000
Subject: Re: [PATCH 06/15] video: lcd: add LoCoMo LCD driver
Message-Id: <544FC89A.80503@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com> <1414454528-24240-7-git-send-email-dbaryshkov@gmail.com> <000101cff246$6d229850$4767c8f0$%han@samsung.com>
In-Reply-To: <000101cff246$6d229850$4767c8f0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, 'Andrea Adami' <andrea.adami@gmail.com>, 'Russell King' <linux@arm.linux.org.uk>, 'Daniel Mack' <daniel@zonque.org>, 'Haojian Zhuang' <haojian.zhuang@gmail.com>, 'Robert Jarzmik' <robert.jarzmik@free.fr>, 'Linus Walleij' <linus.walleij@linaro.org>, 'Alexandre Courbot' <gnurou@gmail.com>, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, 'Bryan Wu' <cooloney@gmail.com>, 'Richard Purdie' <rpurdie@rpsys.net>, 'Samuel Ortiz' <sameo@linux.intel.com>, 'Lee Jones' <lee.jones@linaro.org>, 'Mark Brown' <broonie@kernel.org>, 'Liam Girdwood' <lgirdwood@gmail.com>

On 10/28/2014 03:30 AM, Jingoo Han wrote:
> On Tuesday, October 28, 2014 9:02 AM, Dmitry Eremin-Solenikov wrote:
>>
>> LoCoMo has some special handling for TFT screens attached to Collie and
>> Poodle. Implement that as a separate driver.

Thanks for the review, changes for both LCD and Backlight will be 
implemented in V2.


-- 
With best wishes
Dmitry
