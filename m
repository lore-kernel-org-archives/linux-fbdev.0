From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
Subject: Re: fbdv/fbcon pending problems
Date: Mon, 23 Feb 2004 20:35:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040223203528.E433@Marvin.DL8BCU.ampr.org>
References: <1077497593.5960.28.camel@gaston>
Reply-To: dl8bcu@dl8bcu.de
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1077497593.5960.28.camel@gaston>; from benh@kernel.crashing.org on Mon, Feb 23, 2004 at 11:53:14AM +1100
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Mon, Feb 23, 2004 at 11:53:14AM +1100, Benjamin Herrenschmidt wrote:
>  - mach64 lockups on LT-G (I'll try on an LT-Pro soon) plus other
> mach64 bugs in the new version in the bk fbdev, I'll have a patch for
> some of the problems, but I didn't find a good explanation for the
> accel lockups yet

Question: Is fbdev supposed to work without BIOS? 

I have an ATI Technologies Inc 3D Rage Pro 215GP in an Alpha AXPpci33,
currently running with MILO as firmware/bootloader. 
For several reasons I want to change to the original SRM firmware. 
Unfortunately its intel_cpu/BIOS emulation locks up on the ATI BIOS. With
the BIOS disabled the SRM succeeds loading the kernel. fbdev seems to
initialize _something_, i.e. the monitor wakes up ans displays a stable
repeating pattern of vertical stripes. But it hangs the machine after
these lines on serial console:

fb0: ATY Mach64 frame buffer device on PCI
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).

Booting the same kernel image (2.6.[13]) with MILO (which has a different
cpu emulation that succeeds executing the BIOS) works fine with fbdev. 

Bye,
Thorsten

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Kiebitzstr. 14, 49324 Melle, Germany  |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
