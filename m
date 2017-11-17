From: Rob Herring <robh@kernel.org>
Date: Fri, 17 Nov 2017 20:30:14 +0000
Subject: Re: [PATCH V1 2/4] qcom: spmi-wled: Add support for short circuit handling
Message-Id: <20171117203014.66r2n6x5mwuc6doe@rob-hp-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1510834717-21765-1-git-send-email-kgunda@codeaurora.org>
 <1510834717-21765-3-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1510834717-21765-3-git-send-email-kgunda-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kiran Gunda <kgunda-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <jacek.anaszewski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Nov 16, 2017 at 05:48:35PM +0530, Kiran Gunda wrote:
> Handle the short circuit(SC) interrupt and check if the SC interrupt
> is valid. Re-enable the module to check if it goes away. Disable the
> module altogether if the SC event persists.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
>  .../bindings/leds/backlight/qcom-spmi-wled.txt     |  22 ++++

... and also put all the binding in one patch. I want to review the full 
view of the h/w, not piecemeal.

>  drivers/video/backlight/qcom-spmi-wled.c           | 126 ++++++++++++++++++++-
>  2 files changed, 142 insertions(+), 6 deletions(-)
