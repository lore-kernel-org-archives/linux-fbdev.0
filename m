From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 06/16] viafb: complete support for VX800/VX855
 accelerated framebuffer
Date: Fri, 9 Apr 2010 14:18:34 -0600
Message-ID: <20100409141834.4e45f18d@bike.lwn.net>
References: <1270746946-12467-1-git-send-email-corbet@lwn.net>
	<1270746946-12467-7-git-send-email-corbet@lwn.net>
	<4BBEAB3E.5090709@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4BBEAB3E.5090709@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev-devel@lists.sourceforge.net

On Fri, 09 Apr 2010 06:21:18 +0200
Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:

> > +	for (i = 0; i <= highest_reg; i+= 4)
> > +		writel(0x0, engine + i);
> > +
> 
> this obsoletes
> 	/* Init 2D engine reg to reset 2D engine */
> 	writel(0x0, engine + VIA_REG_KEYCONTROL);
> as VIA_REG_KEYCONTROL is 0x02C.

Ah, good point, the separate write is superfluous.  Removed.


[...]
> > +#define VIA_REG_MONOPATBGC_M1   0x05C       /* Add FG color of Pattern. */
> > +#define VIA_REG_COLORPAT_M1     0x100       /* from 0x100 to 0x1ff */
> > +
> 
> All of these defines are unused. I admit that it is my fault. I've not 
> yet found a way I like to use them as the meaning of the same hardware 
> address changed. I think the most clean long term solution would be to 
> put the engines in separate files and the definitions in private headers 
> to at least avoid the need to decode the engine version in the name.
> However as the old headers already contain a bunch of trash feel free to 
> ignore this issue and add it for now.

Harald's initial patch included a mechanism for remapping register writes
on the fly depending on which engine was in use; these defines were used
for that purpose.  Your reworking of the 2D code obliterated that patch,
and made it mostly unnecessary.  I kept the defines around, though, because
I thought that documenting the registers can only be a good thing.

Thanks,

jon
