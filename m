From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] [FBDEV]: accel_putcs() buffer overflow fix
Date: Mon, 6 Jan 2003 21:51:44 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0301062151140.31831-100000@phoenix.infradead.org>
References: <1041514436.1002.31.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1041514436.1002.31.camel@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel List <linux-kernel@vger.kernel.org>


> 1. If size of bitmap exceeds size of pixmap buffer, subdivide and do
> multiple imageblits.
> 
> 2. Use generic fb_pan_display() instead of info->fbops->fb_pan_display()
> in update_var()

Applied.
