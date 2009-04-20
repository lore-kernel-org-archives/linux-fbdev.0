From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] fbdev: fix fillrect for 24bpp modes
Date: Mon, 20 Apr 2009 16:07:33 -0700
Message-ID: <20090420160733.07e27238.akpm@linux-foundation.org>
References: <20090413170954.GA8403@tria>
	<20090417183617.ed7553cd.krzysztof.h1@poczta.fm>
	<20090417115048.0c5ca35d.akpm@linux-foundation.org>
	<20090418185234.GA17853@tria>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752900AbZDTXT5@vger.kernel.org>
In-Reply-To: <20090418185234.GA17853@tria>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: spock@gentoo.org
Cc: krzysztof.h1@poczta.fm, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sat, 18 Apr 2009 20:52:34 +0200
Michal Januszewski <spock@gentoo.org> wrote:

>  		while (height--) {
> -			dst += dst_idx >> (ffs(bits) - 1);
> +			dst += dst_idx / bits;
>  			dst_idx &= (bits - 1);
> -			fill_op(p, dst, dst_idx, pat, left, right,
> +			r = dst_idx % bpp;
> +			/* rotate pattern to the correct start position */
> +#ifdef __LITTLE_ENDIAN
> +			pat2 = pat << r | pat >> (bpp-r);
> +#else
> +			pat2 = pat << (bpp-r) | pat >> r;
> +#endif
> +			fill_op(p, dst, dst_idx, pat2, left, right,
>  				width*bpp, bits);
> -			r = (p->fix.line_length*8) % bpp;
> -			pat = pat << (bpp-r) | pat >> r;
>  			dst_idx += p->fix.line_length*8;

hm, that's fairly eye-popping.

Could we do something like

	pat2 = le32_to_cpu(rol32(cpu_to_le32(pat), r));

(might be wrong, but you see what I mean...)
