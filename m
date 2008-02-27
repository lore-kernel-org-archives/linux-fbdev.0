From: Alexandre Rusev <arusev@ru.mvista.com>
Subject: Re: [PATCH 0/8] pxafb cleanup
Date: Wed, 27 Feb 2008 12:36:26 +0300
Message-ID: <47C52F1A.7060304@ru.mvista.com>
References: <f17812d70802261832l78840912r4dcb0403e9fe4385@mail.gmail.com>	
	<47C52628.8010005@ru.mvista.com>
	<f17812d70802270208s102c4a16u8ae22074f5176d45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <f17812d70802270208s102c4a16u8ae22074f5176d45@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: eric miao <eric.y.miao@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel <linux-arm-kernel@lists.arm.linux.org.uk>

eric miao wrote:
> On Wed, Feb 27, 2008 at 4:58 PM, Alexandre Rusev <arusev@ru.mvista.com> wrote:
>   
>> eric miao wrote:
>> ...
>>
>>  I'd prefer to see DirectFB fixed against this, yet the fulfillment of
>>  these  a bit strange rules
>>  looks like to be the only way to make it possible the DirectFB to work
>>  with pxafb driver :(
>>
>>     
>
> Actually, I don't quite like what the current overlay driver is doing.
>   
I agree at this point!
> I'd prefer some frame buffer APIs so the upper application can
> enable/disable and adjust the offset of overlay within the whole
> video memory. E.g.
>
> Instead of
>     overlay1_fd = open("/dev/fb1", O_RDWR);
>     mmap(overlay1_fd, ...)
>     ....
>
> I'd prefer:
>
>     fd = open("/dev/fb0", O_RDWR);
>     video_mem = mmap(fd, ....)
>     /* the whole video memory is mapped, say 4MB */
>
>     offset = claim_overlay_memory_within( video_mem, overlay_mem_size )
>     ioctl(fd, FBIOSET_OVERLAY, offset)
>
> Or something like this, thus treating overlay as a sub-feature of the whole
> frame buffer driver, instead of an independent frame buffer device.
>
> But it is not impossible to create another frame buffer device for the
> overlay, you can still avoid multiple mapping by:
>
>     base_fd = open("/dev/fb0", O_RDWR);
>     video_mem = mmap(base_fd, ....)
>
>     overlay1_fd = open("/dev/fb1", O_RDWR);
>     ioctl(overlay1_fd, FBIOGET_VSCREENINFO, &var)
>
>     (x_off, y_off) = allocate_rect_area_within( video_mem, x_size, y_size );
>     var.x_offset = x_off;
>     var.y_offset = y_off;
>
>     ioctl(overlay1_fd, FBIOPUT_VSCREENINFO, &var);
>
> Which is better, I cannot say. Maybe it depends on upper application's
> usage. I don't see such kind of overlays being well supported either
> in DirectFB or X window server, :(
>   
The second approach is more universal (I think), but really NOT supported by
userland, especially DirectFB.

Having /dev/bfN for each overlay makes possible to use overlays with
not-overlay-aware
applications and that's a big advantage from point of view of applied
programming.

Yet I also can't for sure which approach is better now...

I think that changing DirectFB would be nice solution of the problem 
(yet it's quite beyond my control ;) )
It's model of using overlays is quite restrictive and I don't see the
reason why it doing so.
Imean not only assumption that base ans overlays are mapped consistently
and only once but
also the assumption that multi-buffering is implemented through panning
feature only (without no abstraction layer).









-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
