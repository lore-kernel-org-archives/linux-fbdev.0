From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] FBDev: vga16fb port
Date: Mon, 2 Dec 2002 20:31:23 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0212022027510.18805-100000@phoenix.infradead.org>
References: <1038468176.1091.46.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1038468176.1091.46.camel@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> Attached is a patch against 2.5.49 + James Simmons' latest fbdev.diff.
> 
> Added support for logo drawing.
> Fixed vga16fb_imageblit() limitation of 8-pixel wide bitmap blitting
> only.

Applied and tested :-=) The only weird thing is it drew the logo twice 
when I don't have a SMP laptop. It works other than that. 

P.S
  Things I like to get done for the vga16fb driver. 

  1) Its own read and write functions to fake a linear framebuffer.
  2) The ability to go back to vga text mode on close of /dev/fb. 
     Yes fbdev/fbcon supports that now. 
 
