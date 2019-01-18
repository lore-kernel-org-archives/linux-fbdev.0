From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 18 Jan 2019 20:09:58 +0000
Subject: Re: [PATCH] video/hdmi: Change strncpy() into memcpy() in hdmi_spd_infoframe_init
Message-Id: <CA+7wUswhGdSdhWpAi=PZANpr4X8yKKJkZUWTtsFLs0NAVQ76oQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190118193248.535-1-malat@debian.org> <d76c2a301d324239db09ccc7cd8421821ba93b87.camel@perches.com>
In-Reply-To: <d76c2a301d324239db09ccc7cd8421821ba93b87.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Fri, Jan 18, 2019 at 8:51 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2019-01-18 at 20:32 +0100, Mathieu Malaterre wrote:
> > Using strncpy() is less than perfect since the destination buffers do not
> > need to be NUL terminated. Replace strncpy() with memcpy() to address a
> > warning triggered by gcc using W=1 and optimize the code a bit.
> >
> > This commit removes the following warnings:
> >
> >   drivers/video/hdmi.c:234:2: warning: 'strncpy' specified bound 8 equals destination size [-Wstringop-truncation]
> >   drivers/video/hdmi.c:235:2: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
> []
> > diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
> []
> > @@ -231,8 +231,8 @@ int hdmi_spd_infoframe_init(struct hdmi_spd_infoframe *frame,
> >       frame->version = 1;
> >       frame->length = HDMI_SPD_INFOFRAME_SIZE;
> >
> > -     strncpy(frame->vendor, vendor, sizeof(frame->vendor));
> > -     strncpy(frame->product, product, sizeof(frame->product));
> > +     memcpy(frame->vendor, vendor, sizeof(frame->vendor));
> > +     memcpy(frame->product, product, sizeof(frame->product));
>
> This is not good.
>
> vendor can be any location and shorter than sizeof(frame->vendor)
> so this can copy from invalid memory locations.

Ah right. I did not realize that and know I see the call with "Intel",
will re-spin.

> You probably want strscpy.

Right.

> This is called with at least "mediatek" and "broadcom", so perhaps
> it's better still to change the struct vendor size to something a
> bit larger.  Maybe change vendor[8] to vendor[16];

Looks like 8 bytes is required for call like hdmi_spd_infoframe_unpack()

> include/linux/hdmi.h:struct hdmi_spd_infoframe {
> include/linux/hdmi.h-   enum hdmi_infoframe_type type;
> include/linux/hdmi.h-   unsigned char version;
> include/linux/hdmi.h-   unsigned char length;
> include/linux/hdmi.h-   char vendor[8];
> include/linux/hdmi.h-   char product[16];
> include/linux/hdmi.h-   enum hdmi_spd_sdi sdi;
> include/linux/hdmi.h-};
>
>
