From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 18/33] pm3fb: mtrr support and
	noaccel option
Date: Fri, 27 Jul 2007 05:51:12 +0800
Message-ID: <1185486672.4565.5.camel@daplas>
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
	id 1IEBEt-00019o-0y for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 14:51:19 -0700
Received: from rv-out-0910.google.com ([209.85.198.185])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IEBEr-0002Or-Iy
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 14:51:19 -0700
Received: by rv-out-0910.google.com with SMTP id g11so165094rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 26 Jul 2007 14:51:16 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2007-07-26 at 13:12 -0700, Andrew Morton wrote:
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
> > +#ifdef CONFIG_MTRR
> > +#include <asm/mtrr.h>
> > +#endif
> 
> Is the ifdef there needed for a successful compile?  If not, it's nicer to
> leave it out.

Yes, not all archs have asm/mtrr.h.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
