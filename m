From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 20 Mar 2020 13:35:32 +0000
Subject: Re: [PATCH] Fix off by one in nvidia driver strncpy size arg
Message-Id: <a0fdfd97-d3e2-3299-0d1c-df13158e799a@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200309125343eucas1p17700a344a70dedd4c8a04c6f9ba4c7ac@eucas1p1.samsung.com>
 <20200309124947.4502-1-dominik.b.czarnota@gmail.com>
In-Reply-To: <20200309124947.4502-1-dominik.b.czarnota@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dominik 'disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org


On 3/9/20 1:49 PM, Dominik 'disconnect3d' Czarnota wrote:
> From: disconnect3d <dominik.b.czarnota@gmail.com>
> 
> This patch fixes an off-by-one error in strncpy size argument in
> drivers/video/fbdev/nvidia/nvidia.c. The issue is that in:
> 
>         strncmp(this_opt, "noaccel", 6)
> 
> the passed string literal: "noaccel" has 7 bytes (without the NULL byte)
> and the passed size argument is 6. As a result, the logic will also
> match/accept string "noacce" or "noacceX".
> 
> This bug doesn't seem to have any security impact since its present in
> the driver's setup and just accepts slighty changed string to enable the
> `noaccel` flag.
> 
> Signed-off-by: disconnect3d <dominik.b.czarnota@gmail.com>

Patch looks fine but please fix 'From:' and 'S-o-b:' lines,

per Documentation/process/submitting-patches.rst:

...
then you just add a line saying::

        Signed-off-by: Random J Developer <random@developer.example.org>

using your real name (sorry, no pseudonyms or anonymous contributions.)
...

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
> 
> Notes:
>     The bug could also be fixed by changing the size argument to
>     `sizeof("string literal")-1` but I am not proposing this change as that
>     would have to be changed in other places.
>     
>     There are also more cases like this in kernel sources which I
>     reported/will report soon.
>     
>     This bug has been found by running a massive grep-like search using
>     Google's BigQuery on GitHub repositories data. I am also going to work
>     on a CodeQL/Semmle query to be able to find more sophisticated cases
>     like this that can't be found via grepping.
> 
>  drivers/video/fbdev/nvidia/nvidia.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
> index c583c018304d..b77efeb33477 100644
> --- a/drivers/video/fbdev/nvidia/nvidia.c
> +++ b/drivers/video/fbdev/nvidia/nvidia.c
> @@ -1470,7 +1470,7 @@ static int nvidiafb_setup(char *options)
>  			flatpanel = 1;
>  		} else if (!strncmp(this_opt, "hwcur", 5)) {
>  			hwcur = 1;
> -		} else if (!strncmp(this_opt, "noaccel", 6)) {
> +		} else if (!strncmp(this_opt, "noaccel", 7)) {
>  			noaccel = 1;
>  		} else if (!strncmp(this_opt, "noscale", 7)) {
>  			noscale = 1;
> 
