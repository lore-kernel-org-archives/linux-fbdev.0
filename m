From: Rob Herring <robh@kernel.org>
Date: Mon, 24 Apr 2017 15:09:41 +0000
Subject: Re: [PATCH v8 1/3] backlight arcxcnn add arc to vendor prefix
Message-Id: <CAL_JsqJ+=fQ2e752iCHs0dbdrkotuDtKp=2Z2_xnyCtMnxWV8A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1489607133-7870-1-git-send-email-olimpiu@arcticsand.com>
In-Reply-To: <1489607133-7870-1-git-send-email-olimpiu-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Olimpiu Dejeu <olimpiu-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, bdodge-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, medasaro-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

On Wed, Mar 15, 2017 at 2:45 PM, Olimpiu Dejeu <olimpiu@arcticsand.com> wrote:
> backlight: Add arc to vendor prefixes
> Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>
> ---
> v8:
> - Version to match other patches in set
>
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 16d3b5e..6f33a4b 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -28,6 +28,7 @@ andestech     Andes Technology Corporation
>  apm    Applied Micro Circuits Corporation (APM)
>  aptina Aptina Imaging
>  arasan Arasan Chip Systems
> +arc    Arctic Sand

arc is also a cpu arch. While not a vendor, it could be confusing. How
about "arctic" instead?

BTW, some reason your patches are not going to the DT list.

Rob
