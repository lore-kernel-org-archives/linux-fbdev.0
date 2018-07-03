From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 03 Jul 2018 15:24:52 +0000
Subject: Re: [PATCH v2 1/2] efi/bgrt: Drop __initdata from bgrt_image_size
Message-Id: <1657054.xB6YDx91rD@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180618151358.4830-1-hdegoede@redhat.com>
 <45021554.rh2cuKUFdo@amdc3058>
 <CAKv+Gu9B58b75PC2F6e5ujVwXRisyM5TZ+18sski2OznJXDOhg@mail.gmail.com>
 <CGME20180703152453eucas1p2b6fe0c9a8c8e0e7607a5d5bd8438f61e@eucas1p2.samsung.com>
In-Reply-To: <CAKv+Gu9B58b75PC2F6e5ujVwXRisyM5TZ+18sski2OznJXDOhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>

On Monday, July 02, 2018 02:02:47 PM Ard Biesheuvel wrote:
> On 2 July 2018 at 13:57, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> > On Monday, July 02, 2018 01:46:09 PM Ard Biesheuvel wrote:
> >> On 2 July 2018 at 13:26, Hans de Goede <hdegoede@redhat.com> wrote:
> >> > Bartlomiej,
> >> >
> >> > Now that the fbcon deferred console takeover patches have been
> >> > merged I believe this series can be merged too ?
> >> >
> >> > Note the first patch has an ack from Ard for merging the
> >> > 1 line efi change through the fbdev tree.
> >> >
> >>
> >> ... or I could take everything through the efi tree instead, as
> >> already discussed between Bartlomiej and me in the context of another
> >> patch series that touches both the fbdev and efi trees.
> >>
> >> Bartlomiej, that would require your ack on patch
> >>
> >> [PATCH v2 2/2] efifb: Copy the ACPI BGRT boot graphics to the framebuffer
> >>
> >> https://marc.info/?l=linux-fbdev&m2933484616993&w=2
> >>
> >> so if you're ok with that, I will queue both of these for v4.19
> >
> > I would really prefer to merge this patchset through fbdev tree
> > as efi tree doesn't have fbcon deferred console takeover patches
> > (which are required by efifb changes under discussion).
> >
> 
> Ah ok, I didn't realise that. I don't think there will be any
> conflicts, since the efifb changes in the efi tree and these changes
> operate on different parts of the file. But let's double check before
> taking stuff into -next.
> (efi/next is not pulled into -next directly, but via the tip:efi tree,
> and I haven't sent a pull request yet for v4.19)

I've verified this with -next from today and it auto-merged fine (for
testing purposes I've applied both patches to -next and then pulled in
efi/next from efi.git tree).

I've applied both patches to fbdev-for-next (I hope it is fine with you).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

