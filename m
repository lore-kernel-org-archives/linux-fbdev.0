From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 1/3: FBDEV: VGA State Save/Restore module
Date: Thu, 5 Dec 2002 17:39:11 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0212051738280.31967-100000@phoenix.infradead.org>
References: <96665BC46B2@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <96665BC46B2@vcnet.vc.cvut.cz>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Look at vgacon. Uses font block 0,2,3 from plane 2 when built
> without BROKEN_GRAPHICS_PROGRAMS, or 0,1 when built with 
> BROKEN_GRAPHICS_PROGRAMS. So if you want just restore vgacon environment,
> save only these 4 blocks (4*8K = 32K). Or you want to save whole
> VGA memory, and then save whole 256KB, without tricks while saving
> planes 0 & 1.

If you could get ride of the dependance on BROKEN_GRAPHICS_PROGRAM I would 
be really happy.
