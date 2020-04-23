From: Markus Elfring <Markus.Elfring@web.de>
Date: Thu, 23 Apr 2020 12:14:48 +0000
Subject: Re: [PATCH v1] fbdev: sm712fb: fix an issue about iounmap for a wrong address
Message-Id: <bb6ba7c9-ad92-9c54-e1c4-91d2f7d0f5f8@web.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Dejin Zheng <zhengdejin5@gmail.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

> the sfb->fb->screen_base is not save the value get by iounmap() when
> the chip id is 0x720.

I suggest to improve this change description.
How did you determine relevant differences for the mentioned chip model?


> so iounmap() for address sfb->fb->screen_base is not right.

Will another imperative wording become helpful here?


=E2=80=A6
> +++ b/drivers/video/fbdev/sm712fb.c
> @@ -1429,6 +1429,8 @@  static int smtc_map_smem(struct smtcfb_info *sfb,
>  static void smtc_unmap_smem(struct smtcfb_info *sfb)
>  {
>  	if (sfb && sfb->fb->screen_base) {
> +		if (sfb->chip_id =3D=3D 0x720)
> +			sfb->fb->screen_base -=3D 0x00200000;
>  		iounmap(sfb->fb->screen_base);

How do you think about to use descriptive identifiers for
the shown constants?

Would you like to clarify any related software analysis approaches?

Regards,
Markus
