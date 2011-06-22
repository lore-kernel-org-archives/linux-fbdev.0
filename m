From: JinGoo Han <jg1.han@samsung.com>
Date: Wed, 22 Jun 2011 03:42:17 +0000
Subject: [PATCH V4 1/5] ARM: EXYNOS4: Change clock name for FIMD
Message-Id: <16187978.109931308714136278.JavaMail.weblogic@epml08>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Kukjin Kim <kgene.kim@samsung.com>, Paul Mundt <lethal@linux-sh.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-f>
Cc: ANAND KUMAR N <anand.kn@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, THOMAS P ABRAHAM <thomas.ab@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kmpark@infradead.org>, In-Ki Dae <inki.dae@samsung.com>, ARM Linux <linux@arm.linux.org.uk>, Ben Dooks <ben-linux@fluff.org>, JinGoo Han <jg1.han@samsung.com>

This patch changes clock name for FIMD from "fimd" to "lcd".

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 arch/arm/mach-exynos4/clock.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
index 871f9d5..12e6853 100644
--- a/arch/arm/mach-exynos4/clock.c
+++ b/arch/arm/mach-exynos4/clock.c
@@ -433,12 +433,12 @@ static struct clk init_clocks_off[] =3D {
 		.enable		=3D exynos4_clk_ip_cam_ctrl,
 		.ctrlbit	=3D (1 << 3),
 	}, {
-		.name		=3D "fimd",
+		.name		=3D "lcd",
 		.id		=3D 0,
 		.enable		=3D exynos4_clk_ip_lcd0_ctrl,
 		.ctrlbit	=3D (1 << 0),
 	}, {
-		.name		=3D "fimd",
+		.name		=3D "lcd",
 		.id		=3D 1,
 		.enable		=3D exynos4_clk_ip_lcd1_ctrl,
 		.ctrlbit	=3D (1 << 0),
--=20
1.7.1

=FF=F4=E8=BA{.n=C7+=89=B7=9F=AE=89=AD=86+%=8A=CB=FF=B1=E9=DD=B6=17=A5=8Aw=
=FF=BA{.n=C7+=89=B7=A5=8A{=B1=FD=F6=DDz=FF=E2=9E=D8^n=87r=A1=F6=A6z=CB=1A=
=81=EBh=99=A8=E8=AD=DA&=A3=FB=E0z=BF=E4z=B9=DE=97=FA+=80=CA+zf=A3=A2=B7h=9A=
=88=A7~=86=AD=86=DBi=FF=FF=EF=81=EA=FF=91=EA=E7z_=E8=AE=0F=E6j:+v=89=A8=FE)=
=DF=A3=F8m
