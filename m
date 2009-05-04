From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] leo: use standard fields for framebuffer physical
 address and length
Date: Mon, 04 May 2009 14:09:55 -0700 (PDT)
Message-ID: <20090504.140955.221258678.davem@davemloft.net>
References: <20090504224156.058f65ea.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <20090504224156.058f65ea.krzysztof.h1@poczta.fm>
Sender: sparclinux-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: Text/Plain; charset="us-ascii"
To: krzysztof.h1@poczta.fm
Cc: sparclinux@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Mon, 4 May 2009 22:41:56 +0200

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Use standard fields fbinfo.fix.smem_start and fbinfo.fix.smem_len
> for physical address and length of framebuffer.
> 
> This also fixes output of the 'fbset -i' command - address and length 
> of the framebuffer are displayed correctly.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

My objections to the cg3 patch apply here as well.
