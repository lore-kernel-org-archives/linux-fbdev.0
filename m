From: Luca <kronos@people.it>
Subject: Re: sysfs question
Date: Tue, 25 Jul 2006 20:45:55 +0200
Message-ID: <20060725184554.GB1081@dreamland.darkstar.lan>
References: <E48BC47E-9E17-44F8-8CE7-471785C05B9C@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G6aKB-0006TX-2x for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Jul 2006 14:56:51 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1G6UO4-0007hJ-9e for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Jul 2006 08:36:28 -0700
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G5Ruz-0001LH-6U
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 25 Jul 2006 11:46:10 -0700
Received: from dreamland.darkstar.lan (84.222.20.226) by
	mail-relay-2.tiscali.it (7.3.110.2)
	id 44C4F3DD00027A11 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 25 Jul 2006 20:46:00 +0200
Content-Disposition: inline
In-Reply-To: <E48BC47E-9E17-44F8-8CE7-471785C05B9C@cecropia.com>
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

Il Mon, Jul 24, 2006 at 09:47:59AM -0400, Dennis Munsie ha scritto: 
> quick question regarding sysfs and the framebuffer... I can add my  
> own attributes without any problems, but they always show up with the  
> device (/sys/class/graphics/fb0/device), not the rest of the  
> framebuffer attributes (/sys/class/graphics/fb0). Is there a good  
> way to put them with the fb attributes?

You have to attach the new attributes to the class_device instead of the
device. See class_device_create_file().
I don't know if it's a good idea tough: if the attributes are specific
to only one device it sounds more logical to attach them to the device.

Luca
-- 
Home: http://kronoz.cjb.net
"L'ottimista pensa che questo sia il migliore dei mondi possibili. 
 Il pessimista sa che e` vero" -- J. Robert Oppenheimer

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
