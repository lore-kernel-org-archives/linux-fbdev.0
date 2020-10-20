Return-Path: <SRS0=Ytv2=D3=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87DDC433DF
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Oct 2020 09:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7316C2224D
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Oct 2020 09:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392341AbgJTJCp (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Oct 2020 05:02:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15237 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390264AbgJTJCo (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Oct 2020 05:02:44 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 04FD0A8AF70E46EE5E23;
        Tue, 20 Oct 2020 17:02:42 +0800 (CST)
Received: from [10.174.178.174] (10.174.178.174) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 20 Oct 2020 17:02:35 +0800
Subject: [PATCH resend] vgacon: fix a UAF in do_update_region()
To:     Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <b.zolnierkie@samsung.com>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <yangyingliang@huawei.com>
References: <20200713110445.553974-1-yangyingliang@huawei.com>
 <20201017122506.GA2838103@ravnborg.org>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <60b42c70-0166-747d-2063-7ecce463a933@huawei.com>
Date:   Tue, 20 Oct 2020 17:02:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20201017122506.GA2838103@ravnborg.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org
Message-ID: <20201020090234.sl9BgyzSq3JDvzGIvTekpSkVEcq7N6DFZ99oD-0XCpk@z>

I got a UAF report in do_update_region() when I doing fuzz test.

[   51.161905] BUG: KASAN: use-after-free in do_update_region+0x579/0x600
[   51.161918] Read of size 2 at addr ffff888000100000 by task test/295

[   51.161957] CPU: 2 PID: 295 Comm: test Not tainted 5.7.0+ #975
[   51.161969] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[   51.161976] Call Trace:
[   51.162001]  dump_stack+0xc6/0x11e
[   51.162019]  ? do_update_region+0x579/0x600
[   51.162047]  print_address_description.constprop.6+0x1a/0x220
[   51.162083]  ? vprintk_func+0x66/0xed
[   51.162100]  ? do_update_region+0x579/0x600
[   51.162112]  ? do_update_region+0x579/0x600
[   51.162128]  kasan_report.cold.9+0x37/0x7c
[   51.162151]  ? do_update_region+0x579/0x600
[   51.162173]  do_update_region+0x579/0x600
[   51.162207]  ? con_get_trans_old+0x230/0x230
[   51.162229]  ? retint_kernel+0x10/0x10
[   51.162278]  csi_J+0x557/0xa00
[   51.162307]  do_con_trol+0x49af/0x5cc0
[   51.162330]  ? lock_downgrade+0x720/0x720
[   51.162347]  ? reset_palette+0x1b0/0x1b0
[   51.162369]  ? lockdep_hardirqs_on_prepare+0x379/0x540
[   51.162393]  ? notifier_call_chain+0x11b/0x160
[   51.162438]  do_con_write.part.24+0xb0a/0x1a30
[   51.162501]  ? do_con_trol+0x5cc0/0x5cc0
[   51.162522]  ? console_unlock+0x7b8/0xb00
[   51.162555]  ? __mutex_unlock_slowpath+0xd4/0x670
[   51.162574]  ? this_tty+0xe0/0xe0
[   51.162589]  ? console_unlock+0x559/0xb00
[   51.162605]  ? wait_for_completion+0x260/0x260
[   51.162638]  con_write+0x31/0xb0
[   51.162658]  n_tty_write+0x4fa/0xd40
[   51.162710]  ? n_tty_read+0x1800/0x1800
[   51.162730]  ? prepare_to_wait_exclusive+0x270/0x270
[   51.162754]  ? __might_fault+0x175/0x1b0
[   51.162783]  tty_write+0x42b/0x8d0
[   51.162795]  ? n_tty_read+0x1800/0x1800
[   51.162825]  ? tty_lookup_driver+0x450/0x450
[   51.162848]  __vfs_write+0x7c/0x100
[   51.162875]  vfs_write+0x1c9/0x510
[   51.162901]  ksys_write+0xff/0x200
[   51.162918]  ? __ia32_sys_read+0xb0/0xb0
[   51.162940]  ? do_syscall_64+0x1a/0x520
[   51.162957]  ? lockdep_hardirqs_on_prepare+0x379/0x540
[   51.162984]  do_syscall_64+0xa1/0x520
[   51.163008]  entry_SYSCALL_64_after_hwframe+0x49/0xb3

After vgacon_set_origin() is called in set_origin(), the vc_origin is
set to vga_vram_base, the vc_pos should between vga_vram_base and
vga_vram_end. But we still use vc_screenbuf_size, if the vga_vram_size
is smaller than vc_screenbuf_size, vc_pos may be out of bound, using it
will cause a use-after-free(or out-of-bounds). Fix this by calling
vc_resize() if vga_vram_size is smaller than vc_screenbuf_size.

Signed-off-by: Yang Yingliang<yangyingliang@huawei.com>
---
  drivers/video/console/vgacon.c | 3 +++
  1 file changed, 3 insertions(+)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 998b0de..2ee3d62 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -1336,6 +1336,9 @@ static int vgacon_set_origin(struct vc_data *c)
  	if (vga_is_gfx ||	/* We don't play origin tricks in graphic modes */
  	    (console_blanked && !vga_palette_blanked))	/* Nor we write to blanked screens */
  		return 0;
+
+	if (c->vc_screenbuf_size > vga_vram_size)
+		vc_resize(c, screen_info.orig_video_cols, screen_info.orig_video_lines);
  	c->vc_origin = c->vc_visible_origin = vga_vram_base;
  	vga_set_mem_top(c);
  	vga_rolled_over = 0;

