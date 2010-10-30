From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 30 Oct 2010 11:50:32 +0000
Subject: Re: [PATCH/RFC 3/3 v2] ARM: mach-shmobile: implement parent clock optimization
Message-Id: <20101030115032.GA6955@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1010291436210.25084@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1010291436210.25084@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Oct 29, 2010 at 02:42:16PM +0200, Guennadi Liakhovetski wrote:
> This new function allows to select a parent frequency, which provides the 
> best matching child clock rate.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> Paul, something like this? I know, this is against an "old" kernel, only 
> compile tested so far, so, this is even more of an RFC than the previous 
> version, just to ask your opinion, if this is the direction you were 
> thinking about. Unfortunately, I don't think re-using 
> clk_rate_round_helper() would be wise here, but we can discuss that too. 
> 
Yes, that basically looks like what I had in mind. 

Re-using clk_rate_round_helper() probably won't help here since it's
doing sufficiently different things anyways.

If this ends up working for you then please test it and respin it against
a current kernel. This can go upstream pretty easily by itself.
