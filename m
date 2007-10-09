From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/6] Patch series to add of_platform
	binding to xilinxfb
Date: Tue, 9 Oct 2007 11:39:18 -0600
Message-ID: <fa686aa40710091039hd945eb4n7dfdba3df37a08f2@mail.gmail.com>
References: <20071001155024.6114.47993.stgit@trillian.cg.shawcable.net>
	<1191370502.5238.1.camel@daplas>
	<fa686aa40710082143k2092e7d2l35bc3bda55bb6237@mail.gmail.com>
	<1191906242.6083.7.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IfJ3C-0000HY-2j for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 09 Oct 2007 10:39:22 -0700
Received: from wa-out-1112.google.com ([209.85.146.183])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IfJ3A-0002Xu-RA
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 09 Oct 2007 10:39:22 -0700
Received: by wa-out-1112.google.com with SMTP id k22so2254490waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 09 Oct 2007 10:39:19 -0700 (PDT)
In-Reply-To: <1191906242.6083.7.camel@daplas>
Content-Disposition: inline
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linuxppc <linuxppc-dev@ozlabs.org>, akonovalov@ru.mvista.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>

On 10/8/07, Antonino A. Daplas <adaplas@gmail.com> wrote:
> On Mon, 2007-10-08 at 22:43 -0600, Grant Likely wrote:
> > BTW, what path do framebuffer patches take to get into Linus' tree?
> > Does he pull your tree directly, or do they go through someone else's
> > tree?
>
> They all go to -mm tree, unless it's a needed fix, then to Linus's.
>
> Tony

Ah, okay.

Since the XilinxFB is a powerpc-only device, is it okay with you if I
get Paul Mackerras to merge them into his tree instead (that way the
changes go in with the platform code which requires these changes)

Paulus, is that okay by you?

Thanks,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
