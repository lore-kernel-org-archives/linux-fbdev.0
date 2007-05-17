From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 10/10] [HEADS UP] fbdev: Move arch-specific bits to their respective subdirectories
Date: Thu, 17 May 2007 10:49:30 +0100
Message-ID: <20070517094930.GA27627@infradead.org>
References: <464B78BC.4080900@gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756056AbXEQJtv@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <464B78BC.4080900@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Thu, May 17, 2007 at 05:33:48AM +0800, Antonino A. Daplas wrote:
> -#if defined(__sparc__) && !defined(__sparc_v9__)
> -	/* Should never get here, all fb drivers should have their own
> -	   mmap routines */
> -	return -EINVAL;
> -#else
> -	/* !sparc32... */
> +	if (fb_mmap_required())
> +		return -EINVAL;
> +

I don't like this bit.  It's just that all sparc frame buffers happen
to have a mmap method but there's nothing fundamentally arch specific
here.  You should be able to plug a pci video card into any linux
supported machine provided the fb driver does the full setup (which
only very few do in practice, but..)

So I'd just require drivers to have a fb_mmap method and make fb_mmap
the default one.  The page protection cleanup is still nice of course,
but it might make sense to give it a more generic name as it's not
really fb specific.
