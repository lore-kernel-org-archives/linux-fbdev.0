From: Kai Jiang <b18973@freescale.com>
Subject: Re: 
 [linux-fbdev-devel][PATCH]fb_pan_display:add x/yoffset check
Date: Tue, 30 Jun 2009 11:25:52 +0800
Message-ID: <4A4985C0.2040800@freescale.com>
References: <4A4839CB.8020801@freescale.com> <20090629103936.GJ9980@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Kai.Jiang@freescale.com>) id 1MLTvN-0006ao-NE
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jun 2009 03:22:25 +0000
Received: from az33egw02.freescale.net ([192.88.158.103])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLTvM-0007Mb-Bn for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jun 2009 03:22:25 +0000
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n5U3LpIm024556 for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 29 Jun 2009 20:21:59 -0700 (MST)
Received: from zmy16exf40.fsl.freescale.net (zmy16exf40.ap.freescale.net
	[10.211.3.4])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n5U3Ln2X025488
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 29 Jun 2009 22:21:50 -0500 (CDT)
In-Reply-To: <20090629103936.GJ9980@sci.fi>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: linux-fbdev-devel@lists.sourceforge.net


xres,yres,xres_virtual,yres_virtual will be set in the display driver, they have actual value which match the screen(will not very huge).

And here, these lines are not checking the overflowing, but checking whether the virtual space display is beyond the real screen.

Take x boundary for example:(the screen x and virtual x relationship should be:)
xres+xoffset<xres_vritual && xoffset>0
This insure that, in the real screen, there are virtual picture display in the screen. When we move the virtual picture to the left, the xoffset will be smaller and smaller
to indicate the virtual picture is moving to the left. Finally, the xoffset will be zero when the screen left boundary and virtual picture left boundary overlap. When virtual display is still moving to the left, the xoffset will be negative. And what should be displayed in the gap between screen left boundary and virtual space left boundary?

So here we have to check the whether the x/yoffset is smaller than zero. If the offset is smaller than zero, in the driver, we should not move the virtual screen any more.


Best Regards,

Kai Jiang
 
 


> On Mon, Jun 29, 2009 at 11:49:31AM +0800, Kai Jiang wrote:
>   
>
>   
>> >From a01ede69772634b30a83b44eada5a8db66f8463a Mon Sep 17 00:00:00 2001
>> From: Kai Jiang <Kai.Jiang@freescale.com>
>> Date: Mon, 29 Jun 2009 11:25:58 +0800
>> Subject: [PATCH] When moving virtual space straight to one side in the screen(ex.
>>  straight to the left),finally the virtual space will move outside
>>  of the real screen. Then the xoffset or yoffset will be nagative
>>  value(transfered from user application) to indicate that the virtual
>>  space is beyond the screen boundary. In the function fb_pan_disaplay,
>>  xoffset and yoffset should be checked to ensure that, when they are
>>  negative, the virtual space will not move any more,and the function
>>  will return an error. However, xoffset and yoffset in the structure
>>  fb_var_screeninfo are "__u32" type, here need to transfer them to
>>  "int" type for comparing.
>>
>> Signed-off-by: Kai Jiang <Kai.Jiang@freescale.com>
>> ---
>>  drivers/video/fbmem.c |    5 ++++-
>>  1 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
>> index d412a1d..27628de 100644
>> --- a/drivers/video/fbmem.c
>> +++ b/drivers/video/fbmem.c
>> @@ -855,6 +855,8 @@ fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var)
>>  {
>>  	struct fb_fix_screeninfo *fix = &info->fix;
>>  	unsigned int yres = info->var.yres;
>> +	int xoffset = var->xoffset;
>> +	int yoffset = var->yoffset;
>>  	int err = 0;
>>  
>>  	if (var->yoffset > 0) {
>> @@ -873,7 +875,8 @@ fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var)
>>  
>>  	if (err || !info->fbops->fb_pan_display ||
>>  	    var->yoffset + yres > info->var.yres_virtual ||
>> -	    var->xoffset + info->var.xres > info->var.xres_virtual)
>> +	    var->xoffset + info->var.xres > info->var.xres_virtual ||
>> +	    xoffset < 0 || yoffset < 0)
>>     
>
> Well negative xoffset/yoffset don't really exist so what you're
> essentially checking is whether offset+res overflows. Your check will
> not catch all overflows though. xres/yres would have to be huge
> (> 2^31) to cause such overflows though so your check should catch all
> cases that can happen in practice. However I think it would be better
> to make the overflow check clearer (eg. 'offset + res < res').
>
>   


------------------------------------------------------------------------------
