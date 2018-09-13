From: David Herrmann <dh.herrmann@gmail.com>
Date: Thu, 13 Sep 2018 06:51:46 +0000
Subject: Re: [PATCH] efifb: BGRT: Add nobgrt option
Message-Id: <CANq1E4Tv1JNmk2Jn=Sxv3pgdtO8Pf+2EgX3nYF_pE1L-Uxzqsw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180912091235.20473-1-hdegoede@redhat.com>
In-Reply-To: <20180912091235.20473-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi

On Wed, Sep 12, 2018 at 11:12 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> In some setups restoring the BGRT logo is undesirable, allow passing
> video=EFifb:nobgrt on the kernel commandline to disable it.
>
> Cc: David Herrmann <dh.herrmann@gmail.com>
> Reported-by: David Herrmann <dh.herrmann@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/video/fbdev/efifb.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

Thanks a lot!
David

> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index 3946649b85c8..ba906876cc45 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -42,6 +42,7 @@ struct bmp_dib_header {
>         u32 colors_important;
>  } __packed;
>
> +static bool use_bgrt =3D true;
>  static bool request_mem_succeeded =3D false;
>  static u64 mem_flags =3D EFI_MEMORY_WC | EFI_MEMORY_UC;
>
> @@ -160,6 +161,9 @@ static void efifb_show_boot_graphics(struct fb_info *=
info)
>         void *bgrt_image =3D NULL;
>         u8 *dst =3D info->screen_base;
>
> +       if (!use_bgrt)
> +               return;
> +
>         if (!bgrt_tab.image_address) {
>                 pr_info("efifb: No BGRT, not showing boot graphics\n");
>                 return;
> @@ -290,6 +294,8 @@ static int efifb_setup(char *options)
>                                 screen_info.lfb_width =3D simple_strtoul(=
this_opt+6, NULL, 0);
>                         else if (!strcmp(this_opt, "nowc"))
>                                 mem_flags &=3D ~EFI_MEMORY_WC;
> +                       else if (!strcmp(this_opt, "nobgrt"))
> +                               use_bgrt =3D false;
>                 }
>         }
>
> --
> 2.19.0.rc0
>
