From: David Eger <eger@havoc.gtf.org>
Subject: Re: Framebuffer drivers maintainers
Date: Mon, 6 Sep 2004 00:14:29 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040906041429.GA7768@havoc.gtf.org>
References: <41270AD0.FE6C7970@orpatec.ch> <20040828043938.GA1150@havoc.gtf.org> <41308D44.8A57100B@orpatec.ch> <20040828150510.GA20778@havoc.gtf.org> <4130A349.17DDE7D2@orpatec.ch>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4Atu-0002tI-JH
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 05 Sep 2004 21:14:42 -0700
Received: from [69.28.190.101] (helo=havoc.gtf.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C4Atr-000298-71
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 05 Sep 2004 21:14:42 -0700
Received: from havoc.gtf.org (havoc.gtf.org [127.0.0.1])
	by havoc.gtf.org (Postfix) with ESMTP id 655B2746D
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon,  6 Sep 2004 00:14:29 -0400 (EDT)
Received: (from eger@localhost)
	by havoc.gtf.org (8.12.10/8.12.10/Submit) id i864ET4W008190
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 6 Sep 2004 00:14:29 -0400
Content-Disposition: inline
In-Reply-To: <4130A349.17DDE7D2@orpatec.ch>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Sat, Aug 28, 2004 at 05:22:50PM +0200, Otto Wyss wrote:
> David Eger wrote:
> > 
> > I'm in the middle of moving to Pittsburgh and starting graduate school;
> > I saw some posts on lkml where BenH found that the Radeon 7500 worked OK
> > if you told it to use noaccel, so that does sound like a problem in my code.
> 
> If you could say me where I can specify the noaccel, I'll try it.

You set noaccel as a kernel boot argument... here's a kernel command line
that tells the kernel to pass scrollback to 128kilobytes of text and noaccel
to the radeon frame buffer driver, and to auto-mount devfs:

"video=radeonfb:scrollback=128k,noaccel devfs=mount"

your kernel boot args are set by your bootloader -- change it in the relevant 
config file in /etc  (grub.conf, lilo.conf or yaboot.conf)

-dte


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
