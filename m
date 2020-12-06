Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683A9C433FE
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 20:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E34623110
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 20:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgLFUxC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 6 Dec 2020 15:53:02 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:36364 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbgLFUxC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 6 Dec 2020 15:53:02 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 693F8804EF;
        Sun,  6 Dec 2020 21:52:12 +0100 (CET)
Date:   Sun, 6 Dec 2020 21:52:11 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lee Jones <lee.jones@linaro.org>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Colin Ian King <colin.king@canonical.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Gustavo A R Silva <gustavoars@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Rich Felker <dalias@libc.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 02/13] video: fbdev: core: Fix kernel-doc warnings in
 fbmon + fb_notify
Message-ID: <20201206205132.GA1869030@ravnborg.org>
References: <20201206190247.1861316-1-sam@ravnborg.org>
 <20201206190247.1861316-3-sam@ravnborg.org>
 <0fb6ff8b-bea3-c5bc-0d37-8a5fdab41abc@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fb6ff8b-bea3-c5bc-0d37-8a5fdab41abc@infradead.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Itgwjo3g c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=KKAkSRfTAAAA:8 a=JfrnYn6hAAAA:8
        a=hD80L64hAAAA:8 a=crRib1yXDS5m8vWqQdEA:9 a=6yl3AuPvxnofhKU7:21
        a=UF2XOXkvibLTi7r4:21 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
        a=cvBusfyB2V15izCimMoJ:22 a=1CNFftbPRP8L7MoqJWF3:22
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Randy.

On Sun, Dec 06, 2020 at 11:37:17AM -0800, Randy Dunlap wrote:
> On 12/6/20 11:02 AM, Sam Ravnborg wrote:
> > Fix kernel-doc warnings reported when using W=1
> > 
> > v2:
> >   - Improve subject (Lee)
> > 
> > v3:
> >   - Add RETURNS documentation (Thomas)
> 
> Hi Sam,
> 
> Yes, RETURNS: will work. It just looks like any kernel-doc section name,
> such as Context: or Note:.
> However, the documented format for return info is "Return:".
> (see Documentation/doc-guide/kernel-doc.rst)
OK, like this?
I did not fix any existing uses of RETURNS, thats for another patch.

	Sam

commit 03b7c3ecf7cb51b5429ca0ef58a32bb4dc486610
Author: Sam Ravnborg <sam@ravnborg.org>
Date:   Sat Nov 28 23:40:49 2020 +0100

    video: fbdev: core: Fix kernel-doc warnings in fbmon + fb_notify
    
    Fix kernel-doc warnings reported when using W=1
    
    v2:
      - Improve subject (Lee)
    
    v3:
      - Add RETURNS documentation (Thomas)
    
    v4:
      - Use Return: not RETURNS (Randy)
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
    Cc: Lee Jones <lee.jones@linaro.org>
    Cc: Sam Ravnborg <sam@ravnborg.org>
    Cc: Randy Dunlap <rdunlap@infradead.org>
    Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
    Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
    Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>

diff --git a/drivers/video/fbdev/core/fb_notify.c b/drivers/video/fbdev/core/fb_notify.c
index 74c2da528884..10e3b9a74adc 100644
--- a/drivers/video/fbdev/core/fb_notify.c
+++ b/drivers/video/fbdev/core/fb_notify.c
@@ -19,6 +19,8 @@ static BLOCKING_NOTIFIER_HEAD(fb_notifier_list);
 /**
  *	fb_register_client - register a client notifier
  *	@nb: notifier block to callback on events
+ *
+ *	Return: 0 on success, negative error code on failure.
  */
 int fb_register_client(struct notifier_block *nb)
 {
@@ -29,6 +31,8 @@ EXPORT_SYMBOL(fb_register_client);
 /**
  *	fb_unregister_client - unregister a client notifier
  *	@nb: notifier block to callback on events
+ *
+ *	Return: 0 on success, negative error code on failure.
  */
 int fb_unregister_client(struct notifier_block *nb)
 {
@@ -38,7 +42,10 @@ EXPORT_SYMBOL(fb_unregister_client);
 
 /**
  * fb_notifier_call_chain - notify clients of fb_events
+ * @val: value passed to callback
+ * @v: pointer passed to callback
  *
+ * Return: The return value of the last notifier function
  */
 int fb_notifier_call_chain(unsigned long val, void *v)
 {
diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 1bf82dbc9e3c..b0e690f41025 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -605,6 +605,7 @@ static void get_detailed_timing(unsigned char *block,
  * fb_create_modedb - create video mode database
  * @edid: EDID data
  * @dbsize: database size
+ * @specs: monitor specifications, may be NULL
  *
  * RETURNS: struct fb_videomode, @dbsize contains length of database
  *
@@ -1100,7 +1101,6 @@ static u32 fb_get_hblank_by_hfreq(u32 hfreq, u32 xres)
  *                                    2 * M
  *        M = 300;
  *        C = 30;
-
  */
 static u32 fb_get_hblank_by_dclk(u32 dclk, u32 xres)
 {
