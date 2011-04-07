From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Date: Thu, 07 Apr 2011 09:57:17 +0000
Subject: RE: [PATCH] drivers, video: Add a check for strict_strtoul()
Message-Id: <544AC56F16B56944AEC3BD4E3D59177137546742CA@LIMKCMBX1.ad.analog.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1302167178-9216-1-git-send-email-namei.unix@gmail.com>
In-Reply-To: <1302167178-9216-1-git-send-email-namei.unix@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Liu Yuan wrote on 2011-04-07:
> From: Liu Yuan <tailai.ly@taobao.com>
>
> It should check if strict_strtoul() succeeds.This patch fixes it.
>
> Signed-off-by: Liu Yuan <tailai.ly@taobao.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/video/backlight/adp5520_bl.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> diff --git a/drivers/video/backlight/adp5520_bl.c
> b/drivers/video/backlight/adp5520_bl.c index af31197..fdef632 100644 ---
> a/drivers/video/backlight/adp5520_bl.c +++
> b/drivers/video/backlight/adp5520_bl.c @@ -212,7 +212,9 @@ static
> ssize_t adp5520_bl_daylight_max_store(struct device *dev,  {
>       struct adp5520_bl *data = dev_get_drvdata(dev);
> -     strict_strtoul(buf, 10, &data->cached_daylight_max);
> +     if (strict_strtoul(buf, 10, &data->cached_daylight_max) < 0)
> +             return -EINVAL;
> +
>       return adp5520_store(dev, buf, count, ADP5520_DAYLIGHT_MAX);  }
> static DEVICE_ATTR(daylight_max, 0664, adp5520_bl_daylight_max_show,

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif

