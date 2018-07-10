From: Mikulas Patocka <mpatocka@redhat.com>
Date: Tue, 10 Jul 2018 02:37:41 +0000
Subject: Re: [PATCH] fb: fix lost console when the user unplugs a USB adapter
Message-Id: <alpine.LRH.2.02.1807092232120.30863@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="185206533-1232387398-1531190262=:30863"
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180603154636epcas2p4812a1f19c6ae236336ae580658edb167@epcas2p4.samsung.com>
 <alpine.LRH.2.02.1806031143470.15248@file01.intranet.prod.int.rdu2.redhat.com>
 <5091035.TYlAUG7jeO@amdc3058>
 <alpine.LRH.2.02.1807031301290.22443@file01.intranet.prod.int.rdu2.redhat.com>
 <7861c063-6494-7cd8-683d-02c61f9faa1f@tronnes.org>
In-Reply-To: <7861c063-6494-7cd8-683d-02c61f9faa1f@tronnes.org>
To: =?ISO-8859-15?Q?Noralf_Tr=F8nnes?= <noralf@tronnes.org>
Cc: linux-fbdev@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bernie Thompson <bernie@plugable.com>, dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185206533-1232387398-1531190262=:30863
Content-Type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: 8bit



On Wed, 4 Jul 2018, Noralf Trønnes wrote:

> AFAIU calling unregister_framebuffer() with open fd's is just fine as
> long as fb_info with buffers stay intact. All it does is to remove the
> fbX from userspace. Cleanup can be done in fb_ops->fb_destroy.
> 
> I have been working on generic fbdev emulation for DRM [1] and I did a
> test now to see what would happen if I did unbind the driver from the
> device. It worked as expected if I didn't have another fbdev present,
> but if there is an fb0 and I remove fb1 with a console on it, I would
> sometimes get crashes, often with a call to cursor_timer_handler() in
> the traceback.
> 
> I think there's index mixup in fbcon_fb_unbind(), at least this change
> seems to solve the immediate problem:
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c
> b/drivers/video/fbdev/core/fbcon.c
> index 5fb156bdcf4e..271b9b988b73 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -3066,7 +3072,7 @@ static int fbcon_fb_unbind(int idx)
>         for (i = first_fb_vc; i <= last_fb_vc; i++) {
>                 if (con2fb_map[i] != idx &&
>                     con2fb_map[i] != -1) {
> -                       new_idx = i;
> +                       new_idx = con2fb_map[i];
>                         break;
>                 }
>         }

Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>

Yes - that's a good point. i is virtual console index and it is assigned 
to new_idx and new_idx is interpreted as a framebuffer device index.

> I haven't got time to follow up on this now, but making sure DRM generic
> fbdev emulation device unplug works is on my TODO.
> 
> BTW, I believe the udl drm driver should be able to use the generic fbdev
> emulation if it had a drm_driver->gem_prime_vmap hook. It uses a shadow
> buffer which would also make fbdev mmap work for udl. (shmem buffers and
> fbdev deferred I/O doesn't work together since they both use
> page->lru/mapping)

I have sent patch for this:
https://patchwork.kernel.org/patch/10445393/

Mikulas
--185206533-1232387398-1531190262=:30863--
