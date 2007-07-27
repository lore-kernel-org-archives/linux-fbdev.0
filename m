From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: Re: [PATCH 18/33] pm3fb: mtrr support and
	noaccel option
Date: Fri, 27 Jul 2007 19:19:34 +0200
Message-ID: <20070727191934.7824e92b.krzysztof.h1@wp.pl>
References: <46A8925B.8090801@gmail.com>
	<20070726131238.9ed4bc7a.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IETQO-0001vd-8s for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 27 Jul 2007 10:16:26 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IETQN-0001Q4-Q1
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 27 Jul 2007 10:16:24 -0700
In-Reply-To: <20070726131238.9ed4bc7a.akpm@linux-foundation.org>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@gmail.com>

On Thu, 26 Jul 2007 13:12:38 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu, 26 Jul 2007 20:23:55 +0800 "Antonino A. Daplas" <adaplas@gmail.com> wrote:
> 
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > This patch adds usage of MTRR registers and two new options: noaccel and
> > nomtrr.
> > 
> 
> It's been tested with CONFIG_MTRR=n, I trust?
> 

Yes, of course. The only thing I haven't tested is compilation on the big-endian machine.

You can reject the patch if you want and will prepare the next version (without issues you pointed out). Or you can accept it and I will fix issues in next patch.

Regards,
Krzysztof

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
