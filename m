From: Valentin Longchamp <valentin.longchamp@epfl.ch>
Subject: Re: [PATCH 2/4 v8] i.MX31: Image Processing
	Unit DMA and IRQ drivers
Date: Thu, 22 Jan 2009 19:51:07 +0100
Message-ID: <4978C01B.8080707@epfl.ch>
References: <Pine.LNX.4.64.0901081850280.6387@axis700.grange>
	<Pine.LNX.4.64.0901081857170.6387@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <valentin.longchamp@epfl.ch>) id 1LQ4eX-0002x1-FC
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jan 2009 18:51:45 +0000
Received: from smtp3.epfl.ch ([128.178.224.226])
	by 72vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1LQ4eN-0005ts-QJ for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jan 2009 18:51:45 +0000
In-Reply-To: <Pine.LNX.4.64.0901081857170.6387@axis700.grange>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, Dan Williams <dan.j.williams@intel.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

Hi Guennadi,

I wanted to test this driver on my board. However it does not work for
me. I have pulled the version that is on async-tx tree so it should be
up to date and it compiles fine.

Unfortunately the fb driver cannot register because it cannot request a
dma channel (there are no dma registered in dmaengive, the list is
empty). This is because the ipu-core platform_driver is never
registered. This is supposed to be done thanks to the
subsys_initcall(ipu_init) as we can see it in the patch (which is then
going to be linked with the ipu-core device that is registered witth the
other mx3 device). I never happen to see one of the ipu_probe messages
(even for failure) with dynamic_printk enabled.

Here is the log of what happens for me when I load the mx3fb driver:

root@mx31moboard:~# insmod mx3fb.ko
kobject:kobject: 'mx3fb' (bf00cf68): kobject_add_internal: parent:
'module', set: 'module'
kobject:kobject: 'holders' (c78fcda0): kobject_add_internal: parent:
'mx3fb', set: '<NULL>'
kobject_uevent:kobject: 'mx3fb' (bf00cf68): kobject_uevent_env
kobject:kobject: 'mx3fb' (bf00cf68): fill_kobj_path: path = '/module/mx3fb'
kobject:kobject: 'notes' (c78fcd20): kobject_add_internal: parent:
'mx3fb', set: '<NULL>'
bus:bus: 'platform': add driver mx3_sdc_fb
kobject:kobject: 'mx3_sdc_fb' (c78fd960): kobject_add_internal: parent:
'drivers', set: 'drivers'
dd:bus: 'platform': driver_probe_device: matched device mx3_sdc_fb with
driver mx3_sdc_fb
dd:bus: 'platform': really_probe: probing driver mx3_sdc_fb with device
mx3_sdc_fb
mx3fb:Remapped 53fc00b4 to 53fc01bf at c88980b4
dmaengine:__dma_request_channel: fail (<NULL>)
mx3_sdc_fb mx3_sdc_fb: mx3fb: failed to register fb
mx3_sdc_fb: probe of mx3_sdc_fb failed with error -16
kobject_uevent:kobject: 'mx3_sdc_fb' (c78fd960): kobject_uevent_env
kobject:kobject: 'mx3_sdc_fb' (c78fd960): fill_kobj_path: path =
'/bus/platform/drivers/mx3_sdc_fb'


Do you have any idea why this subsys_initcall is not called for me ? Do
I have to use a certain config or boot options ? What are these initcall
levels (subsys corresponding to level 4) ?

Thank you for your help.

Val

Guennadi Liakhovetski wrote:
> From: Guennadi Liakhovetski <lg@denx.de>
> 
> i.MX3x SoCs contain an Image Processing Unit, consisting of a Control
> Module (CM), Display Interface (DI), Synchronous Display Controller (SDC),
> Asynchronous Display Controller (ADC), Image Converter (IC), Post-Filter
> (PF), Camera Sensor Interface (CSI), and an Image DMA Controller (IDMAC).
> CM contains, among other blocks, an Interrupt Generator (IG) and a Clock
> and Reset Control Unit (CRCU). This driver serves IDMAC and IG. They are
> supported over dmaengine and irq-chip APIs respectively.
> 
> IDMAC is a specialised DMA controller, its DMA channels cannot be used for
> general-purpose operations, even though it might be possible to configure
> a memory-to-memory channel for memcpy operation. This driver will not work
> with generic dmaengine clients, clients, wishing to use it must use
> respective wrapper structures, they also must specify which channels they
> require, as channels are hard-wired to specific IPU functions.
> 
> Signed-off-by: Guennadi Liakhovetski <lg@denx.de>
> diff --git a/drivers/dma/ipu/ipu_idmac.c b/drivers/dma/ipu/ipu_idmac.c
> new file mode 100644
> index 0000000..1f154d0
> --- /dev/null
> +++ b/drivers/dma/ipu/ipu_idmac.c
[snip]
> +
> +/*****************************************************************************
> + * IPU common probe / remove
> + */
> +
> +static int ipu_probe(struct platform_device *pdev)
> +{
> +       struct ipu_platform_data *pdata = pdev->dev.platform_data;
> +       struct resource *mem_ipu, *mem_ic;
> +       int ret;
> +
> +       spin_lock_init(&ipu_data.lock);
> +
> +       mem_ipu = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       mem_ic  = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +       if (!pdata || !mem_ipu || !mem_ic)
> +               return -EINVAL;
> +
> +       ipu_data.dev = &pdev->dev;
> +
> +       platform_set_drvdata(pdev, &ipu_data);
> +
> +       ret = platform_get_irq(pdev, 0);
> +       if (ret < 0)
> +               goto err_noirq;
> +
> +       ipu_data.irq_fn = ret;
> +       ret = platform_get_irq(pdev, 1);
> +       if (ret < 0)
> +               goto err_noirq;
> +
> +       ipu_data.irq_err = ret;
> +       ipu_data.irq_base = pdata->irq_base;
> +
> +       dev_dbg(&pdev->dev, "fn irq %u, err irq %u, irq-base %u\n",
> +               ipu_data.irq_fn, ipu_data.irq_err, ipu_data.irq_base);
> +
> +       /* Remap IPU common registers */
> +       ipu_data.reg_ipu = ioremap(mem_ipu->start,
> +                                  mem_ipu->end - mem_ipu->start + 1);
> +       if (!ipu_data.reg_ipu) {
> +               ret = -ENOMEM;
> +               goto err_ioremap_ipu;
> +       }
> +
> +       /* Remap Image Converter and Image DMA Controller registers */
> +       ipu_data.reg_ic = ioremap(mem_ic->start,
> +                                 mem_ic->end - mem_ic->start + 1);
> +       if (!ipu_data.reg_ic) {
> +               ret = -ENOMEM;
> +               goto err_ioremap_ic;
> +       }
> +
> +       /* Get IPU clock */
> +       ipu_data.ipu_clk = clk_get(&pdev->dev, "ipu_clk");
> +       if (IS_ERR(ipu_data.ipu_clk)) {
> +               ret = PTR_ERR(ipu_data.ipu_clk);
> +               goto err_clk_get;
> +       }
> +
> +       /* Make sure IPU HSP clock is running */
> +       clk_enable(ipu_data.ipu_clk);
> +
> +       /* Disable all interrupts */
> +       idmac_write_ipureg(&ipu_data, 0, IPU_INT_CTRL_1);
> +       idmac_write_ipureg(&ipu_data, 0, IPU_INT_CTRL_2);
> +       idmac_write_ipureg(&ipu_data, 0, IPU_INT_CTRL_3);
> +       idmac_write_ipureg(&ipu_data, 0, IPU_INT_CTRL_4);
> +       idmac_write_ipureg(&ipu_data, 0, IPU_INT_CTRL_5);
> +
> +       dev_dbg(&pdev->dev, "%s @ 0x%08lx, fn irq %u, err irq %u\n", pdev->name,
> +               (unsigned long)mem_ipu->start, ipu_data.irq_fn, ipu_data.irq_err);
> +
> +       ret = ipu_irq_attach_irq(&ipu_data, pdev);
> +       if (ret < 0)
> +               goto err_attach_irq;
> +
> +       /* Initialize DMA engine */
> +       ret = ipu_idmac_init(&ipu_data);
> +       if (ret < 0)
> +               goto err_idmac_init;
> +
> +       tasklet_init(&ipu_data.tasklet, ipu_gc_tasklet, (unsigned long)&ipu_data);
> +
> +       ipu_data.dev = &pdev->dev;
> +
> +       dev_dbg(ipu_data.dev, "IPU initialized\n");
> +
> +       return 0;
> +
> +err_idmac_init:
> +err_attach_irq:
> +       ipu_irq_detach_irq(&ipu_data, pdev);
> +       clk_disable(ipu_data.ipu_clk);
> +       clk_put(ipu_data.ipu_clk);
> +err_clk_get:
> +       iounmap(ipu_data.reg_ic);
> +err_ioremap_ic:
> +       iounmap(ipu_data.reg_ipu);
> +err_ioremap_ipu:
> +err_noirq:
> +       dev_err(&pdev->dev, "Failed to probe IPU: %d\n", ret);
> +       return ret;
> +}
> +
> +static int ipu_remove(struct platform_device *pdev)
> +{
> +       struct ipu *ipu = platform_get_drvdata(pdev);
> +
> +       ipu_idmac_exit(ipu);
> +       ipu_irq_detach_irq(ipu, pdev);
> +       clk_disable(ipu->ipu_clk);
> +       clk_put(ipu->ipu_clk);
> +       iounmap(ipu->reg_ic);
> +       iounmap(ipu->reg_ipu);
> +       tasklet_kill(&ipu->tasklet);
> +       platform_set_drvdata(pdev, NULL);
> +
> +       return 0;
> +}
> +
> +/*
> + * We need two MEM resources - with IPU-common and Image Converter registers,
> + * including PF_CONF and IDMAC_* registers, and two IRQs - function and error
> + */
> +static struct platform_driver ipu_platform_driver = {
> +       .driver = {
> +               .name   = "ipu-core",
> +               .owner  = THIS_MODULE,
> +       },
> +       .remove         = ipu_remove,
> +};
> +
> +static int __init ipu_init(void)
> +{
> +       return platform_driver_probe(&ipu_platform_driver, ipu_probe);
> +}
> +subsys_initcall(ipu_init);
> +
> +MODULE_DESCRIPTION("IPU core driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Guennadi Liakhovetski <lg@denx.de>");
> +MODULE_ALIAS("platform:ipu-core");


-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp@epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEA3485, Station 9, CH-1015 Lausanne

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
