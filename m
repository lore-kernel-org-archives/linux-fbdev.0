From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 06 Jan 2011 06:45:17 +0000
Subject: Re: [PATCH] drivers/video/carminefb.c: improve error handling
Message-Id: <20110106064517.GD15340@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1101021527220.10933@ask.diku.dk>
In-Reply-To: <Pine.LNX.4.64.1101021527220.10933@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <julia@diku.dk>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Sun, Jan 02, 2011 at 03:27:42PM +0100, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> This code had an error handling goto to the wrong place, a misplaced
> release_mem_region, and a duplicated release_mem_region.
> 
> The semantic match that finds the double release_mem_region is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @r@
> expression e1,e2,e3;
> position p1,p2,p3;
> @@
> release_mem_region@p1(e1, e2)@p3;
> ... when != request_mem_region(e1,e2,e3)
> release_mem_region(e1, e2)@p2;
> 
> @@
> expression e <= r.e1,e3;
> expression r.e1,e2;
> position r.p1,r.p2,r.p3,p!=r.p1;
> @@
> *release_mem_region(e1, e2)@p3;
> ... when != e = e3
> *release_mem_region@p(e1, e2)@p2;// </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>
> 
Applied, thanks.
