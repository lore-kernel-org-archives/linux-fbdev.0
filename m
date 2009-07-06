From: Kai Jiang <b18973@freescale.com>
Subject: Re: 
 [linux-fbdev-devel][PATCH]fb_pan_display:add x/yoffset check
Date: Mon, 06 Jul 2009 10:54:11 +0800
Message-ID: <4A516753.30506@freescale.com>
References: <4A4839CB.8020801@freescale.com> <20090629103936.GJ9980@sci.fi>
	<4A4985C0.2040800@freescale.com> <20090703153029.GK9980@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Kai.Jiang@freescale.com>) id 1MNeM6-0002NC-2m
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 06 Jul 2009 02:54:58 +0000
Received: from az33egw02.freescale.net ([192.88.158.103])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MNeM0-0000Wp-0S
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 06 Jul 2009 02:54:57 +0000
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n662sJOi028474 for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 5 Jul 2009 19:54:27 -0700 (MST)
Received: from zmy16exf40.fsl.freescale.net (zmy16exf40.ap.freescale.net
	[10.211.3.4])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n662sIFj001214
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 5 Jul 2009 21:54:18 -0500 (CDT)
In-Reply-To: <20090703153029.GK9980@sci.fi>
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

We can't suppose that all the user operating this x/yoffset will check 
it. If the user application transfer a negative x/yoffset into the fb 
driver, I suppose fb driver should do operation correctly. So here, I 
think checking x/yoffset to insure the virtual space not moving outside 
real screen is necessary.
> On Tue, Jun 30, 2009 at 11:25:52AM +0800, Kai Jiang wrote:
>   
>> xres,yres,xres_virtual,yres_virtual will be set in the display driver, they have actual value which match the screen(will not very huge).
>>
>> And here, these lines are not checking the overflowing, but checking whether the virtual space display is beyond the real screen.
>>
>> Take x boundary for example:(the screen x and virtual x relationship should be:)
>> xres+xoffset<xres_vritual && xoffset>0
>> This insure that, in the real screen, there are virtual picture display in the screen. When we move the virtual picture to the left, the xoffset will be smaller and smaller
>> to indicate the virtual picture is moving to the left. Finally, the xoffset will be zero when the screen left boundary and virtual picture left boundary overlap. When virtual display is still moving to the left, the xoffset will be negative. And what should be displayed in the gap between screen left boundary and virtual space left boundary?
>>     
>
> If you're storing negative values into xoffset/yoffset your application
> is buggy. Just fix it.
>
>   
>> So here we have to check the whether the x/yoffset is smaller than zero. If the offset is smaller than zero, in the driver, we should not move the virtual screen any more.
>>     
>
> Checking for overflow will catch you buggy application's negative
> values too.
>
>   


------------------------------------------------------------------------------
