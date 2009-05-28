From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] [drivers] [fb] S3C-fb: PM fix
Date: Wed, 27 May 2009 23:33:25 -0700
Message-ID: <20090527233325.bb60a326.akpm@linux-foundation.org>
References: <E4D3F24EA6C9E54F817833EAE0D912AC0226526883@bssrvexch01.BS.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1M9ZCJ-0006Ks-Fa
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 May 2009 06:34:39 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M9ZCH-0003qE-I2
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 May 2009 06:34:39 +0000
In-Reply-To: <E4D3F24EA6C9E54F817833EAE0D912AC0226526883@bssrvexch01.BS.local>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "Antonino A. Daplas" <adaplas@gmail.com>

On Mon, 18 May 2009 08:05:46 +0200 Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> Restore correctly FrameBuffer registers state in resume function.
> 
> Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> --- 
> 
> diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
> index 5e9c630..d3a568e 100644
> --- a/drivers/video/s3c-fb.c
> +++ b/drivers/video/s3c-fb.c
> @@ -947,7 +947,8 @@ static int __devexit s3c_fb_remove(struct platform_device *pdev)
>  	int win;
>  
>  	for (win = 0; win <= S3C_FB_MAX_WIN; win++)
> -		s3c_fb_release_win(sfb, sfb->windows[win]);
> +		if (sfb->windows[win])
> +			s3c_fb_release_win(sfb, sfb->windows[win]);
>  
>  	iounmap(sfb->regs);
>  
> @@ -985,11 +986,20 @@ static int s3c_fb_suspend(struct platform_device *pdev, pm_message_t state)
>  static int s3c_fb_resume(struct platform_device *pdev)
>  {
>  	struct s3c_fb *sfb = platform_get_drvdata(pdev);
> +	struct s3c_fb_platdata *pd = sfb->pdata;
>  	struct s3c_fb_win *win;
>  	int win_no;
>  
>  	clk_enable(sfb->bus_clk);
>  
> +	/* setup registers */
> +	writel(pd->vidcon1, sfb->regs + VIDCON1);
> +
> +	/* zero all windows before we do anything */
> +	for (win_no = 0; win_no < S3C_FB_MAX_WIN; win_no++)
> +		s3c_fb_clear_win(sfb, win_no);
> +
> +	/* restore framebuffers */
>  	for (win_no = 0; win_no < S3C_FB_MAX_WIN; win_no++) {
>  		win = sfb->windows[win_no];
>  		if (!win)

What are the consequences of the bug whcih you fixed?  Device
inoperative after resume, I assume?  Does it affect all supported
hardware, or just some particualr device(s)?

See, this is the sort of information whcih shuld be in the changelog,
please, so I (and others) can make decisions about which kernel
version(s) the patch should be merged into.

I assume we want it in 2.6.30.

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
