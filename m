From: Jun Nie <niej0001@gmail.com>
Subject: Re: [PATCH 3/6] pxa: fix pxa168 lcd controller vsync/hsync timing 
	error
Date: Tue, 3 Nov 2009 15:29:52 +0800
Message-ID: <7c34ac520911022329o16357d02i3c8878e6278c2e9d@mail.gmail.com>
References: <7c34ac520911022245x7f002a7at846a835dfded550c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7c34ac520911022245x7f002a7at846a835dfded550c@mail.gmail.com>
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
> pxa: fix pxa168 lcd controller vsync/hsync timing error
>
> Signed-off-by: Jun Nie <njun@marvell.com>
> ---
> =A0drivers/video/pxa168fb.c | =A0 =A04 ++--
> =A0include/video/pxa168fb.h | =A0 =A02 --
> =A02 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
> index 2ba1444..bdd524c 100644
> --- a/drivers/video/pxa168fb.c
> +++ b/drivers/video/pxa168fb.c
> @@ -459,8 +459,8 @@ static void set_dumb_panel_control(struct fb_info *in=
fo)
> =A0 =A0 =A0 =A0x |=3D mi->invert_composite_blank ? 0x00000040 : 0;
> =A0 =A0 =A0 =A0x |=3D (info->var.sync & FB_SYNC_COMP_HIGH_ACT) ? 0x000000=
20 : 0;
> =A0 =A0 =A0 =A0x |=3D mi->invert_pix_val_ena ? 0x00000010 : 0;
> - =A0 =A0 =A0 x |=3D (info->var.sync & FB_SYNC_VERT_HIGH_ACT) ? 0 : 0x000=
00008;
> - =A0 =A0 =A0 x |=3D (info->var.sync & FB_SYNC_HOR_HIGH_ACT) ? 0 : 0x0000=
0004;
> + =A0 =A0 =A0 x |=3D (info->var.sync & FB_SYNC_VERT_HIGH_ACT) ? 0x0000000=
8 : 0;
> + =A0 =A0 =A0 x |=3D (info->var.sync & FB_SYNC_HOR_HIGH_ACT) ? 0x00000004=
 : 0;
> =A0 =A0 =A0 =A0x |=3D mi->invert_pixclock ? 0x00000002 : 0;
>
> =A0 =A0 =A0 =A0writel(x, fbi->reg_base + LCD_SPU_DUMB_CTRL);
> diff --git a/include/video/pxa168fb.h b/include/video/pxa168fb.h
> index f0497ae..7206483 100644
> --- a/include/video/pxa168fb.h
> +++ b/include/video/pxa168fb.h
> @@ -117,8 +117,6 @@ struct pxa168fb_mach_info {
> =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0invert_composite_blank:1;
> =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0invert_pix_val_ena:1;
> =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0invert_pixclock:1;
> - =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0invert_vsync:1;
> - =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0invert_hsync:1;
> =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0panel_rbswap:1;
> =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0active:1;
> =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0enable_lcd:1;
> --
> 1.5.4.3
>

add linux-fbdev@vger.kernel.org
