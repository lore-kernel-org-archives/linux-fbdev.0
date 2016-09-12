From: Rob Herring <robh@kernel.org>
Date: Mon, 12 Sep 2016 15:47:20 +0000
Subject: Re: [PATCH] video: mxsfb: get supply regulator optionally
Message-Id: <20160912154720.GA31424@rob-hp-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160904042627.30182-1-stefan@agner.ch>
In-Reply-To: <20160904042627.30182-1-stefan-XLVq0VzYD2Y@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Cc: plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sat, Sep 03, 2016 at 09:26:27PM -0700, Stefan Agner wrote:
> The lcd-supply is meant to be optional, there are several device-
> trees not specifying it and the code handles error values silently.
> Therefor, avoid creating a dummy regulator (and the associated
> warning) by using devm_regulator_get_optional.
> 
> While at it, document that fact also in the device-tree bindings.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  Documentation/devicetree/bindings/display/mxsfb.txt | 3 +++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/video/fbdev/mxsfb.c                         | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
