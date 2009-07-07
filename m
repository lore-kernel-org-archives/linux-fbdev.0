From: Kai Jiang <b18973@freescale.com>
Subject: Re: 
 [linux-fbdev-devel][PATCH]fb_pan_display:add x/yoffset check
Date: Tue, 07 Jul 2009 10:43:09 +0800
Message-ID: <4A52B63D.2050000@freescale.com>
References: <4A4839CB.8020801@freescale.com>
	<20090629103936.GJ9980@sci.fi>	<4A4985C0.2040800@freescale.com>
	<20090703153029.GK9980@sci.fi> <4A4E2DCE.1060706@gmx.de>
	<4A5168D3.3050502@freescale.com> <4A520662.1030504@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Kai.Jiang@freescale.com>) id 1MO0ee-0005Xo-Ul
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 07 Jul 2009 02:43:36 +0000
Received: from az33egw02.freescale.net ([192.88.158.103])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MO0eW-0002L8-Fn
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 07 Jul 2009 02:43:36 +0000
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n672h32b000256 for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 6 Jul 2009 19:43:07 -0700 (MST)
Received: from zmy16exf40.fsl.freescale.net (zmy16exf40.ap.freescale.net
	[10.211.3.4])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n672h0c0027848
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 6 Jul 2009 21:43:02 -0500 (CDT)
In-Reply-To: <4A520662.1030504@gmx.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

Florian Tobias Schandinat wrote:
> Kai Jiang schrieb:
>> Florian Tobias Schandinat wrote:
>>> That's true, but the problem lies in the current implementation 
>>> first adding the resolution, which results in small negative [0 to 
>>> -resolution] values (=large positives) being accepted as they 
>>> overflow during add and become small positive values.
>>> I'd recommend changing
>>>
>>> var->yoffset + yres > info->var.yres_virtual ||
>>> var->xoffset + info->var.xres > info->var.xres_virtual
>>>
>>> to
>>>
>>> var->yoffset > info->var.yres_virtual - yres ||
>>> var->xoffset > info->var.xres_virtual - info->var.xres
>>>
>> I am not sure why do we have these change. Could you give a detail 
>> description or an example?
> It starts with "-1" in an u32 being represented as "0xFFFFFFFF", which 
> would be caught by ">". The problem in the current code is it first 
> adds the resolution before comparison and this causes an overflow.
> Let's say the virtual resolution matches the real resolution:
> yoffset + yres > yres
> There the left side is evaluated at first:
> (yoffset + yres)
> You accept everything that is <=yres. In classical mathematics you 
> would say yoffset has to be 0, but unfortunately this codes accept 
> many more as it can overflow. You get
> yoffset = -1:    (yres-1) > yres
> offset = -yres:    0 > yres
> So as you noticed, the current code will not just accept 0 as yoffset, 
> but the whole range [-yres..0]. This can be fixed by moving the 
> calculation to the right side, where we have trusted values, that do 
> not cause an overflow.
Florian Tobias Schandinat,
Thank you for your quick detail reply.
While, I suppose when the patch is applied, it should avoid what you 
mentioned. Following is the code applied patch.
(And the x/yres and x/yres_virtual have fix value which are defined and 
checked in the driver.)

fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var)
{      ......
        int xoffset = var->xoffset;                 // here transfer 
x/yoffset to "int" type for comparison
        int yoffset = var->yoffset;
       ......
        if (err || !info->fbops->fb_pan_display ||
            var->yoffset + yres > info->var.yres_virtual ||        
            var->xoffset + info->var.xres > info->var.xres_virtual ||    
            xoffset < 0 || yoffset < 0)             // insure the 
x/yoffset is large than 0. I think this line can avoid what you concerned.
                return -EINVAL;
       ......
}

Do you think so? I am happy to know your comments.

Best Regards,

Kai Jiang




------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
