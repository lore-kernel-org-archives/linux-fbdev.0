From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: [PATCH 1/3: FBDEV: VGA State Save/Restore module
Date: Thu, 5 Dec 2002 03:41:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20021205024157.GA19706@vana>
References: <96665BC46B2@vcnet.vc.cvut.cz> <1039056748.1032.22.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1039056748.1032.22.camel@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Dec 05, 2002 at 07:53:16AM +0500, Antonino Daplas wrote:
> On Thu, 2002-12-05 at 03:33, Petr Vandrovec wrote:
> > On  5 Dec 02 at 6:05, Antonino Daplas wrote:
> > planes 0 & 1.
> 
> Okay, then.  My approach was to be non-vgacon specific.  I'll do it to
> specifically target vgacon then.
> 
> To summarize:
> plane 0/1 save 8K at offset 0 and 8K at offset 16K;

I'm not sure about this one. AFAIK by default vgacon uses first 32KB
completely (every second byte...) from both 0/1, and can be configured
(by enabling VGA_CAN_DO_64KB) to use full 64KB.

> plane 2   save 32K at offset 0 (covers blocks 0-3),
> plane 3   same for plane 2
> 
> Drivers can set VGA_SAVE_TEXT | VGA_SAVE_FONT0 to save planes 0-2.  If
> there are no complaints, I'll  proceed doing it this way.

I have no other problems.
						Petr Vandrovec
						vandrove@vc.cvut.cz
