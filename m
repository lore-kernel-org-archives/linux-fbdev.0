From: Ben Dooks <ben-fbdev@fluff.org>
Subject: Re: how long before a new driver makes it into the mainline kernel
Date: Mon, 5 Sep 2005 23:42:11 +0100
Message-ID: <20050905224211.GD1810@home.fluff.org>
References: <20050905112144.GB1810@home.fluff.org> <431CC86D.4020905@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ECPfO-0003qb-1q
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Sep 2005 15:42:18 -0700
Received: from host-84-9-201-77.bulldogdsl.com ([84.9.201.77] helo=aeryn.fluff.org.uk)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ECPfM-0005Au-GF
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Sep 2005 15:42:18 -0700
Received: from ben by aeryn.fluff.org.uk with local (Exim 3.36 #1 (Debian))
	id 1ECPfH-0007z6-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 05 Sep 2005 23:42:11 +0100
Content-Disposition: inline
In-Reply-To: <431CC86D.4020905@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

On Tue, Sep 06, 2005 at 06:36:29AM +0800, Antonino A. Daplas wrote:
> Ben Dooks wrote:
> > I've just been notified that the s3c2410 framebuffer driver has been
> > submitted by Arnaud. I have a question about what path this will
> > take to getting into the mainline kernel,
> 
> New drivers go to the mm tree first. I just sent the patch to Andrew.

Ok, will check there tommorow.
 
> > and how long it will be.
> 
> It's early in the cycle, so it should get to linux-2.6.14. 
> 
> Tony
> 
> PS: If this driver is already well tested, we can always tell Andrew
> to get it to mainline quicker.

I'm reasonably happy with it, I've been asking Arnaud to get it
moving since late in 2.6.12 (iirc)

thanks,
-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
