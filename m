From: Luca <kronos@people.it>
Subject: Re: soliciting feedback/direction on DDC support
Date: Sat, 17 Jun 2006 19:29:21 +0200
Message-ID: <20060617172921.GA6281@dreamland.darkstar.lan>
References: <12A94EEB-565A-4220-81B0-6A43EA732A14@cecropia.com>
	<44908352.9090704@gmail.com>
	<41352250-4AB2-4628-B6A0-5B6EDFE32CD6@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FrebJ-00026m-Pd for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 17 Jun 2006 10:28:49 -0700
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FrebI-0002LB-58
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 17 Jun 2006 10:28:49 -0700
Received: from dreamland.darkstar.lan (84.222.32.139) by
	mail-relay-3.tiscali.it (7.3.104)
	id 44910E1400051629 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 17 Jun 2006 19:28:38 +0200
Content-Disposition: inline
In-Reply-To: <41352250-4AB2-4628-B6A0-5B6EDFE32CD6@cecropia.com>
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

Il Wed, Jun 14, 2006 at 08:30:27PM -0400, Dennis Munsie ha scritto: 
> well, the hacks don't seem specific to the driver -- more that they  
> are there to deal with quirks in the monitors -- which is something  
> that shouldn't be in the driver.  It could also be that these hacks  
> are completely unnecessary -- but that is something that I'm not  
> qualified to determine.

Those hacks are needed to wake up the EEPROMs on some weird monitors.
When I did the initial coding of the I2C stuff I asked ATI and they
confirmed that that black magic was not stricly needed but a "nice to
have" to make sure that EDID could be read also from older monitors.

> But, the problem is that to make it robust and generic, i need access  
> to some internal data in the i2c bit algo.  I can call the  
> appropriate functions that tie back into the drivers, but I can't be  
> 100% sure that the I2C adapter passed to me is a bit algo and not  
> something else. There is no ID field in the adapter struct (or any  
> of the structs inside of that one) that allows me to verify that I  
> have good data.
> 
> Now, playing devil's advocate, we could just say that since this  
> routine should only be called by drivers in the fb subsystem, they  
> should know what i2c algorithm they are using, and it can be up to  
> the caller to insure that everything is OK... but, I really don't  
> feel comfortable using that method.  I'll leave that one up for  
> debate...

Well, this stuff will be used only from kernel drivers. So I'd say that
if a driver is passing down something which is not a bit banging adaptor
then that driver is buggy, it violating the API.
I mean, right now I can pass crap to tons of kernel functions and then
watch the kernel explode; it's not a library which will be used by
userspace applications :P

Luca
-- 
Home: http://kronoz.cjb.net
"Ci sono le balle, le megaballe e le statistiche".
 Mark Twain
