From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 06/17] platinumfb: Fix resource
	management
Date: Thu, 04 Oct 2007 07:29:25 +1000
Message-ID: <1191446965.22572.103.camel@pasglop>
References: <46FDAA91.4080205@gmail.com>
	<20071003135629.96ff8ebf.akpm@linux-foundation.org>
Reply-To: benh@kernel.crashing.org,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IdBnI-00086x-Tz for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Oct 2007 14:30:13 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX1/RB/fld23l0SYAon6x+ygkZgulxQe3Oec=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IdBnH-0004br-9X
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Oct 2007 14:30:12 -0700
In-Reply-To: <20071003135629.96ff8ebf.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>


On Wed, 2007-10-03 at 13:56 -0700, Andrew Morton wrote:
> On Sat, 29 Sep 2007 09:29:53 +0800
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
> 
> > Current kernels have a non-working platinumfb due to some resource
> > management issues. This fixes it.
> 
> Why isn't this 2.6.23 material?

We decided it's been broken long enough and nobody complained so it
wasn't worth pushing. I wouldn't be surprised if there weren't more than
a handful of people left with a PowerMac 7200 which is I think the only
machine using platinumfb.

Feel free to send it to Linus for .23 if you feel like it though.

Cheers,
Ben.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
