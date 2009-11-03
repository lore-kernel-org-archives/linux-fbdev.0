From: Jun Nie <niej0001@gmail.com>
Subject: Re: [PATCH 2/6] pxa: frame buffer support both pxa168 and pxa910
Date: Tue, 3 Nov 2009 15:29:16 +0800
Message-ID: <7c34ac520911022329t1dd9ff14q42a553be2b6a287e@mail.gmail.com>
References: <7c34ac520911022245o4c8fd276vcaf0d8d106b77da3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7c34ac520911022245o4c8fd276vcaf0d8d106b77da3@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-fbdev-devel@lists.sourceforge.net, linux-fbdev@vger.kernel.org

2009/11/3 Jun Nie <niej0001@gmail.com>:
> pxa: frame buffer support both pxa168 and pxa910
>
> Signed-off-by: Jun Nie <njun@marvell.com>
> ---
> =A0drivers/video/pxa168fb.c | =A0 =A06 ++++++
> =A01 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
> index 27bdf2b..2ba1444 100644
> --- a/drivers/video/pxa168fb.c
> +++ b/drivers/video/pxa168fb.c
> @@ -875,12 +875,18 @@ failed:
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> + static const struct platform_device_id mmpfb_id_table[] =3D {
> + =A0 =A0 =A0 =A0{"pxa168-fb", 0},
> + =A0 =A0 =A0 =A0{"pxa910-fb", 1},
> + };
> +
> =A0static struct platform_driver pxa168fb_driver =3D {
> =A0 =A0 =A0 =A0.driver =A0 =A0 =A0 =A0 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "pxa168-fb",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =A0=3D THIS_MODULE,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D pxa168fb_probe,
> + =A0 =A0 =A0 .id_table =A0 =A0 =A0 =3D mmpfb_id_table,
> =A0};
>
> =A0static int __devinit pxa168fb_init(void)
> --
> 1.5.4.3
>

add linux-fbdev@vger.kernel.org
