From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [Linux-fbdev-devel] [PATCH] fix endian problem in color_imageblit
Date: Mon, 23 Dec 2002 11:18:40 +0000
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20021223111840.A20948@flint.arm.linux.org.uk>
References: <20021221092744.A23531@flint.arm.linux.org.uk> <Pine.GSO.4.21.0212231004040.12134-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0212231004040.12134-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Mon, Dec 23, 2002 at 10:07:35AM +0100
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Antonino Daplas <adaplas@pol.net>, James Simmons <jsimmons@infradead.org>, Paul Mackerras <paulus@samba.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, Dec 23, 2002 at 10:07:35AM +0100, Geert Uytterhoeven wrote:
> Note that the size of the entries in the pseudo palette used to depend on the
> mode, i.e. u16 for bpp = 16, u32 for bpp = 24 or 32.

They used to.  However, reading the code in 2.5 today, this appears to be
no longer the case - they're all one size (u32).

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
