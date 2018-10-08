From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 08 Oct 2018 10:18:36 +0000
Subject: Re: [PATCH] udlfb: handle unplug properly
Message-Id: <20181008101837eucas1p2a5dd811a3a085324fec32b876aeb40ca~bmtBuC_V21858318583eucas1p2D@eucas1p2.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180730103301epcas4p3d1c8053c2a00004b72824c8928fa9dbf@epcas4p3.samsung.com>
 <alpine.LRH.2.02.1807300630250.2919@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1807300630250.2919@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>, linux-fbdev@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>, Bernie Thompson <bernie@plugable.com>, dri-devel@lists.freedesktop.org


On 07/30/2018 12:32 PM, Mikulas Patocka wrote:
> The udlfb driver maintained an open count and cleaned up itself when the
> count reached zero. But the console is also counted in the reference count
> - so, if the user unplugged the device, the open count would not drop to
> zero and the driver stayed loaded with console attached. If the user
> re-plugged the adapter, it would create a device /dev/fb1, show green
> screen and the access to the console would be lost.
> 
> The framebuffer subsystem has reference counting on its own - in order to
> fix the unplug bug, we rely the framebuffer reference counting. When the
> user unplugs the adapter, we call unregister_framebuffer unconditionally.
> unregister_framebuffer will unbind the console, wait until all users stop
> using the framebuffer and then call the fb_destroy method. The fb_destroy
> cleans up the USB driver.
> 
> This patch makes the following changes:
> * Drop dlfb->kref and rely on implicit framebuffer reference counting
>   instead.
> * dlfb_usb_disconnect calls unregister_framebuffer, the rest of driver
>   cleanup is done in the function dlfb_ops_destroy. dlfb_ops_destroy will
>   be called by the framebuffer subsystem when no processes have the
>   framebuffer open or mapped.
> * We don't use workqueue during initialization, but initialize directly
>   from dlfb_usb_probe. The workqueue could race with dlfb_usb_disconnect
>   and this racing would produce various kinds of memory corruption.
> * We use usb_get_dev and usb_put_dev to make sure that the USB subsystem
>   doesn't free the device under us.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Patch queued for 4.20, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
