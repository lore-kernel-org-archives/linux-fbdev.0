From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [Linux-fbdev-devel] Re: [BK PATCHS] fbdev updates.
Date: Fri, 18 Oct 2002 22:37:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20021018223708.C15827@flint.arm.linux.org.uk>
References: <20021018193245.A15827@flint.arm.linux.org.uk> <Pine.LNX.4.33.0210181421110.3591-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0210181421110.3591-100000@maxwell.earthlink.net>; from jsimmons@infradead.org on Fri, Oct 18, 2002 at 02:24:48PM -0700
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Oct 18, 2002 at 02:24:48PM -0700, James Simmons wrote:
> Your right. That is a bug from the old fbgen code. Since few driver used
> the old fbgen code it never appeared. I suggest we remove can_soft_blank
> and just test to see if the function pointer exist for fb_blank. If it
> doesn't then we can resort to other tricks in suggested in the ther email.

Ok.  What about the case where you're running in true colour / static
pseudo colour, and can't blank the palette, but do have a fb_blank
method to handle the direct colour / pseudo colour case?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
