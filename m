From: David Herrmann <dh.herrmann@gmail.com>
Date: Fri, 16 Aug 2013 20:36:13 +0000
Subject: Re: [PATCH v2] efifb: prevent null dereferences by removing unused array indices from dmi_list
Message-Id: <CANq1E4S5iH+oe=P12J7TghjAq8sTHhEDWQ=CfPumjjVyEX=GuQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <C9C6655E-4974-4C04-8CEE-CA16563F4CC5@gmail.com>
	<CANq1E4STAFLpDoyLHxXVXqk7mjzmBr1jO3XuxL2B+cJzgHe0vA@mail.gmail.com>
	<1376684395.6529.5.camel@hermes>
In-Reply-To: <1376684395.6529.5.camel@hermes>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: James Bates <james.h.bates@gmail.com>
Cc: Peter Jones <pjones@redhat.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>

Hi

On Fri, Aug 16, 2013 at 10:19 PM, James Bates <james.h.bates@gmail.com> wro=
te:
> On Fri, 2013-08-16 at 15:37 +0200, David Herrmann wrote:
>
> Hi
> (CC'ing hpa)
>
> Yepp, this patch looks good:
> Reviewed-by: David Herrmann <dh.herrmann@gmail.com>
>
> However, I'd like to see some code to prevent this from happening
> again. It isn't really obvious that removing an entry will result in a
> NULL-deref. I am not the maintainer of this code, but I'd really like
> to see a "(dmi_list[i].optname && !strcmp())" check in efifb_setup().
> Otherwise we _will_ run into this again.
>
> Side note: this code got moved to arch/x86/kernel/sysfb_efi.c in the
> x86 tree. I am adding hpa here so he will remember this once Linus
> gets a merge conflict (iff the sysfb changes get merged through the
> x86 tree).
>
> Thanks
> David
>
> Sure thing, here is the patch again, with the extra check in efifb_setup()
> (it turns out one can simply
> switch around the order of the checks: implicitly initialized dmi_list it=
ems
> will have base =3D 0):

You can put such comments below the "---" in your patch so they will
not show up in the commit-message (between commit message and the
diffstat).

> Full patch v2:
>
> the dmi_list array is initialized using gnu designated initializers, and
> therefore
> contains fewer explicitly defined entries as there are elements in it. Th=
is
> is because the enum above with M_blabla constants contains more items than
> the designated
> initializer. Those elements not explicitly initialized are implicitly set=
 to
> 0.
>
> Now efifb_setup(), L.322 & L.323, loops through all these array elements,
> and performs
> a strcmp o a field (optname) in each item. For non explicitly initialized
> elements this
> will be a null pointer:
>
>                         for (i =3D 0; i < M_UNKNOWN; i++) {
>                                 if (!strcmp(this_opt, dmi_list[i].optname)
> &&
>
> On my macbook6,1 the predefined values are for some reason incorrect, and
> most parameters
> are preset correctly by my efi bootloader (elilo). but stride/line_length=
 is
> not detected
> correctly and so I wish to set it explicitly using a
> "video=EFifb:stride:2048" command-line
> argument. Because of the above null dereference, an exception (presumably)
> occurs before
> the parsing code (L.333) is ever reached. I say presumably since the mac
> hangs on boot
> without a console, and I can therefore not see any output.
>
> By removing the unused values from the enum, and thus preventing implicit=
ly
> initialized items
> in the dmi_list array, the null dereference does not occur, my customer
> command-line arg is
> parsed correctly, and my console displays correctly.
>
> This patch removes the unused enum values, and also guards against any
> future implicit
> initializing by inverting the check order in the if statement, and checki=
ng
> first whether
> dmi_list[i].base is null.
>
> Signed-off-by: James Bates <james.h.bates@yahoo.com>
> ---
> drivers/video/efifb.c | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
> index 50fe668..161757b 100644
>
> --- a/drivers/video/efifb.c
> +++ b/drivers/video/efifb.c
> @@ -50,12 +50,9 @@ enum {
> M_MINI_3_1, /* Mac Mini, 3,1th gen */
> M_MINI_4_1, /* Mac Mini, 4,1th gen */
> M_MB, /* MacBook */
> - M_MB_2, /* MacBook, 2nd rev. */
> - M_MB_3, /* MacBook, 3rd rev. */
> M_MB_5_1, /* MacBook, 5th rev. */
> M_MB_6_1, /* MacBook, 6th rev. */
> M_MB_7_1, /* MacBook, 7th rev. */
> - M_MB_SR, /* MacBook, 2nd gen, (Santa Rosa) */
> M_MBA, /* MacBook Air */
> M_MBA_3, /* Macbook Air, 3rd rev */
> M_MBP, /* MacBook Pro */
> @@ -323,8 +320,8 @@ static int __init efifb_setup(char *options)
> if (!*this_opt) continue;
>
>
> for (i =3D 0; i < M_UNKNOWN; i++) {
> - if (!strcmp(this_opt, dmi_list[i].optname) &&
> -     dmi_list[i].base !=3D 0) {
> + if (dmi_list[i].base !=3D 0 &&

From a quick glance, M_MBA_3 has "base =3D 0" but is a valid entry. Hm,
I think we can be sure that there will never be a framebuffer at phys
0, so yeah, I am fine with this.

Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

Regards
David

> +     !strcmp(this_opt, dmi_list[i].optname)) {
> screen_info.lfb_base =3D dmi_list[i].base;
> screen_info.lfb_linelength =3D dmi_list[i].stride;
> screen_info.lfb_width =3D dmi_list[i].width;
> --
>
