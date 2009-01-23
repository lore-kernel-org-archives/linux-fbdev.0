From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/4 v8] i.MX31: Image Processing Unit DMA and IRQ drivers
Date: Fri, 23 Jan 2009 13:26:10 +0000
Message-ID: <20090123132610.GK26184@n2100.arm.linux.org.uk>
References: <4978CD75.70203@epfl.ch>
	<Pine.LNX.4.64.0901222122150.7935@axis700.grange>
	<49798E4A.4030709@epfl.ch>
	<Pine.LNX.4.64.0901231040420.4463@axis700.grange>
	<4979A88A.5010102@epfl.ch>
	<Pine.LNX.4.64.0901231308040.4463@axis700.grange>
	<4979BFC1.1070504@epfl.ch>
	<Pine.LNX.4.64.0901231407030.6497@axis700.grange>
	<20090123131804.GI26184@n2100.arm.linux.org.uk>
	<Pine.LNX.4.64.0901231421400.6497@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0901231421400.6497@axis700.grange>
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
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Valentin Longchamp <valentin.longchamp@epfl.ch>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Dan Williams <dan.j.williams@intel.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

On Fri, Jan 23, 2009 at 02:22:33PM +0100, Guennadi Liakhovetski wrote:
> On Fri, 23 Jan 2009, Russell King - ARM Linux wrote:
> > I've personally never seen a situation where only some initcalls are
> > called, but then I tend to hang on to known reliable toolchains.
> 
> The easiest for him is probably just put a printk in the loop in 
> do_initcalls(), printing out function addresses.

Even easier is to pass "initcall_debug=1" to the kernel.

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
