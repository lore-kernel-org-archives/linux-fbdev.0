From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] Re: [FBDEV BK] Updates and fixes.
Date: Tue, 15 Apr 2003 20:25:25 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0304152022550.8236-100000@phoenix.infradead.org>
References: <1050310411.5574.44.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1050310411.5574.44.camel@zion.wanadoo.fr>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel mailing list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > ATI Technologies Inc Rage Mobility M3 AGP 2x (rev 02)
> 
> This is a r128 based chip, which lacks some of the proper support for
> LCD stuff (especially automatic retreival of the EDID from BIOS) that
> we have in radeonfb. If you feed the driver with a suitable mode, it
> should work

Oh. A Rage 128 chip with a LCD display. Then you are out of luck right 
now.

> I haven't yet checked which codebase is in there for rivafb, I have
> started collecting various patches around & doing my own fixes, I have
> a version here that works on PPC with GeForce2 & 4, though I still
> have problems with accel on the GeForce4. It's a 2.4 code base right
> now, I haven't had time to clean that up and release a patch though.
> 
> If 2.5 still has the old codebase, then GeForce4 isn't properly
> supported yet.

We it sort of is old but yet new. I did port alot of the code from 2.4.X. 
to the latest tree. I haven't ported "thee" latest patches tho.

> Note that if you have a flat panel, then the problem of properly
> retreiving the EDID to get a suitable default mode is also present
> there, unless James added some support for it.

It there but only for PPC platforms. Hopefully with the new fbmon.c code I 
will be able to have this work on ix86 very soon.
