From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Tridentfb updates?
Date: 25 Nov 2002 00:51:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1038185518.28491.24.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0211221146240.30881-100000@blessed.joshisanerd.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211221146240.30881-100000@blessed.joshisanerd.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Josh Myer <jbm@joshisanerd.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, 2002-11-22 at 17:49, Josh Myer wrote:
> Hi,
> 
> I've got an EPIA board, with a trident CyberBlade chipset. Does anyone
> have doco on this chipset? The random Xfree stuff available from VIA is
> less-than-enlightening (I'm not familiar with X internals).
> 
> I'm basically just interested in getting FB working for NTSC output.

The chipset docs are freely downloadable from VIA (including the 3d
info). The TV on the epia is a seperate chip. I use the vesa mode switch
to program that
