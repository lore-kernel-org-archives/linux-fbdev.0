Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6B1C54E76
	for <linux-fbdev@archiver.kernel.org>; Fri,  6 Jan 2023 17:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbjAFRrp (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 6 Jan 2023 12:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235822AbjAFRrM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 6 Jan 2023 12:47:12 -0500
X-Greylist: delayed 164 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 Jan 2023 09:47:11 PST
Received: from mailrelay6-1.pub.mailoutpod2-cph3.one.com (mailrelay6-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:405::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611A65B14A
        for <linux-fbdev@vger.kernel.org>; Fri,  6 Jan 2023 09:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=3ZkqwT//XG7BkpEaYP0t4/kQtbvC2cyH6nezkShj9GI=;
        b=CruGeZf3paWALutax0NxS9pNV1Lqs5S/DiNm+fMDSUuipD67l5jEADRaEHFPmzczMfTBfeE92VSTt
         X8eWLfcALcVDyhkyf68AhUj/hEG2mv5eGI0GKDWeZqkOsZmiGonwHr6u+8qrhDzmAXsQSB07FD1gx2
         YXvaIPdfFdcGJiKhEKONe0J3MNBaqaoOayBLvM3aOzL5BC9GXjxNseNvsNQPTc5dKWVcfDV29ZCdhH
         JIh/FRP4CGczAIaTHHTLcHXsIntRzgZDT5bUMM0Rjn436EpxjUEI+SCDxV8lco24XpkKHwXh47vyBD
         GB3vE0Z2ePsxuNK4djOwjvpRjD68uvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=3ZkqwT//XG7BkpEaYP0t4/kQtbvC2cyH6nezkShj9GI=;
        b=nT+VcIthoxhA8MnyKlBmjy04KeOPZMlHZv6M0+Vn/Scdjhuz3MDsqEzh6fZvTAmwNqGWCA8VWyn5o
         +FqYDFPBw==
X-HalOne-ID: 2298574e-8dea-11ed-af8f-cde5ad41a1dd
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay6 (Halon) with ESMTPSA
        id 2298574e-8dea-11ed-af8f-cde5ad41a1dd;
        Fri, 06 Jan 2023 17:47:09 +0000 (UTC)
Date:   Fri, 6 Jan 2023 18:47:07 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH RESEND 4/4] backlight: tosa: Use backlight helper
Message-ID: <Y7hem+T16FixeT0q@ravnborg.org>
References: <20230106164856.1453819-5-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106164856.1453819-5-steve@sk2.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Jan 06, 2023 at 05:48:55PM +0100, Stephen Kitt wrote:
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/video/backlight/tosa_bl.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/video/backlight/tosa_bl.c b/drivers/video/backlight/tosa_bl.c
> index 77b71f6c19b5..e338b1f00f6a 100644
> --- a/drivers/video/backlight/tosa_bl.c
> +++ b/drivers/video/backlight/tosa_bl.c
> @@ -50,13 +50,8 @@ static void tosa_bl_set_backlight(struct tosa_bl_data *data, int brightness)
>  
>  static int tosa_bl_update_status(struct backlight_device *dev)
>  {
> -	struct backlight_properties *props = &dev->props;
>  	struct tosa_bl_data *data = bl_get_data(dev);
> -	int power = max(props->power, props->fb_blank);
> -	int brightness = props->brightness;
> -
> -	if (power)
> -		brightness = 0;
> +	int brightness = backlight_get_brightness(dev);
>  
>  	tosa_bl_set_backlight(data, brightness);
>  
> -- 
> 2.30.2
