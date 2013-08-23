From: Prabhakar Lad <prabhakar.csengg@gmail.com>
Date: Fri, 23 Aug 2013 07:44:06 +0000
Subject: Re: [PATCH] video: da8xx-fb: adding dt support
Message-Id: <CA+V-a8vyD57-WM7JusQ28RwyLP0Y7DZg+GrS4kro=Ck7Qv28Eg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1377206501-30519-1-git-send-email-detheridge@ti.com> <1377206501-30519-2-git-send-email-detheridge@ti.com>
In-Reply-To: <1377206501-30519-2-git-send-email-detheridge@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Darren Etheridge <detheridge@ti.com>
Cc: devicetree@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, plagnioj@jcrosoft.com, LFBDEV <linux-fbdev@vger.kernel.org>, afzal@ti.com

Hi Darren,

Thanks for the patch.

On Fri, Aug 23, 2013 at 2:51 AM, Darren Etheridge <detheridge@ti.com> wrote:
> Enhancing driver to enable probe triggered by a corresponding dt entry.
>
> Add da8xx-fb.txt documentation to devicetree section.
>
> Obtain fb_videomode details for the connected lcd panel using the
> display timing details present in DT.
>
> Ensure that platform data is present before checking whether platform
> callback is present (the one used to control backlight). So far this
> was not an issue as driver was purely non-DT triggered, but now DT
> support has been added this check must be performed.
>
> v2: squashing multiple commits from Afzal Mohammed (afzal@ti.com)
> v3: remove superfluous cast
> v4: expose both ti,am3352-lcdc and ti,da830-lcdc for .compatible
>         as driver can use enhanced features of all version of the
>         silicon block.
> v5: addressed review comments from Prabhakar Lad
> v6: Changed the .compatible naming to match the existing drm bindings
>         for am33xx devices
>
> Signed-off-by: Darren Etheridge <detheridge@ti.com>
> ---
>  .../devicetree/bindings/video/da8xx-fb.txt         |   42 ++++++++++++
>  drivers/video/da8xx-fb.c                           |   66 +++++++++++++++++++-
>  2 files changed, 105 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/video/da8xx-fb.txt
>
> diff --git a/Documentation/devicetree/bindings/video/da8xx-fb.txt b/Documentation/devicetree/bindings/video/da8xx-fb.txt
> new file mode 100644
> index 0000000..575bb4b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/da8xx-fb.txt
> @@ -0,0 +1,42 @@
> +TI LCD Controller on DA830/DA850/AM335x SoC's
> +
> +Required properties:
> +- compatible:
> +       DA830 - "ti,da8xx-tilcdc"
> +       AM335x SoC's - "ti,am33xx-tilcdc"

what about DA850 ?

Rest of the patch looks good, with that change you can add my,

Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Regards,
--Prabhakar Lad
