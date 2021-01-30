Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F482C433E6
	for <linux-fbdev@archiver.kernel.org>; Sat, 30 Jan 2021 09:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE9E264DE2
	for <linux-fbdev@archiver.kernel.org>; Sat, 30 Jan 2021 09:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhA3JU5 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 30 Jan 2021 04:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbhA3JUP (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 30 Jan 2021 04:20:15 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DD8C061574;
        Fri, 29 Jan 2021 22:39:31 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id g3so6683946plp.2;
        Fri, 29 Jan 2021 22:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=TANixHB1VghGJvUItmZRy+uLix9/H4aSqcnAzrKjFBE=;
        b=T4CRyO1szRQ0/ybotrnrWq6fV5wBmc5Oa0bouNJ6DA8t+KkTh452zOK4hqN+tAKE+g
         SgECaofNxz3i//yrAFtiQo7qdPEPHRSRJsK0fwSSiGscDYxZ/sDIISz3mHuSjpf0eDdY
         mjay+t0F2sxzBCOwXFC1bg+vTJ90c/TOL/j/ZSPYpv5fZtKz0Np3FfgdjXVFQS4QAJmb
         RlBvbTOjNm3jd8pYvJYdACiSRg0BRtQ9muhClDFdcfKmfT78vxyY/rRVd+OjCctD9dTP
         AT9J9LC6AOr7OSFl0jPhhLHXOhS5kvAV7mahZfnCcKZbV/u8d+XIe99uvtSIx4mazpO/
         Ydug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=TANixHB1VghGJvUItmZRy+uLix9/H4aSqcnAzrKjFBE=;
        b=UEzIJNRShIiUI9TBAz1rutQ9r+BDmKVwohJ7Jtr8PIvQSBLupzfgXSTGI//iww24L0
         Ai78JL4iEMLbLR6tfrHy/9QQ+/knl4kv+0lFSh/rUI2bQSR8KXCc+My0I+XyRbkHwnzq
         jPIiaaaYFr67UFBeaKIVmOwVr800Pc4s37agdoOOI16Vz1VRxlL9xjjpFUCX/j/oDWpR
         25o9g8xVIOg8n8ioq+y0spN5BQPxN1KrYvUei8fRehTU2Qz0fCe8wkl07kCpMz0d74s6
         YnREd8D30451LpubaZ7wrtANnZd90/5NPqbvKhM6kM8goWiBlo7aEjrfTCuo4m+a+/a2
         kYdQ==
X-Gm-Message-State: AOAM530WukxLZua2vKa5bKuWG8qt/Cpi7aa0KZjbWCRfsHZen79X6i1B
        Rpe01YDxWzq9EHrJ3/OqL/mxXx+BRw8EC4KD
X-Google-Smtp-Source: ABdhPJznlhJCt2LNVfTUGyGHmkAifzTWGztAOXlfqCmGbmi3wonXDaAJr5lCg8Q1B9X5uB6Z8XvqGQ==
X-Received: by 2002:a17:903:2306:b029:de:18e9:f439 with SMTP id d6-20020a1709032306b02900de18e9f439mr8089143plh.38.1611988771137;
        Fri, 29 Jan 2021 22:39:31 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id j14sm9083885pjl.35.2021.01.29.22.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 22:39:30 -0800 (PST)
Date:   Sat, 30 Jan 2021 14:39:24 +0800
From:   carlis <zhangxuezhi3@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin King <colin.king@canonical.com>,
        oliver.graute@kococonnector.com, zhangxuezhi1@yulong.com,
        Deepak R Varma <mh12gx2825@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12] staging: fbtft: add tearing signal detect
Message-ID: <20210130143924.00005432@gmail.com>
In-Reply-To: <CAHp75VcdOibSRuSBZYhFtEcVxuammYMfcnrUQGvS6ttArFxj6g@mail.gmail.com>
References: <1611838435-151774-1-git-send-email-zhangxuezhi3@gmail.com>
        <CAHp75Vd=ijxnamuSYuxNLeyhGMCod=HaXWrQ0W0+3QCsQAychg@mail.gmail.com>
        <20210129130110.00003bb1@gmail.com>
        <CAHp75Vdi4H_zY3+QPSq_wmdf20B9xPeqsOT10JHfMLJESX77gA@mail.gmail.com>
        <20210129215638.000047b0@gmail.com>
        <CAHp75VcdOibSRuSBZYhFtEcVxuammYMfcnrUQGvS6ttArFxj6g@mail.gmail.com>
Organization: Tyzmig-ryrjum-8kedto
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, 29 Jan 2021 16:26:12 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Jan 29, 2021 at 3:56 PM carlis <zhangxuezhi3@gmail.com> wrote:
> > On Fri, 29 Jan 2021 12:23:08 +0200
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote: =20
>=20
> We are almost there, I have no idea what Noralf or others are going to
> say though.
>=20
> ...
>=20
> > Hi, I apologize for what I said in the previous two emails. I missed
> > one email you sent before, and now I probably understand what you
> > meant. Here is a version I modified according to your suggestion:
> >
> > From 399e7fb91d1dcba4924cd38cc8283393c80b97e4 Mon Sep 17 00:00:00
> > 2001 From: Carlis <zhangxuezhi1@yulong.com>
> > Date: Sun, 24 Jan 2021 22:43:21 +0800
> > Subject: [PATCH v13] staging: fbtft: add tearing signal detect
> >
> > For st7789v IC,when we need continuous full screen refresh, it is
> > best =20
>=20
> Missed space after comma.
>=20
> > to wait for the tearing effect line signal arrive to avoid screen =20
>=20
> to arrive
>=20
> > tearing. =20
>=20
> ...
>=20
> > +#define PANEL_TE_TIMEOUT_MS  34 /* 60Hz for 16.6ms, configured as
> > 2*16.6ms */ + =20
>=20
> Move comment before the definition
> /* comment */
> #define DEFINITION
>=20
> Also consider to use 33 ms as closest to what you mentioned in the
> comment. Or leave it with mention that you are using ceil() value.
>=20
> ...
>=20
> > +/**
> > + * init_tearing_effect_line() - init tearing effect line =20
>=20
> > + * =20
>=20
> As per a few previous reviews.
> Okay, I have noticed that the existing kernel-doc is written like
> this, but it doesn't prevent you from avoiding this little mistake.
>=20
> > + * @par: FBTFT parameter object
> > + *
> > + * Return: 0 on success, or a negative error code otherwise.
> > + */
> > +static int init_tearing_effect_line(struct fbtft_par *par)
> > +{
> > +       struct device *dev =3D par->info->device;
> > +       struct gpio_desc *te;
> > +       int rc;
> > +
> > +       te =3D gpiod_get_optional(dev, "te", GPIOD_IN);
> > +       if (IS_ERR(te))
> > +               return dev_err_probe(dev, PTR_ERR(te), "Failed to
> > request te GPIO\n"); + =20
>=20
> Below is okay, but needs a comment explaining why we return a success.
>=20
> > +       if (!te)
> > +               return 0;
> > +
> > +       par->irq_te =3D gpiod_to_irq(te);
> > +
> > +       /* GPIO is locked as an IRQ, we may drop the reference */
> > +       gpiod_put(te);
> > +
> > +       if (par->irq_te < 0)
> > +               return par->irq_te; =20
>=20
> I recommend using a temporary variable. In such a case you won't need
> to specifically check for negative error code. So, something like
>=20
> int irq;
>=20
> irq =3D ...
>=20
> if (irq < 0)
>   return irq;
>=20
> ->irq_te =3D irq; =20
>=20
> > +       init_completion(&par->panel_te);
> > +       rc =3D devm_request_irq(dev, par->irq_te, panel_te_handler,
> > +                             IRQF_TRIGGER_RISING, "TE_GPIO", par);
> > =20
>=20
> Right. Now it needs a comment explaining the choice of rising edge
> type of IRQ.
>=20
> > +       if (rc)
> > +               return dev_err_probe(dev, rc, "TE IRQ request
> > failed.\n"); +
> > +       disable_irq_nosync(par->irq_te);
> > +
> > +       return 0;
> > +} =20
>=20
> ...
>=20
> > +       rc =3D init_tearing_effect_line(par); =20
>=20
> > +       if (rc < 0) =20
>=20
> Here is no need to specifically check against less than 0,
>   if (ret)
> will work nicely.
>=20
> > +               return rc; =20
>=20
> ...
>=20
> > +       if (par->irq_te)
> > +               write_reg(par, MIPI_DCS_SET_TEAR_ON, 0x00); =20
>=20
> Do you need to call MIPI_DCS_SET_TEAR_SCANLINE in this case?
>=20
Hi, TE line output is off by default when powering on, and I use
Qualcomm SDX55 chip, SPI top speed is only 50MHz, its data transmission
speed( It takes about 24ms to transmit a frame) is slower than 60Hz
refresh(a frame only need 16.6ms), so i think there is no need to call
MIPI_DCS_SET_TEAR_SCANLINE=20

> Alos, when there is no IRQ, shouldn't we explicitly call
>                write_reg(par, MIPI_DCS_SET_TEAR_OFF);
> ?
>=20
> ...
>=20
> >  /**
> > + * st7789v_write_vmem16_bus8() - write data to display =20
>=20
> > + * =20
>=20
> Redundant.
>=20
> > + * @par: FBTFT parameter object
> > + * @offset: offset from screen_buffer
> > + * @len: the length of data to be written
> > + * =20
>=20
> > + * 16 bit pixel over 8-bit databus =20
>=20
> Write 16-bit pixels over 8-bit data bus.
>=20
> > + * Return: 0 on success, or a negative error code otherwise.
> > + */ =20
>=20
> ...
>=20
> > +       if (par->irq_te) {
> > +               enable_irq(par->irq_te);
> > +               reinit_completion(&par->panel_te);
> > +               ret =3D wait_for_completion_timeout(&par->panel_te,
> > +
> > msecs_to_jiffies(PANEL_TE_TIMEOUT_MS));
> > +               if (ret =3D=3D 0)
> > +                       dev_err(dev, "wait panel TE time out\n"); =20
>=20
> timeout
>=20
> > +
> > +               disable_irq(par->irq_te);
> > +       } =20
>=20
> ...
>=20
> > + * @panel_te: completion for panel te line =20
>=20
> TE line
>=20
> > + * @irq_te: LCD Chip tearing effect line =20
>=20
> "Linux IRQ for LCD..."
>=20

hi, i modify new below:

=46rom b65fc2bfbe123defc8ec838601a9c12707f70c53 Mon Sep 17 00:00:00 2001
From: Carlis <zhangxuezhi1@yulong.com>
Date: Sun, 24 Jan 2021 22:43:21 +0800
Subject: [PATCH v13] staging: fbtft: add tearing signal detect

For st7789v IC, when we need continuous full screen refresh, it is best
to wait for the tearing effect line signal to arrive to avoid screen
tearing.

Signed-off-by: Carlis <zhangxuezhi1@yulong.com>
---
v13: change TE completion to par data struct member and add a new
     function to deal te gpio request, move wait logic to
fbtft_write_vmem16_bus8. v12: change dev_err to dev_err_probe and add
space in comments start, and delete te_mutex, change te wait logic.
v11: remove devm_gpio_put and change a dev_err to dev_info.
v10: additional notes.
v9: change pr_* to dev_*.
v8: delete a log line.
v7: return error value when request fail.
v6: add te gpio request fail deal logic.
v5: fix log print.
v4: modify some code style and change te irq set function name.
v3: modify author and signed-off-by name.
v2: add release te gpio after irq request fail.
---
 drivers/staging/fbtft/fb_st7789v.c | 64
++++++++++++++++++++++++++++++++++++++
drivers/staging/fbtft/fbtft-bus.c  | 20 ++++++++++--
drivers/staging/fbtft/fbtft.h      |  5 +++ 3 files changed, 87
insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_st7789v.c
b/drivers/staging/fbtft/fb_st7789v.c index 3a280cc..695dcac 100644
--- a/drivers/staging/fbtft/fb_st7789v.c
+++ b/drivers/staging/fbtft/fb_st7789v.c
@@ -7,9 +7,13 @@
=20
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/completion.h>
 #include <linux/module.h>
+
 #include <video/mipi_display.h>
=20
 #include "fbtft.h"
@@ -66,6 +70,56 @@ enum st7789v_command {
 #define MADCTL_MX BIT(6) /* bitmask for column address order */
 #define MADCTL_MY BIT(7) /* bitmask for page address order */
=20
+static irqreturn_t panel_te_handler(int irq, void *data)
+{
+	struct fbtft_par *par =3D (struct fbtft_par *)data;
+
+	complete(&par->panel_te);
+	return IRQ_HANDLED;
+}
+
+/*
+ * init_tearing_effect_line() - init tearing effect line.
+ * @par: FBTFT parameter object.
+ *
+ * Return: 0 on success, or a negative error code otherwise.
+ */
+static int init_tearing_effect_line(struct fbtft_par *par)
+{
+	struct device *dev =3D par->info->device;
+	struct gpio_desc *te;
+	int rc, irq;
+
+	te =3D gpiod_get_optional(dev, "te", GPIOD_IN);
+	if (IS_ERR(te))
+		return dev_err_probe(dev, PTR_ERR(te), "Failed to
request te GPIO\n"); +
+	/* if te is NULL, indicating no configuration, directly return
success */
+	if (!te)
+		return 0;
+
+	irq =3D gpiod_to_irq(te);
+
+	/* GPIO is locked as an IRQ, we may drop the reference */
+	gpiod_put(te);
+
+	if (irq < 0)
+		return irq;
+
+	par->irq_te =3D irq;
+	init_completion(&par->panel_te);
+
+	/* The effective state is high and lasts no more than 1000
microseconds */
+	rc =3D devm_request_irq(dev, par->irq_te, panel_te_handler,
+			      IRQF_TRIGGER_RISING, "TE_GPIO", par);
+	if (rc)
+		return dev_err_probe(dev, rc, "TE IRQ request
failed.\n"); +
+	disable_irq_nosync(par->irq_te);
+
+	return 0;
+}
+
 /**
  * init_display() - initialize the display controller
  *
@@ -82,6 +136,12 @@ enum st7789v_command {
  */
 static int init_display(struct fbtft_par *par)
 {
+	int rc;
+
+	rc =3D init_tearing_effect_line(par);
+	if (rc)
+		return rc;
+
 	/* turn off sleep mode */
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
 	mdelay(120);
@@ -137,6 +197,10 @@ static int init_display(struct fbtft_par *par)
 	 */
 	write_reg(par, PWCTRL1, 0xA4, 0xA1);
=20
+	/* TE line output is off by default when powering on */
+	if (par->irq_te)
+		write_reg(par, MIPI_DCS_SET_TEAR_ON, 0x00);
+
 	write_reg(par, MIPI_DCS_SET_DISPLAY_ON);
=20
 	if (HSD20_IPS)
diff --git a/drivers/staging/fbtft/fbtft-bus.c
b/drivers/staging/fbtft/fbtft-bus.c index 63c65dd..5bc2fff 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -2,9 +2,15 @@
 #include <linux/export.h>
 #include <linux/errno.h>
 #include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/completion.h>
 #include <linux/spi/spi.h>
+
 #include "fbtft.h"
=20
+/* 60Hz for 16.6ms, configured as 2*16.6ms */
+#define PANEL_TE_TIMEOUT_MS  33
+
 /*************************************************************************=
****
  *
  *   void (*write_reg)(struct fbtft_par *par, int len, ...);
@@ -135,8 +141,18 @@ int fbtft_write_vmem16_bus8(struct fbtft_par *par,
size_t offset, size_t len) remain =3D len / 2;
 	vmem16 =3D (u16 *)(par->info->screen_buffer + offset);
=20
-	if (par->gpio.dc)
-		gpiod_set_value(par->gpio.dc, 1);
+	gpiod_set_value(par->gpio.dc, 1);
+
+	if (par->irq_te) {
+		enable_irq(par->irq_te);
+		reinit_completion(&par->panel_te);
+		ret =3D wait_for_completion_timeout(&par->panel_te,
+
msecs_to_jiffies(PANEL_TE_TIMEOUT_MS));
+		if (ret =3D=3D 0)
+			dev_err(par->info->device, "wait panel TE
timeout\n"); +
+		disable_irq(par->irq_te);
+	}
=20
 	/* non buffered write */
 	if (!par->txbuf.buf)
diff --git a/drivers/staging/fbtft/fbtft.h
b/drivers/staging/fbtft/fbtft.h index 76f8c09..61c7207 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -8,6 +8,7 @@
 #include <linux/spinlock.h>
 #include <linux/spi/spi.h>
 #include <linux/platform_device.h>
+#include <linux/completion.h>
=20
 #define FBTFT_ONBOARD_BACKLIGHT 2
=20
@@ -165,6 +166,8 @@ struct fbtft_platform_data {
  *             Format: 6 bit Device id + RS bit + RW bit
  * @fbtftops: FBTFT operations provided by driver or device
(platform_data)
  * @dirty_lock: Protects dirty_lines_start and dirty_lines_end
+ * @panel_te: completion for panel TE line
+ * @irq_te: Linux IRQ for LCD TE line
  * @dirty_lines_start: Where to begin updating display
  * @dirty_lines_end: Where to end updating display
  * @gpio.reset: GPIO used to reset display
@@ -203,6 +206,8 @@ struct fbtft_par {
 	u8 startbyte;
 	struct fbtft_ops fbtftops;
 	spinlock_t dirty_lock;
+	struct completion panel_te;
+	int irq_te;
 	unsigned int dirty_lines_start;
 	unsigned int dirty_lines_end;
 	struct {
--=20
1.9.1

regards,
Carlis=20
