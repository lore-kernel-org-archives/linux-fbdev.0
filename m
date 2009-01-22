From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 2/4 v8] i.MX31: Image Processing
	Unit DMA and IRQ drivers
Date: Thu, 22 Jan 2009 21:27:51 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0901222122150.7935@axis700.grange>
References: <Pine.LNX.4.64.0901081850280.6387@axis700.grange>
	<Pine.LNX.4.64.0901081857170.6387@axis700.grange>
	<4978C01B.8080707@epfl.ch>
	<Pine.LNX.4.64.0901221959100.7935@axis700.grange>
	<4978CD75.70203@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <g.liakhovetski@gmx.de>) id 1LQ69m-0005nk-V8
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jan 2009 20:28:06 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by 29vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1LQ69d-0004dM-MN for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jan 2009 20:28:06 +0000
In-Reply-To: <4978CD75.70203@epfl.ch>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Valentin Longchamp <valentin.longchamp@epfl.ch>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, Dan Williams <dan.j.williams@intel.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

On Thu, 22 Jan 2009, Valentin Longchamp wrote:

> Guennadi Liakhovetski wrote:
> > On Thu, 22 Jan 2009, Valentin Longchamp wrote:
> > 
> > You need the patch 4/4 - platform bindings, which is not in that queue and
> > will only be merged in the next kernel version. You can so far pick it up
> > here:
> > 
> > http://marc.info/?l=linux-arm-kernel&m=123143901514438&w=2
> > 
> 
> I have the platform bindings, the ipu-core platform_device (from patch 4/4) is
> registered on my system. It's only the ipu-core platform_driver  (from patch
> 2/4) that is not registered and I don't understand why.

Ok, you didn't mention this in your previous mail. I don't think the 
platform-driver is not registered. Can you check whether the ipu_init() 
function gets called? Looks like the ipu platform device is not registered 
on your system. Look at patch 4/4. In your board code you do something 
like

+	mx3_register_fb(fb_modedb[0].name, fb_modedb, ARRAY_SIZE(fb_modedb));

in that function

+	if (!ipu_registered) {
+		int ret = platform_device_register(&mx3_ipu);

Do you have the ipu platform device under /sys/devices/platform/?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
