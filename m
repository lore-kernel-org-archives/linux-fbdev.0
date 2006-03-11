From: "Thibaut VARENE" <T-Bone@parisc-linux.org>
Subject: Re: [PATCH 7/18] s1d13xxxfb: Fix resource leak
Date: Sat, 11 Mar 2006 11:22:49 -0500
Message-ID: <7d01f9f00603110822q57803642se6ad98fc601d18ec@mail.gmail.com>
References: <44122CCF.6080500@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FI6rl-0003BY-FN
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Mar 2006 08:22:53 -0800
Received: from zproxy.gmail.com ([64.233.162.195])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FI6rj-00081o-43
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Mar 2006 08:22:53 -0800
Received: by zproxy.gmail.com with SMTP id l8so955821nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 Mar 2006 08:22:49 -0800 (PST)
In-Reply-To: <44122CCF.6080500@gmail.com>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Acked-by: Thibaut VARENE <varenet@parisc-linux.org>

On 3/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> struct info may not be released in the driver's error path.
>
> Coverity Bug 672
>
> Signed-off-by: Antonino Daplas <adaplas@pol.net>
> ---
>
>  drivers/video/s1d13xxxfb.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/s1d13xxxfb.c b/drivers/video/s1d13xxxfb.c
> index e5d0f92..feec47b 100644
> --- a/drivers/video/s1d13xxxfb.c
> +++ b/drivers/video/s1d13xxxfb.c
> @@ -588,6 +588,7 @@ s1d13xxxfb_probe(struct platform_device
>                 goto bail;
>         }
>
> +       platform_set_drvdata(pdev, info);
>         default_par =3D info->par;
>         default_par->regs =3D ioremap_nocache(pdev->resource[1].start,
>                         pdev->resource[1].end - pdev->resource[1].start +=
1);
> @@ -638,8 +639,6 @@ s1d13xxxfb_probe(struct platform_device
>                 goto bail;
>         }
>
> -       platform_set_drvdata(pdev, info);
> -
>         printk(KERN_INFO "fb%d: %s frame buffer device\n",
>                info->node, info->fix.id);
>
>
>
>


--
Thibaut VARENE
http://www.parisc-linux.org/~varenet/


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
