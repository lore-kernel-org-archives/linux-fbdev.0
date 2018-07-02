From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 02 Jul 2018 11:57:27 +0000
Subject: Re: [PATCH v2 1/2] efi/bgrt: Drop __initdata from bgrt_image_size
Message-Id: <45021554.rh2cuKUFdo@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180618151358.4830-1-hdegoede@redhat.com>
 <CGME20180702114612epcas5p1310822ec3e2b8141aee07b0557e33ddf@epcas5p1.samsung.com>
 <CAKv+Gu9-=cjZy72-V99VXRmjRtZN93Azafxduwvmy8OOVobXnw@mail.gmail.com>
In-Reply-To: <CAKv+Gu9-=cjZy72-V99VXRmjRtZN93Azafxduwvmy8OOVobXnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>

On Monday, July 02, 2018 01:46:09 PM Ard Biesheuvel wrote:
> On 2 July 2018 at 13:26, Hans de Goede <hdegoede@redhat.com> wrote:
> > Bartlomiej,
> >
> > Now that the fbcon deferred console takeover patches have been
> > merged I believe this series can be merged too ?
> >
> > Note the first patch has an ack from Ard for merging the
> > 1 line efi change through the fbdev tree.
> >
> 
> ... or I could take everything through the efi tree instead, as
> already discussed between Bartlomiej and me in the context of another
> patch series that touches both the fbdev and efi trees.
> 
> Bartlomiej, that would require your ack on patch
> 
> [PATCH v2 2/2] efifb: Copy the ACPI BGRT boot graphics to the framebuffer
> 
> https://marc.info/?l=linux-fbdev&m2933484616993&w=2
> 
> so if you're ok with that, I will queue both of these for v4.19

I would really prefer to merge this patchset through fbdev tree
as efi tree doesn't have fbcon deferred console takeover patches
(which are required by efifb changes under discussion).

> > On 18-06-18 17:13, Hans de Goede wrote:
> >>
> >> bgrt_image_size is necessary to (optionally) show the boot graphics from
> >> the efifb code. The efifb driver is a platform driver, using a normal
> >> driver probe() driver callback. So even though it is always builtin it
> >> cannot reference __initdata.
> >>
> >> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >>   drivers/firmware/efi/efi-bgrt.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/firmware/efi/efi-bgrt.c
> >> b/drivers/firmware/efi/efi-bgrt.c
> >> index 50793fda7819..b22ccfb0c991 100644
> >> --- a/drivers/firmware/efi/efi-bgrt.c
> >> +++ b/drivers/firmware/efi/efi-bgrt.c
> >> @@ -20,7 +20,7 @@
> >>   #include <linux/efi-bgrt.h>
> >>     struct acpi_table_bgrt bgrt_tab;
> >> -size_t __initdata bgrt_image_size;
> >> +size_t bgrt_image_size;
> >>     struct bmp_header {
> >>         u16 id;

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

