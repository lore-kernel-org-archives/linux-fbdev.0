From: Dennis Munsie <dmunsie@cecropia.com>
Subject: Re: soliciting feedback/direction on DDC support
Date: Wed, 14 Jun 2006 20:30:27 -0400
Message-ID: <41352250-4AB2-4628-B6A0-5B6EDFE32CD6@cecropia.com>
References: <12A94EEB-565A-4220-81B0-6A43EA732A14@cecropia.com>
	<44908352.9090704@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fqfkl-0001qJ-ED for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 17:30:31 -0700
Received: from mail5.sea5.speakeasy.net ([69.17.117.7])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fqfkl-0002lA-5l
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 17:30:31 -0700
Received: from pool-71-126-246-178.bstnma.fios.verizon.net (HELO
	[192.168.0.100]) (dmunsie@cecropia.com@[71.126.246.178])
	(envelope-sender <dmunsie@cecropia.com>)
	by mail5.sea5.speakeasy.net (qmail-ldap-1.03) with RC4-SHA encrypted
	SMTP for <linux-fbdev-devel@lists.sourceforge.net>;
	15 Jun 2006 00:30:30 -0000
In-Reply-To: <44908352.9090704@gmail.com>
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

well, the hacks don't seem specific to the driver -- more that they  
are there to deal with quirks in the monitors -- which is something  
that shouldn't be in the driver.  It could also be that these hacks  
are completely unnecessary -- but that is something that I'm not  
qualified to determine.

But, the problem is that to make it robust and generic, i need access  
to some internal data in the i2c bit algo.  I can call the  
appropriate functions that tie back into the drivers, but I can't be  
100% sure that the I2C adapter passed to me is a bit algo and not  
something else.  There is no ID field in the adapter struct (or any  
of the structs inside of that one) that allows me to verify that I  
have good data.

Now, playing devil's advocate, we could just say that since this  
routine should only be called by drivers in the fb subsystem, they  
should know what i2c algorithm they are using, and it can be up to  
the caller to insure that everything is OK... but, I really don't  
feel comfortable using that method.  I'll leave that one up for  
debate...

I'm going to go ahead and write up the less than ideal version and  
post it up here for comments.  At least it can be a starting point  
that can be improved upon :)

dennis

On Jun 14, 2006, at 5:44 PM, Antonino A. Daplas wrote:
> I don't see a problem making this generic.  For drivers such as  
> radeonfb,
> we can add addtional hooks such as
>
> fb_ddc_pre_read() - hack before probing
> fb_ddc_post_read() - hack after probing
> fb_ddc_stop_read() - hack after everything is done
>
> to accommodate the hacks.
