From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 17 May 2019 11:24:49 +0000
Subject: Re: [PATCH] vt/fbcon: deinitialize resources in visual_init() after failed memory allocation
Message-Id: <782f3255-3a25-4620-e97c-2f742e733f32@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190426145959epcas3p452b4b80025c58916331820abbb0060ed@epcas3p4.samsung.com>
        <20190426145946.26537-1-ghalat@redhat.com>
In-Reply-To: <20190426145946.26537-1-ghalat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grzegorz Halat <ghalat@redhat.com>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-fbdev@vger.kernel.org, Oleksandr Natalenko <oleksandr@redhat.com>


On 4/26/19 4:59 PM, Grzegorz Halat wrote:
> After memory allocation failure vc_allocate() doesn't clean up data
> which has been initialized in visual_init(). In case of fbcon this
> leads to divide-by-0 in fbcon_init() on next open of the same tty.
> 
> memory allocation in vc_allocate() may fail here:
> 1097:     vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_KERNEL);
> 
> on next open() fbcon_init() skips vc_font.data initialization:
> 1088:     if (!p->fontdata) {
> 
> division by zero in fbcon_init() happens here:
> 1149:     new_cols /= vc->vc_font.width;
> 
> Additional check is needed in fbcon_deinit() to prevent
> usage of uninitialized vc_screenbuf:
> 
> 1251:        if (vc->vc_hi_font_mask && vc->vc_screenbuf)
> 1252:                set_vc_hi_font(vc, false);
> 
> Crash:
> 
>  #6 [ffffc90001eafa60] divide_error at ffffffff81a00be4
>     [exception RIP: fbcon_init+463]
>     RIP: ffffffff814b860f  RSP: ffffc90001eafb18  RFLAGS: 00010246
> ...
>  #7 [ffffc90001eafb60] visual_init at ffffffff8154c36e
>  #8 [ffffc90001eafb80] vc_allocate at ffffffff8154f53c
>  #9 [ffffc90001eafbc8] con_install at ffffffff8154f624
> ...
> 
> Signed-off-by: Grzegorz Halat <ghalat@redhat.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
