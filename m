From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Mon, 23 May 2011 20:53:26 +0000
Subject: Re: [RFC] Which fb_var_screeninfo fields should FBIOPAN_DISPLAY use
Message-Id: <4DDAC946.9010706@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201105232211.40154.laurent.pinchart@ideasonboard.com>
In-Reply-To: <201105232211.40154.laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Laurent,

On 05/23/2011 08:11 PM, Laurent Pinchart wrote:
> Hi everybody,
>
> I've recently received a patch for my fbdev test application to fix a panning-
> related issue. The application naively assumed that only the xoffset and
> yoffset were used, and the patch commit message explained that several drivers
> relied on other fields being filled with current values.
>
> I got curious about this. As there's no FBIOPAN_DISPLAY documentation that
> clearly states which fields are used and which fields must be ignored by
> drivers, I checked the in-tree fbdev drivers and here's what I found.
>
> First of all, the FBIOPAN_DISPLAY implementation (drivers/video/fbmem.c) uses
> the xoffset, yoffset and vmode fields. That was expected, there's nothing too
> weird there. Several drivers also use the activate field, which seems like a
> valid use to me.
>
> Then, two drivers (video/msm and staging/msm) use the reserved fields. As
> usage of the reserved fields is by definition not standard, I decided to
> ignore this.
>
> Finally, here's a list of the drivers using other fields, along with the
> fields that are being used.
>
>      media/video/ivtv - xres_virtual, bits_per_pixel
>      video/68328fb - xres, yres
>      video/acornfb - yres, yres_virtual
>      video/arkfb - bits_per_pixel, xres_virtual
>      video/atmel_lcdfb - bits_per_pixel, xres_virtual, xres
>      video/aty/radeon - xres, yres, xres_virtual, yres_virtual, bits_per_pixel
>      video/da8xx-fb - bits_per_pixel
>      video/fb-puv3 - xres, yres
>      video/g364fb - xres, yres, yres_virtual
>      video/gxt4500 - xres, yres, xres_virtual, yres_virtual
>      video/hgafb - xres, yres
>      video/imsttfb - bits_per_pixel
>      video/intelfb - xres, yres, xres_virtual, yres_virtual, bits_per_pixel
>      video/mb862xx - xres_virtual, yres_virtual
>      video/mx3fb - yres, xres_virtual, bits_per_pixel
>      video/neofb - xres_virtual, bits_per_pixel
>      video/pm2fb - bits_per_pixel, xres
>      video/pm3fb - xres, bits_per_pixel
>      video/s3c-fb - yres
>      video/s3fb - bits_per_pixel, xres_virtual
>      video/savage - xres_virtual, bits_per_pixel
>      video/sh_mobile_lcdcfb - nonstd, xres, yres_virtual
>      video/sis - xres, yres, xres_virtual, yres_virtual, bits_per_pixel
>      video/sm501fb - xres_virtual, yres_virtual, bits_per_pixel
>      video/tridentfb - xres_virtual, bits_per_pixel
>      video/vfb - xres, yres
>      video/vga16fb - bits_per_pixel
>      video/via - xres_virtual, bits_per_pixel
>      video/vt8500lcdfb - xres, xres_virtual
>      video/vt8623fb - bits_per_pixel, xres_virtual
>      video/xgifb - xres_virtual, yres_virtual, xres, yres, bits_per_pixel
>
> These fields are used to validate the xoffset and yoffset parameters against
> the active resolution, as well as to compute offset in vram.
>
> This clearly looks like bugs to me, especially given that many other drivers
> compute the same parameters using info->var instead of var. For instance, if
> drivers/video/aty/radeon_base.c implements the pan display operation as
>
>          if ((var->xoffset + var->xres>  var->xres_virtual)
>              || (var->yoffset + var->yres>  var->yres_virtual))
>                 return -EINVAL;
>
>          ...
>
>          OUTREG(CRTC_OFFSET, ((var->yoffset * var->xres_virtual + var->xoffset)
>                               * var->bits_per_pixel / 8)&  ~7);
>
> If var isn't a copy of the current fb parameters, the code will clearly lead
> to a wrong behaviour. Even worse, some drivers use var to validate parameters
> and then info->var to compute offsets, or the other way around. This could
> lead to security issues.

You're right.

> I believe all those drivers should be fixed to use info->var instead of var to
> access the current xres, yres, xres_virtual, yres_virtual and bits_per_pixel
> fields in their pan display operation handler. However, this could break
> applications that rely on the current buggy behaviour. Would that be
> acceptable ?

Yes, as it is obviously wrong to assume other fields of var are valid (otherwise 
there would be no need for pan at all). So let's fix those drivers. I'll fix 
video/via ASAP (there it's also a bug to use xres_virtual as fix.line_length is 
more correct (alignment)) and have a look at the others as time permits (though 
it would be better if people fix them who have the ability to test).


Thanks a lot,

Florian Tobias Schandinat
