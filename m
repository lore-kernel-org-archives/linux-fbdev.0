From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: [PATCH] geode updates.
Date: Wed, 17 Aug 2005 17:31:39 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0508171731170.18287@pentafluge.infradead.org>
References: <Pine.LNX.4.56.0508120103420.13219@pentafluge.infradead.org>
 <43032919.8090100@arcom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E5QpN-0001PZ-ON
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Aug 2005 09:31:45 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E5QpM-0001UE-GE
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Aug 2005 09:31:45 -0700
Received: from jsimmons (helo=localhost)
	by pentafluge.infradead.org with local-esmtp (Exim 4.52 #1 (Red Hat Linux))
	id 1E5QpH-0004mU-Bl
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Aug 2005 17:31:39 +0100
In-Reply-To: <43032919.8090100@arcom.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > Okay I see what you meant. So what I did was create two hardware devices. 
> > One a pci device for the Cyrix video so it will show up in the sysfs pci 
> > tree. A second platform device for the embedded geode GX processsor.
> 
> You'll hate me for this but I've changed my mind...  I think making it a
> single PCI driver is best because:
> 
> 1. PCI devices can be autodetected etc. but platform devices can't.
> 2. Having the platform and pci driver is extra complexity for no
> practical benefit.
> 3. The framebuffer memory is a pci resource in BAR0 of the cs5530 video
> device anyway.
> 
> Attached is a tested patch that does this (based on one of your previous
> patches).

I don't mind :-)  I will send it to Andrew right away.



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
