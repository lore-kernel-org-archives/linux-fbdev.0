From: Marc Zyngier <maz@misterjones.org>
Subject: Re: [PATCH 1/2] pxa: introduce GPIOxx_LCD_* macros for easier pin
	configuration
Date: Thu, 11 Dec 2008 19:43:58 +0100
Message-ID: <20081211194358.44af1dc5@why>
References: <f17812d70812110104y4b3d9b40i2f1c5d22e97988db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <f17812d70812110104y4b3d9b40i2f1c5d22e97988db@mail.gmail.com>
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
To: Eric Miao <eric.y.miao@gmail.com>
Cc: ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>, linux-fbdev-devel@lists.sourceforge.net, Jaya Kumar <jayakumar.lkml@gmail.com>, Mike Rapoport <mike@compulab.co.il>, Richard
	Purdie <rpurdie@rpsys.net>, Ian Molton <spyro@f2s.com>, pHilipp Zabel <philipp.zabel@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Marek Vasut <marek.vasut@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Juergen Schindele <linux@schindele.name>

On Thu, 11 Dec 2008 17:04:22 +0800
"Eric Miao" <eric.y.miao@gmail.com> wrote:

> From ed2c9a22a9653880fad7e22333c7d6155c45c399 Mon Sep 17 00:00:00 2001
> From: Eric Miao <eric.miao@marvell.com>
> Date: Thu, 11 Dec 2008 13:34:54 +0800
> Subject: [PATCH] [ARM] pxa: introduce GPIOxx_LCD_* macros for easier
> pin configuration
> 
> For those peripherals with only one possible pin configuration,
> introduce handy macros of GPIOxx_*, it also avoids potential
> copy-and-paste errors.
> 
> Let's start from LCD for PXA25x/PXA27x, depending on the different
> mode used: passive (STN), active (TFT) and LCD with internal
> framebuffer (i.e. smart panel), and the actual number of pins used to
> connect to the LCD panel, the configurations slightly differ.
> 
> Also, let's fix the issue of LCD pin configurations are missed from
> some platforms (e.g. am200epd, cm-x270, e400)
> 
> NOTE: the 18bpp and smart panel are only available on PXA27x.
> 
> Signed-off-by: Eric Miao <eric.miao@marvell.com>

For the Viper part:

Acked-by: Marc Zyngier <maz@misterjones.org>

	M;
-- 
And if you don't know where you're going, any road will take you there.

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
