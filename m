From: Dan Carpenter <error27@gmail.com>
Date: Mon, 15 Nov 2010 08:14:57 +0000
Subject: Re: [patch 2/2] fbcmap: integer overflow bug
Message-Id: <20101115081457.GC21614@bicker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101027093716.GD6062@bicker>
 <20101105134018.2c11f283.akpm@linux-foundation.org>
 <20101113100718.GB1795@bicker>
 <20101115044820.GA8489@linux-sh.org>
 <AANLkTin0T5FN6WhUj0csypR=j0UPRbeHN+HC3N9xnk7E@mail.gmail.com>
 <20101115072014.GB21614@bicker>
 <4CE0E8CA.9010704@bfs.de>
In-Reply-To: <4CE0E8CA.9010704@bfs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: walter harms <wharms@bfs.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Mon, Nov 15, 2010 at 09:01:14AM +0100, walter harms wrote:
> I do not see the rest of the code but it looks like
> cmap->len is size in int8_t. So the upper limit is something like
> INT_MAX/(sizeof(u16)*2). Perhaps we can call it a char ?
> is there ANY system that has a more than 256 colors in R|G|B ?
> 

Yeah.  There are.  I had a list of some but I've deleted it.

> <spying for struct fb_cmap_user  >
>  __u32 len;
>  __u16 __user *red;
> 
> So no need to check for <0.

I test size which is an int so that's why it's needed.

regards,
dan carpenter

