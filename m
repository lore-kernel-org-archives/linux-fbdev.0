From: Kronos <kronos@people.it>
Subject: Re: OLS and console rearchitecture
Date: Sat, 31 Jul 2004 00:19:56 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040730221956.GA9140@dreamland.darkstar.lan>
References: <20040728185346.36263.qmail@web14921.mail.yahoo.com> <20040728213102.GB26087@dreamland.darkstar.lan> <1091055478.31913.7.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BqfjB-0004Vu-Cu
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Jul 2004 15:19:49 -0700
Received: from mail-relay-1.tiscali.it ([213.205.33.41])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BqfjA-0005ne-OZ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Jul 2004 15:19:49 -0700
Content-Disposition: inline
In-Reply-To: <1091055478.31913.7.camel@localhost.localdomain>
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
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

Il Wed, Jul 28, 2004 at 11:57:59PM +0100, Alan Cox ha scritto: 
> 
> > > 7) Mode setting from normal user space - devices will have a standard
> > > IOCTL accepting a mode string like fbdev currently uses.
> > 
> > sysfs? I sent a patch a while ago but didn't get much feedback.
> 
> How do you atomically tie sysfs objects to fbdev and X permissions
> models?

It's not atomic right now, the attribute is attached to a class_device
object after register_framebuffer (which init & register the
class_device). Is this a problem?

Luca
-- 
Home: http://kronoz.cjb.net
Windows NT crashed.
I'm the Blue Screen of Death.
No one hears your screams.


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
