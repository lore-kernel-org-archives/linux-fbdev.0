From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: OLS and console rearchitecture
Date: Fri, 30 Jul 2004 16:31:09 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040730233109.36838.qmail@web14928.mail.yahoo.com>
References: <20040730221956.GA9140@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BqgqF-0003j8-LB
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Jul 2004 16:31:11 -0700
Received: from web14928.mail.yahoo.com ([216.136.225.87])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1BqgqD-0003qM-Nm
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Jul 2004 16:31:10 -0700
In-Reply-To: <20040730221956.GA9140@dreamland.darkstar.lan>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kronos <kronos@people.it>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

There is a big thread about this on lkml currently.

--- Kronos <kronos@people.it> wrote:

> Il Wed, Jul 28, 2004 at 11:57:59PM +0100, Alan Cox ha scritto: 
> > 
> > > > 7) Mode setting from normal user space - devices will have a
> standard
> > > > IOCTL accepting a mode string like fbdev currently uses.
> > > 
> > > sysfs? I sent a patch a while ago but didn't get much feedback.
> > 
> > How do you atomically tie sysfs objects to fbdev and X permissions
> > models?
> 
> It's not atomic right now, the attribute is attached to a
> class_device
> object after register_framebuffer (which init & register the
> class_device). Is this a problem?
> 
> Luca
> -- 
> Home: http://kronoz.cjb.net
> Windows NT crashed.
> I'm the Blue Screen of Death.
> No one hears your screams.
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by OSTG. Have you noticed the changes
> on
> Linux.com, ITManagersJournal and NewsForge in the past few weeks?
> Now,
> one more big change to announce. We are now OSTG- Open Source
> Technology
> Group. Come see the changes on the new OSTG site. www.ostg.com
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 


=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
