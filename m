From: Dennis Munsie <dmunsie@cecropia.com>
Subject: soliciting feedback/direction on DDC support
Date: Wed, 14 Jun 2006 17:04:46 -0400
Message-ID: <12A94EEB-565A-4220-81B0-6A43EA732A14@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FqcVA-0001Kb-PQ for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 14:02:12 -0700
Received: from mail7.sea5.speakeasy.net ([69.17.117.9])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FqcV9-0004hi-Du
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 14:02:12 -0700
Received: from lex098.cecropia.com (HELO [192.168.3.25])
	(dmunsie@cecropia.com@[63.138.212.98])
	(envelope-sender <dmunsie@cecropia.com>)
	by mail7.sea5.speakeasy.net (qmail-ldap-1.03) with RC4-SHA encrypted
	SMTP for <linux-fbdev-devel@lists.sourceforge.net>;
	14 Jun 2006 21:02:04 -0000
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

hi everyone,

now that I have the I2C bus support in the intelfb driver, I would  
like to use it for the reading the EDID block.  And actually, I've  
tested it and it works just fine.

but... the way it does it is basically the same as the aty driver.   
Which leads to an ugly mess of copy and pasting code from one driver  
to another.  Not ideal at all.

So, I was thinking of making it generic and sticking it in fbmon.c  
(or someplace similar).  But, to do it properly, I need to fiddle  
with fields in the i2c_algo_bit_data struct.  Ideally, I would want  
to make sure that the adapter that's passed in is using the i2c-algo- 
bit algorithm.  But, to do this would require exposing functionality  
from the i2c algorithm, which seems dirty.

Normally I wouldn't need to do this, but it looks like the aty code  
was accommodating older monitors that might not have implemented  
everything to spec.  And therefore, it looks like they took to do a  
little bit banging themselves.

I've managed to make the aty functionality generic to a point -- it  
doesn't fiddle the registers directly, but uses the routines defined  
for that purpose -- but not as generic as I would ideally like.

At this point, I'll probably still separate out the functionality,  
but I won't feel comfortable submitting it upstream until the issues  
of being safe and completely generic are resolved.

I really don't want this functionality to drop on the floor or be  
implemented directly (like the other drivers) in the intelfb driver,  
so any feedback would be greatly appreciated.  It might just be that  
I'm completely missing something here.

dennis
