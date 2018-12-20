From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 20 Dec 2018 16:10:20 +0000
Subject: Re: [PATCH] video: offb: Pass actual name in offb_init_palette_hacks
Message-Id: <CA+7wUszBpmd2r18WZVjAXv2xq+ySrnKTqaRT7bGcHa71_M_j7g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181207125844.18775-1-malat@debian.org>
In-Reply-To: <20181207125844.18775-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: "# v4 . 11" <stable@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Rob, any comment ?

On Fri, Dec 7, 2018 at 1:59 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> This is a partial revert of commit 5c63e407aaab ("fbdev: Convert to
> using %pOFn instead of device_node.name"). This is the minimal work to
> get a Mac Mini G4 back to a bootable state. The function
> offb_init_palette_hacks would need to handle the case where `name` has
> been set to NULL.
>
> Cc: Rob Herring <robh@kernel.org>
> Fixes: 5c63e407aaab ("fbdev: Convert to using %pOFn instead of device_node.name")
> Cc: stable@vger.kernel.org # v4.19+
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  drivers/video/fbdev/offb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
> index 31f769d67195..6e75851f8142 100644
> --- a/drivers/video/fbdev/offb.c
> +++ b/drivers/video/fbdev/offb.c
> @@ -648,7 +648,7 @@ static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
>                 /* kludge for valkyrie */
>                 if (strcmp(dp->name, "valkyrie") = 0)
>                         address += 0x1000;
> -               offb_init_fb(no_real_node ? "bootx" : NULL,
> +               offb_init_fb(no_real_node ? "bootx" : dp->name,
>                              width, height, depth, pitch, address,
>                              foreign_endian, no_real_node ? NULL : dp);
>         }
> --
> 2.19.2
>
