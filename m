From: "Michal Januszewski" <michalj@gmail.com>
Subject: Re: [PATCH] fbdev: don't allow to set a video mode via vga= if FB doesn't support it
Date: Mon, 22 Sep 2008 22:34:14 +0200
Message-ID: <5d9b736f0809221334i773a500eu5ff61884729a4367@mail.gmail.com>
References: <20080921210219.GC21215@spock.one.pl>
	 <20080922214747.c8bc57eb.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754148AbYIVUe0@vger.kernel.org>
In-Reply-To: <20080922214747.c8bc57eb.krzysztof.h1@poczta.fm>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Mon, Sep 22, 2008 at 21:47, Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> This one could be simpler:
>
>                /* It's a supported text mode */
>                is_graphic = 0;
>  +#if FB_SUPPORTS_BOOT_VESA
>        } else if ((vminfo.mode_attr & 0x99) == 0x99) {
>                /* It's a graphics mode with linear frame buffer */
>                is_graphic = 1;
>                vesa_mode |= 0x4000; /* Request linear frame buffer */
>  +#endif
>        } else {
>                return -1;      /* Invalid mode */
>        }

Agreed.

I'll wait at least one more day for any additional comments and repost
a fixed version.

Thanks for doing the code review.
-- 
Michal Januszewski, Gentoo Linux Developer
http://people.gentoo.org/spock
