From: Anand Kumar N <anand.kn@samsung.com>
Date: Wed, 22 Jun 2011 13:37:14 +0000
Subject: Re: [PATCH V5 5/5] ARM: EXYNOS4: Add platform data for EXYNOS4 FIMD
Message-Id: <BANLkTi=iS3H8xYhouvZZwP5_daxoGSBwLA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308724904-31521-1-git-send-email-jg1.han@samsung.com>
	<002901cc30c1$5ac6ef70$1054ce50$%szyprowski@samsung.com>
	<BANLkTimPjo+WefApQLe=HKbYLCwmo_gGRw@mail.gmail.com>
In-Reply-To: <BANLkTimPjo+WefApQLe=HKbYLCwmo_gGRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Paul Mundt <lethal@linux-sh.org>, linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, Jonghun Han <jonghun.han@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Kyungmin Park <kmpark@infradead.org>, Inki Dae <inki.dae@samsung.com>, ARM Linux <linux@arm.linux.org.uk>, Ben Dooks <ben-linux@fluff.org>

Hi Marek/Jingoo,

On Wed, Jun 22, 2011 at 3:17 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hello,
>
> On Wednesday, June 22, 2011 8:42 AM Jingoo Han wrote:
>
>> From: Jonghun Han <jonghun.han@samsung.com>
(snipped)
Instead of hardcoding the parent clock in platform/bootloader code ,is
it not possible to select/set the
parent clock based on the pixel clk(plat data) having the least delta
with the 9 src clks.with this change I have checked it for WA101S.
These are the changes I am proposing..

arch/arm/mach-exynos4/clock.c
+struct clk *clkset_sclk_fimd0_list[] =3D {
+ =A0 =A0 =A0 =A0[0] =3D &clk_sclk_xxti,
+ =A0 =A0 =A0 =A0[1] =3D &clk_sclk_xusbxti,
+ =A0 =A0 =A0 =A0[2] =3D &clk_sclk_hdmi27m,
+ =A0 =A0 =A0 =A0[3] =3D &clk_sclk_usbphy0,
+ =A0 =A0 =A0 =A0[4] =3D &clk_sclk_usbphy1,
+ =A0 =A0 =A0 =A0[5] =3D &clk_sclk_hdmiphy,
+ =A0 =A0 =A0 =A0[6] =3D &clk_mout_mpll.clk,
+ =A0 =A0 =A0 =A0[7] =3D &clk_mout_epll.clk,
+ =A0 =A0 =A0 =A0[8] =3D &clk_sclk_vpll.clk,
+};
arch/arm/mach-exynos4/mach-smdkv310.c
+static int fimd_s3c_consider_clock(struct device *sfb,int src
,unsigned int wanted)
+{
+ =A0 =A0 =A0 =A0unsigned long rate =3D 0;
+ =A0 =A0 =A0 =A0int div =3D1;
+ =A0 =A0 =A0 =A0struct clk *mout_mpll =3D NULL;
+
+ =A0 =A0 =A0 =A0if(clkset_sclk_fimd0_list[src]){
+ =A0 =A0 =A0 =A0mout_mpll =3D clk_get(sfb,clkset_sclk_fimd0_list[src]->nam=
e);
+ =A0 =A0 =A0 =A0if (IS_ERR(mout_mpll)) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(sfb, "failed to clk_get
%s\n",clkset_sclk_fimd0_list[src]->name);
+ =A0 =A0 =A0 =A0}
+
+ =A0 =A0 =A0 =A0rate =3D clk_get_rate(mout_mpll);
+
+ =A0 =A0 =A0 =A0for (div =3D 1; div < 256; div *=3D 2) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((rate / div) <=3D wanted)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
+ =A0 =A0 =A0 =A0}
+
+
+ =A0 =A0 =A0 }
+ =A0 =A0 =A0 =A0return (wanted - (rate / div));
+}
+
+int exynos4_fimd0_find_clock(struct platform_device *pdev,struct clk
**lcd_clk,unsigned int clock(pixel clock needed for the lcd))
+{
+ =A0 =A0 =A0 =A0int best =3D 0;
+ =A0 =A0 =A0 =A0int delta =3D 0;
+ =A0 =A0 =A0 =A0int best_src =3D 0;
+ =A0 =A0 =A0 =A0int src;
+ =A0 =A0 =A0 =A0struct clk *best_clk_src =3D NULL;
+ =A0 =A0 =A0 struct clk *clk =A0=3D NULL;
+
+ =A0 =A0 =A0 if (clock =3D 0)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
+
+ =A0 =A0 =A0 =A0for (src =3D 0; src < MAX_NUM_CLKS ;src++) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0delta =3D fimd_s3c_consider_clock(&pdev->d=
ev,src,clock);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (delta < best) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0best =3D delta;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0best_src =3D src;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
+ =A0 =A0 =A0 =A0}
+ =A0 =A0 =A0 clk =3D clk_get(&pdev->dev, "sclk_fimd");
+ =A0 =A0 =A0 =A0if (IS_ERR(clk)) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get sclk for f=
imd\n");
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_clk2;
+ =A0 =A0 =A0 }
+
+ =A0 =A0 =A0 best_clk_src clk_get(&pdev->dev,clkset_sclk_fimd0_list[best_s=
rc]->name);
+ =A0 =A0 =A0 if (IS_ERR(best_clk_src)) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get best_src\n=
");
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_clk1;
+ =A0 =A0 =A0 }
+ =A0 =A0 =A0 clk_set_parent(clk,best_clk_src);
+ =A0 =A0 =A0 *lcd_clk =3D clk;
+ =A0 =A0 =A0 =A0clk_put(best_clk_src);
+ =A0 =A0 =A0 =A0clk_enable(clk);
+ =A0 =A0 =A0 =A0dev_dbg(&pdev->dev, "set fimd sclk rate to %d\n", clock);
+
+err_clk1:
+ =A0 =A0 =A0 clk_put(best_clk_src);
+err_clk2:
+ =A0 =A0 =A0 clk_put(clk);
+
+ =A0 =A0 =A0 return -EINVAL;
+}
I have based these patches on the v1 version of this patch.I can base
these changes
on your latest changes(v6) and send as a patch.

>> +static int __init smdkc210_fimd0_setup_clock(void)
>> +{
>> + =A0 =A0 struct clk *sclk =3D NULL;
>> + =A0 =A0 struct clk *mout_mpll =3D NULL;
>> +
>> + =A0 =A0 u32 rate =3D 0;
>> +
>> + =A0 =A0 sclk =3D clk_get(&s5p_device_fimd0.dev, "sclk_fimd");
>> + =A0 =A0 if (IS_ERR(sclk)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "failed to get sclk for fimd\n=
");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_clk2;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 mout_mpll =3D clk_get(NULL, "mout_mpll");
>> + =A0 =A0 if (IS_ERR(mout_mpll)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "failed to get mout_mpll\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_clk1;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 clk_set_parent(sclk, mout_mpll);
>> + =A0 =A0 if (!rate)
>> + =A0 =A0 =A0 =A0 =A0 =A0 rate =3D 134000000;
>> +
>> + =A0 =A0 clk_set_rate(sclk, rate);
>> +
>> + =A0 =A0 clk_put(sclk);
>> + =A0 =A0 clk_put(mout_mpll);
>> +
>> + =A0 =A0 return 0;
>> +
>> +err_clk1:
>> + =A0 =A0 clk_put(mout_mpll);
>> +err_clk2:
>> + =A0 =A0 clk_put(sclk);
>> +
>> + =A0 =A0 return -EINVAL;
>> +}
>> +
>
> I'm not sure if mach-smdk*.c is the right place for the above code.
> IMHO all the code that configures very low level, board specific paramete=
rs
> (like clocks and their relations) should be performed in boot loarder.
>

I feel pushing the clock enabling into the bootloader,will create an
unneccesary dependcy for the lcd on the u-boot.

> (snipped)
>
> Best regards
> --
> Marek Szyprowski
> Samsung Poland R&D Center
>
>
>
regards
anand
