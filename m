From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: soliciting feedback/direction on DDC support
Date: Thu, 15 Jun 2006 05:44:50 +0800
Message-ID: <44908352.9090704@gmail.com>
References: <12A94EEB-565A-4220-81B0-6A43EA732A14@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FqdAZ-0004yg-42 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 14:44:59 -0700
Received: from wr-out-0506.google.com ([64.233.184.231])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FqdAY-0004xX-Of
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 14:44:59 -0700
Received: by wr-out-0506.google.com with SMTP id i24so243460wra
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 14 Jun 2006 14:44:57 -0700 (PDT)
In-Reply-To: <12A94EEB-565A-4220-81B0-6A43EA732A14@cecropia.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Dennis Munsie <dmunsie@cecropia.com>

Dennis Munsie wrote:
> hi everyone,
> 
> now that I have the I2C bus support in the intelfb driver, I would  
> like to use it for the reading the EDID block.  And actually, I've  
> tested it and it works just fine.
> 
> but... the way it does it is basically the same as the aty driver.   
> Which leads to an ugly mess of copy and pasting code from one driver  
> to another.  Not ideal at all.
> 
> So, I was thinking of making it generic and sticking it in fbmon.c  
> (or someplace similar).  But, to do it properly, I need to fiddle  
> with fields in the i2c_algo_bit_data struct.  Ideally, I would want  
> to make sure that the adapter that's passed in is using the i2c-algo- 
> bit algorithm.  But, to do this would require exposing functionality  
> from the i2c algorithm, which seems dirty.
> 
> Normally I wouldn't need to do this, but it looks like the aty code  
> was accommodating older monitors that might not have implemented  
> everything to spec.  And therefore, it looks like they took to do a  
> little bit banging themselves.
> 
> I've managed to make the aty functionality generic to a point -- it  
> doesn't fiddle the registers directly, but uses the routines defined  
> for that purpose -- but not as generic as I would ideally like.
> 
> At this point, I'll probably still separate out the functionality,  
> but I won't feel comfortable submitting it upstream until the issues  
> of being safe and completely generic are resolved.
> 
> I really don't want this functionality to drop on the floor or be  
> implemented directly (like the other drivers) in the intelfb driver,  
> so any feedback would be greatly appreciated.  It might just be that  
> I'm completely missing something here.

I don't see a problem making this generic.  For drivers such as radeonfb,
we can add addtional hooks such as

fb_ddc_pre_read() - hack before probing
fb_ddc_post_read() - hack after probing
fb_ddc_stop_read() - hack after everything is done

to accommodate the hacks.

Tony
