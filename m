From: Jan Altenberg <jan.altenberg@linutronix.de>
Subject: Re: [Linux-fbdev-devel] [PATCH] atmel_lcdfb: AT91/AT32 LCD
	Controller framebuffer driver
Date: Fri, 18 May 2007 20:05:31 +0200
Message-ID: <1179511541.3811.16.camel@bender>
References: <463F3388.7020102@rfo.atmel.com>
	 <1178574017.4674.30.camel@daplas>  <4641E1E2.6040808@rfo.atmel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761229AbXERSGG@vger.kernel.org>
In-Reply-To: <4641E1E2.6040808@rfo.atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Nicolas Ferre <nicolas.ferre@rfo.atmel.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>, Andrew Victor <andrew@sanpeople.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Patrice Vilchez <patrice.vilchez@rfo.atmel.com>

Hi Nicolas,

> +	info->fix.line_length = info->var.xres_virtual * (info->var.bits_per_pixel / 8);

line_length will always be 0 for bits_per_pixel < 8.

	Jan
