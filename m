From: Ben Dooks <ben@simtec.co.uk>
Subject: Re: s3c2410fb: fix clockrate calculation
Date: Thu, 27 Aug 2009 10:57:24 +0100
Message-ID: <4A965884.4030802@simtec.co.uk>
References: <20090820215047.717581584@fluff.org.uk>
	<20090820151944.9c29607c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ben@simtec.co.uk>) id 1Mgbjy-0005a8-OV
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Aug 2009 09:57:58 +0000
Received: from aeryn.fluff.org.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mgbju-0005ZJ-4g
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Aug 2009 09:57:58 +0000
In-Reply-To: <20090820151944.9c29607c.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Andrew Morton wrote:
> On Thu, 20 Aug 2009 22:50:47 +0100
> Ben Dooks <ben@simtec.co.uk> wrote:
> 
>> In the final part of the calculation for the tft display clockrate we
>> divide the output pf s3c2410fb_calc_pixclk() by 2 which leaves us with
>> a rounding error if the result is odd.
>>
>> Change to using DIV_ROUND_UP() to ensure that we always choose a higher
>> divisor and thus a lower frequency.
>>
>> Signed-off-by: Ben Dooks <ben@simtec.co.uk>
>>
>> ---
>>  drivers/video/s3c2410fb.c |    4 +++-
>>  2 files changed, 5 insertions(+), 2 deletions(-)
>>  
>> Index: b/drivers/video/s3c2410fb.c
>> ===================================================================
>> --- a/drivers/video/s3c2410fb.c	2009-08-20 08:45:41.000000000 +0100
>> +++ b/drivers/video/s3c2410fb.c	2009-08-20 08:45:42.000000000 +0100
>> @@ -369,7 +369,9 @@ static void s3c2410fb_activate_var(struc
>>  	void __iomem *regs = fbi->io;
>>  	int type = fbi->regs.lcdcon1 & S3C2410_LCDCON1_TFT;
>>  	struct fb_var_screeninfo *var = &info->var;
>> -	int clkdiv = s3c2410fb_calc_pixclk(fbi, var->pixclock) / 2;
>> +	int clkdiv;
>> +
>> +	clkdiv = DIV_ROUND_UP(s3c2410fb_calc_pixclk(fbi, var->pixclock), 2);
>>  
>>  	printk(KERN_INFO "%s: pixclock=%d, clkdiv=%d\n",
>>  	       __func__, var->pixclock, clkdiv);
> 
> The changelog forgot to tell us what the impact of this bug is, so I
> cannot work out whether we need this fix in 2.6.32, 2.6.31, 2.6.30.x, ....

Sorry, found this whilst working on a new machine and the pix clock being
too fast for the display. The machine is not yet merged into the mainline
so this not an important fix.

-- 
Ben Dooks, Software Engineer, Simtec Electronics

http://www.simtec.co.uk/

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
