From: "David S. Miller" <davem@redhat.com>
Subject: Re: [Linux-fbdev-devel] Type confusion in fbcon
Date: 23 Dec 2002 13:11:43 -0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1040677903.21606.0.camel@rth.ninka.net>
References: <Pine.GSO.4.21.0212231014460.12134-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0212231014460.12134-100000@vervain.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Russell King <rmk@arm.linux.org.uk>, James Simmons <jsimmons@infradead.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2002-12-23 at 01:18, Geert Uytterhoeven wrote:
> That's because originally there was no fix.line_length field, and the line
> length was derived from var.xres_virtual and var.bits_per_pixel.
> 
> With some hardware, the line length must be a multiple of 32 or 64 bits, and we
> needed a way to specify that, so fix.line_length was introduced. If it was
> zero, user code should fallback to the old behavior.

And with some cards, the line length is constant.  Ie. to get to
"X, Y + 1" for a given "X, Y" you add a constant to your current
frame buffer pointer.

That is what fix.line_length is for right?
