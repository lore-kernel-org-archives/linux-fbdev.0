From: David Eger <eger@havoc.gtf.org>
Subject: Re: Framebuffer drivers maintainers
Date: Sat, 28 Aug 2004 11:05:10 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040828150510.GA20778@havoc.gtf.org>
References: <41270AD0.FE6C7970@orpatec.ch> <20040828043938.GA1150@havoc.gtf.org> <41308D44.8A57100B@orpatec.ch>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C14lb-000709-MW
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 28 Aug 2004 08:05:19 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C14la-000296-NN
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 28 Aug 2004 08:05:19 -0700
Received: from havoc.gtf.org (havoc.gtf.org [127.0.0.1])
	by havoc.gtf.org (Postfix) with ESMTP id 7635676D8
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 28 Aug 2004 11:05:10 -0400 (EDT)
Received: (from eger@localhost)
	by havoc.gtf.org (8.12.10/8.12.10/Submit) id i7SF5A7n021092
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 28 Aug 2004 11:05:10 -0400
Content-Disposition: inline
In-Reply-To: <41308D44.8A57100B@orpatec.ch>
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

On Sat, Aug 28, 2004 at 03:48:52PM +0200, Otto Wyss wrote:
> David Eger wrote:
> > 
> > radeonfb:
> >    Ben Herrenschmidt took over from Ani Joshi for 2.6, though he's pretty busy,
> >    so radeonfb maintainership tends to be a group effort.  I ported copyarea()
> >    and fillrect() from the X radeon driver, so that accel code is my fault ;-)
> > 
> BTW have you seen my thread in the users lists
> "http://sourceforge.net/mailarchive/forum.php?thread_id=5425101&forum_id=2358"
> ? Do you have a solution or a workaround?

I'm in the middle of moving to Pittsburgh and starting graduate school;  
I saw some posts on lkml where BenH found that the Radeon 7500 worked OK 
if you told it to use noaccel, so that does sound like a problem in my code.  
Unfortunately (fortunately?) I don't see the issue on my Radeon 9000, so 
it'll be hard for me to track down, and I won't really have free time for
a few weeks :-/

-David


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
