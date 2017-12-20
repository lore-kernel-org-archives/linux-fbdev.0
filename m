From: Felix Brack <fb@ltec.ch>
Date: Wed, 20 Dec 2017 16:35:24 +0000
Subject: Re: [PATCH] Add support for ORISE OTM3225A LCD SoC
Message-Id: <cde8376c-8217-6cfd-0a0a-b90b75892bea@ltec.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1509714581-4065-1-git-send-email-fb@ltec.ch>
In-Reply-To: <1509714581-4065-1-git-send-email-fb@ltec.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, b.zolnierkie@samsung.com
Cc: linux-kernel@vger.kernel.org

Just a gentle echo request ;-)
Is there something completely wrong with this patch or am I just too
impatient?

regards Felix

On 03.11.2017 14:09, Felix Brack wrote:
> This patch adds a LCD driver supporting the OTM3225A LCD SoC
> from ORISE Technology. This device can drive TFT LC panels having a
> resolution of 240x320 pixels. After initializing the OTM3225A using
> it's SPI interface it switches to use 16-bib RGB as external
> display interface.
> 
> Signed-off-by: Felix Brack <fb@ltec.ch>
> ---
