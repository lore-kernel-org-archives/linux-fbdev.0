From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 6/6] fbdev: c2p - Rename c2p to c2p_planar and correct
 indentation
Date: Mon, 22 Dec 2008 15:23:59 -0800
Message-ID: <20081222152359.1e9b2143.akpm@linux-foundation.org>
References: <20081221150059.844577615@mail.of.borg>
	<20081221150123.327017854@mail.of.borg>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20081221150123.327017854@mail.of.borg>
Sender: linux-m68k-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: schmitz@opal.biophys.uni-duesseldorf.de, linux-fbdev-devel@lists.sourceforge.net, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 21 Dec 2008 16:01:05 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> +    /*
> +     *  Store a full block of planar data after c2p conversion
> +     */
> +
> +static inline void store_planar(void *dst, u32 dst_inc, u32 bpp, u32 d[8])
> +{
> +	int i;
> +
> +	for (i = 0; i < bpp; i++, dst += dst_inc)
> +		*(u32 *)dst = d[perm_c2p_32x8[i]];
> +}
> +
> +
> +    /*
> +     *  Store a partial block of planar data after c2p conversion
> +     */
> +
> +static inline void store_planar_masked(void *dst, u32 dst_inc, u32 bpp,
> +				       u32 d[8], u32 mask)
> +{
> +	int i;
> +
> +	for (i = 0; i < bpp; i++, dst += dst_inc)
> +		*(u32 *)dst = comp(d[perm_c2p_32x8[i]], *(u32 *)dst, mask);
> +}

Why not just make the first arg of these (too large to be inlined)
functions have type u32*, then do away with the casts?

