From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 3/3] drivers/video: Correct use of
	request_region/request_mem_region
Date: Mon, 12 Oct 2009 02:29:07 +0200
Message-ID: <20091012002907.GA835@linux-mips.org>
References: <Pine.LNX.4.64.0908090943560.13271@ask.diku.dk> <10f740e80908090224p13d2119do9e4f4d7730ed001e@mail.gmail.com> <Pine.LNX.4.64.0908091141150.13271@ask.diku.dk>
Mime-Version: 1.0
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0908091141150.13271@ask.diku.dk>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <julia@diku.dk>
Cc: Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-mips@linux-mips.org

On Sun, Aug 09, 2009 at 11:42:32AM +0200, Julia Lawall wrote:

> From: Julia Lawall <julia@diku.dk>
> 
> request_region should be used with release_region, not request_mem_region.
> 
> Geert Uytterhoeven pointed out that in the case of drivers/video/gbefb.c,
> the problem is actually the other way around; request_mem_region should be
> used instead of request_region.
> 
> The semantic patch that finds/fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @r1@
> expression start;
> @@
> 
> request_region(start,...)
> 
> @b1@
> expression r1.start;
> @@
> 
> request_mem_region(start,...)
> 
> @depends on !b1@
> expression r1.start;
> expression E;
> @@
> 
> - release_mem_region
> + release_region
>   (start,E)
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>

Any reason this still hasn't been applied?

  Ralf
