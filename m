Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795697170;
	b=0fj27DV1kgbVeRzbeziQm/ojrLqrNhCBQ1u8bhGevDz7sVQG6iwCRAEXEc3k/zN1ZARc
	 zXilKo5zJYdOpAdxJbKAObiPkFnhDbbo7joII+367TqLSenK3UixFnrM3wh32M/SwgEIf
	 jUF7y7nkL6Fu1+mjoAhEpolpRBjaWCaADq1iynW5KjhukpN2UaJudzWKqJdyghMZwHeX3
	 cM5l/BgjxkXY6RqlKiN/7fQJcqftElMRvSZpJB8rAEy7PMLYO3wuPdTJOsNlvXCxhDLc3
	 i5dE7MWzaTUx+tR+PlhIiiKr42RDj2o+/tXI/fI286E54yf6dUpFV5WfAGrEb+g+q3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697170;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=rdckaT7Rt0EQb8wTCfji2xEphbWqzL0dz1XZ9l8Clsc=;
	b=qhKLMd9qKV9RTzZQTp3Bs0jHVQFKhVYTR4yfrD4kq3gfYDw24Z04QzdEvU5mBmVuScPA
	 XtfuSeGmi71fyH5g78R7i2cF6o/ekwqbZR9wBrOSnfGzQ8b8CZZ7i+vgKZmWK9bwQeXcS
	 omdFAdxM+8/PVmGTjXyaKwtKVHmrIdHaLuN7mOJRu6prYVVmMhitXGzAQIMhG2YVjzqMC
	 dzMW9IJdarPZ1dPETwFvkZihde/JGGIJctjISA66BarcLCHrbV2bpVCUqLMpnXTITnAoW
	 r1ID2L+f4gqpAm4FVNTWeG7UUWiYTsV2o9E6OoDtkpcgr1v9rRnY5n1G7nRCCN0Brpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JorL3aJo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E03A606A31C;
	Thu, 26 Nov 2026 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JorL3aJo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D33A1F000CF;
	Thu, 26 Nov 2026 12:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795697169;
	bh=rdckaT7Rt0EQb8wTCfji2xEphbWqzL0dz1XZ9l8Clsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JorL3aJoW2gdhWICjJZWD9lShxKhQ3aR0FERUD/a77KVrVtieN41jVosl/Ng8vteW
	 e6zG24bGmaK33JWWjSlqLWYtW04LUWdomEe99l3sFtRjQoIaTzqWjIEvvWPFK6wsfU
	 Onjp4PZYkYghGmM6w+W8yDHQRobbwtj9+secXT8gVa+iOzTk2nHnoxkbp9ilciyYOE
	 yB7orAik8emW3NxVWiTDMq8VRJXNAqzjiIqb06uWgVhwu3yAtGBMcXF0dIVH2OadCx
	 wmfkKIjlrp6IFAtnJ8bsNGiwKsyHzeNaKZXzyJHmbvq78PjtVFGkn4qiYIufExgQyj
	 cjHDti7AVJzzQ==
Date: Thu, 26 Nov 2026 12:46:05 +0000
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] video: leds: backlight: lm3533: Support getting LED
 sources from DT
Message-ID: <20261126124605.GI38590@joneslee-macbookpro.roam.internal>
References: <20261115085155.80043-1-clamor95@gmail.com>
 <20261126114506.GF38590@joneslee-macbookpro.roam.internal>
 <CAPVz0n1QApS9Y67WH1xJ34wg9AWz+RQ0DXEd5jAPEnAw=cTd2g@mail.gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n1QApS9Y67WH1xJ34wg9AWz+RQ0DXEd5jAPEnAw=cTd2g@mail.gmail.com>

On Thu, 26 Nov 2026, Svyatoslav Ryhel wrote:

> чт, 26 лист. 2026 р. о 13:45 Lee Jones <lee@kernel.org> пише:
> >
> > On Sun, 15 Nov 2026, Svyatoslav Ryhel wrote:
> >
> > > Add Control Bank to HVLED/LVLED muxing support based on the led-sources
> > > defined in the device tree.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
> > > ---
> > > This was part of the original LM3533 controller DT/OF conversion patchset,
> > > but it appears to have been accidentally separated during the final iteration.
> > > Therefore, I am sending it as a follow-up.
> > >
> > > Changes in v2:
> > > - leds: switch to macros in regmap_update_bits() calls to apply 0xff mask
> > >   since regmap writes may cause unwanted writing.
> > >
> > > Changes in v3:
> > > - leds part moved into a separate patchset
> > > - switched to dev_err_probe()
> > > - for loop moved out of if condition
> > > ---
> > >  drivers/video/backlight/lm3533_bl.c | 44 +++++++++++++++++++++++++++++
> > >  1 file changed, 44 insertions(+)
> > >
> > > diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
> > > index fd6e7f4f1f61c..cb9df6ff73001 100644
> > > --- a/drivers/video/backlight/lm3533_bl.c
> > > +++ b/drivers/video/backlight/lm3533_bl.c
> > > @@ -7,6 +7,7 @@
> > >   * Author: Johan Hovold <jhovold@gmail.com>
> > >   */
> > >
> > > +#include <linux/bits.h>
> > >  #include <linux/module.h>
> > >  #include <linux/init.h>
> > >  #include <linux/platform_device.h>
> > > @@ -21,6 +22,7 @@
> > >  #define LM3533_HVCTRLBANK_COUNT              2
> > >  #define LM3533_BL_MAX_BRIGHTNESS     255
> > >
> > > +#define LM3533_REG_OUTPUT_CONF1              0x10
> > >  #define LM3533_REG_CTRLBANK_AB_BCONF 0x1a
> > >  #define   CTRLBANK_AB_BCONF_ALS(n)   BIT(2 * (n))
> > >  #define   CTRLBANK_AB_BCONF_MODE(n)  BIT(2 * (n) + 1)
> > > @@ -35,6 +37,9 @@ struct lm3533_bl {
> > >       u32 max_current;
> > >       u32 pwm;
> > >
> > > +     int num_leds;
> > > +     u32 led_strings[LM3533_HVCTRLBANK_COUNT];
> > > +
> > >       bool have_als;
> > >       bool linear;
> > >  };
> > > @@ -236,6 +241,8 @@ static const struct attribute_group *lm3533_bl_attribute_groups[] = {
> > >  static int lm3533_bl_setup(struct lm3533_bl *bl)
> > >  {
> > >       int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
> > > +     u32 output_cfg_val = 0;
> > > +     u32 output_cfg_mask = 0;
> > >       int ret;
> > >
> > >       ret = regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
> > > @@ -243,6 +250,21 @@ static int lm3533_bl_setup(struct lm3533_bl *bl)
> > >       if (ret)
> > >               return ret;
> > >
> > > +     for (int i = 0; i < bl->num_leds; i++) {
> > > +             if (bl->led_strings[i] >= LM3533_HVCTRLBANK_COUNT)
> > > +                     continue;
> > > +
> > > +             output_cfg_val |= ctrlbank << bl->led_strings[i];
> > > +             output_cfg_mask |= BIT(bl->led_strings[i]);
> > > +     }
> > > +
> > > +     if (bl->num_leds) {
> > > +             ret = regmap_update_bits(bl->regmap, LM3533_REG_OUTPUT_CONF1,
> > > +                                      output_cfg_mask, output_cfg_val);
> > > +             if (ret)
> > > +                     return ret;
> > > +     }
> > > +
> > >       ret = lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current);
> > >       if (ret)
> > >               return ret;
> > > @@ -320,6 +342,28 @@ static int lm3533_bl_probe(struct platform_device *pdev)
> > >
> > >       device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &bl->pwm);
> > >
> > > +     /*
> > > +      * If led-sources property is not set then either this Control Bank uses
> > > +      * its default HVLED or is not linked to any HVLED at all.
> > > +      */
> > > +     bl->num_leds = device_property_count_u32(&pdev->dev, "led-sources");
> > > +     if (bl->num_leds > LM3533_HVCTRLBANK_COUNT)
> > > +             return dev_err_probe(&pdev->dev, -EINVAL,
> > > +                                  "num of LED sources %d exceeds max %d\n",
> >
> > Nit: As I mentioned before, this is user-documentation - should be number?
> >
> 
> Daniel Thompson was fine with num

I'm not.  I'll let 'max' slide, but not 'num'.

-- 
Lee Jones
