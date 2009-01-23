From: Holger Schurig <hs4233@mail.mn-solutions.de>
Subject: Re: [PATCH 2/4 v8] i.MX31: Image Processing Unit DMA and IRQ drivers
Date: Fri, 23 Jan 2009 14:54:54 +0100
Message-ID: <200901231454.54179.hs4233@mail.mn-solutions.de>
References: <4978C01B.8080707@epfl.ch>
	<20090123131804.GI26184@n2100.arm.linux.org.uk>
	<4979C472.10707@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <4979C472.10707@epfl.ch>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Valentin Longchamp <valentin.longchamp@epfl.ch>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sascha Hauer <s.hauer@pengutronix.de>, Dan Williams <dan.j.williams@intel.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

> OK this may be a problem: I use the toolchain that is built by
> OpeneEmbedded.

OpenEmbedded can built a lot of toolchains. I for example also
use an OpenEmbedded toolchain, with binutils 2.19 and gcc 4.2.4.
I don't have the problems you describe.

$ arm-linux-uclibcgnueabi-objdump --version
GNU objdump (GNU Binutils) 2.19
$ arm-linux-uclibcgnueabi-gcc --version
arm-linux-uclibcgnueabi-gcc (GCC) 4.2.4

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
