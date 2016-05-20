From: Ming Lei <ming.lei@canonical.com>
Date: Fri, 20 May 2016 02:17:08 +0000
Subject: Re: [PATCH] fbcon: warn on invalid cursor blink intervals
Message-Id: <CACVXFVM77CaHGE9kwhaxoa-fuNxZrDDzpCdHfnRno857pQANZQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1463510464-28124-1-git-send-email-ddaney.cavm@gmail.com>
	<20160517204912.GA29719@amd>
	<CACVXFVPdjfFkRFucTQsOHsVFtgm1W0JtOTqjyDzyNbzygghUyg@mail.gmail.com>
	<alpine.DEB.2.10.1605181519540.8967@laptop>
	<ed8fa4ca-49e0-3ff4-5499-fc5250dd8ae2@caviumnetworks.com>
	<alpine.DEB.2.10.1605182252230.12118@laptop>
	<573DE2D0.1050402@caviumnetworks.com>
	<alpine.DEB.2.10.1605191708400.15396@laptop>
	<alpine.DEB.2.10.1605191726030.15478@laptop>
In-Reply-To: <alpine.DEB.2.10.1605191726030.15478@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Scot Doyle <lkml14@scotdoyle.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, David Daney <david.daney@cavium.com>, Dann Frazier <dann.frazier@canonical.com>, Jeremy Kerr <jk@ozlabs.org>, Peter Hurley <peter@hurleysoftware.com>, Pavel Machek <pavel@ucw.cz>, Jonathan Liu <net147@gmail.com>, Alistair Popple <alistair@popple.id.au>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Chintakuntla, Radha" <Radha.Chintakuntla@caviumnetworks.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, David Airlie <airlied@linux.ie>, David Daney <ddaney.cavm@gmail.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>

On Fri, May 20, 2016 at 6:31 AM, Scot Doyle <lkml14@scotdoyle.com> wrote:
> Two systems are locking on boot [1] because ops->cur_blink_jiffies
> is set to zero from vc->vc_cur_blink_ms.
>
> Ignore such invalid intervals and log a warning.
>
> [1] https://bugs.launchpad.net/bugs/1574814
>
> Suggested-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Scot Doyle <lkml14@scotdoyle.com>
> Cc: <stable@vger.kernel.org> [v4.2]

Not sure this one is needed for stable because it justs dumps
a warning, and not set a valid period to ops->cur_blink_jiffies.

So I guess other fix patch is still required for the soft lockup issue, right?

Thanks,

> ---
>  drivers/video/console/fbcon.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
> index 6e92917..fad5b89 100644
> --- a/drivers/video/console/fbcon.c
> +++ b/drivers/video/console/fbcon.c
> @@ -1095,7 +1095,13 @@ static void fbcon_init(struct vc_data *vc, int init)
>                 con_copy_unimap(vc, svc);
>
>         ops = info->fbcon_par;
> -       ops->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
> +
> +       if (vc->vc_cur_blink_ms >= 50)
> +               ops->cur_blink_jiffies > +                   msecs_to_jiffies(vc->vc_cur_blink_ms);
> +       else
> +               WARN_ONCE(1, "blink interval < 50 ms");
> +
>         p->con_rotate = initial_rotation;
>         set_blitting_type(vc, info);
>
> @@ -1309,7 +1315,11 @@ static void fbcon_cursor(struct vc_data *vc, int mode)
>         int y;
>         int c = scr_readw((u16 *) vc->vc_pos);
>
> -       ops->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
> +       if (vc->vc_cur_blink_ms >= 50)
> +               ops->cur_blink_jiffies > +                   msecs_to_jiffies(vc->vc_cur_blink_ms);
> +       else
> +               WARN_ONCE(1, "blink interval < 50 ms");
>
>         if (fbcon_is_inactive(vc, info) || vc->vc_deccm != 1)
>                 return;
> --
> 2.1.4
>
