From: Rob Herring <robh@kernel.org>
Date: Thu, 10 Nov 2016 19:25:58 +0000
Subject: Re: [PATCH 2/2] backlight: arcxcnn: devicetree bindings for ArticSand devices
Message-Id: <20161110192558.ckyc6wv6mhsdousj@rob-hp-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1478197768-3694-1-git-send-email-olimpiu@arcticsand.com>
In-Reply-To: <1478197768-3694-1-git-send-email-olimpiu@arcticsand.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Olimpiu Dejeu <olimpiu@arcticsand.com>
Cc: lee.jones@linaro.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, jg1.han@samsung.com

On Thu, Nov 03, 2016 at 02:29:28PM -0400, Olimpiu Dejeu wrote:
> Resubmition of arcxcnn backliught driver addressing the naming convention

s/Resubmition/Re-submission/
s/backliught/backlight/

>  concerns raised by Rob H. Note that all the device tree properties are
>  determined by the board design or IC EPROM settings and are not intended
>  to be user adjustable.
> 
> Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>
> 
> ---
>  .../bindings/leds/backlight/arcxcnn_bl.txt         | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt

With that,

Acked-by: Rob Herring <robh@kernel.org>
