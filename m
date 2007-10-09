From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 0/6] Patch series to add	of_platform
	binding to xilinxfb
Date: Tue, 09 Oct 2007 13:04:02 +0800
Message-ID: <1191906242.6083.7.camel@daplas>
References: <20071001155024.6114.47993.stgit@trillian.cg.shawcable.net>
	<1191370502.5238.1.camel@daplas>
	<fa686aa40710082143k2092e7d2l35bc3bda55bb6237@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1If7GP-0006uW-Ql for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 08 Oct 2007 22:04:13 -0700
Received: from rv-out-0910.google.com ([209.85.198.185])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1If7GP-0002Xx-Fc
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 08 Oct 2007 22:04:13 -0700
Received: by rv-out-0910.google.com with SMTP id g11so3389662rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 08 Oct 2007 22:04:09 -0700 (PDT)
In-Reply-To: <fa686aa40710082143k2092e7d2l35bc3bda55bb6237@mail.gmail.com>
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
To: Grant Likely <grant.likely@secretlab.ca>
Cc: akonovalov@ru.mvista.com, linuxppc <linuxppc@ozlabs.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Mon, 2007-10-08 at 22:43 -0600, Grant Likely wrote:
> On 10/2/07, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > On Mon, 2007-10-01 at 09:57 -0600, Grant Likely wrote:
> > > Assuming there are no major issues, I'd like to get this patch series
> > > queued up for inclusion in 2.6.24.
> >
> > Okay.
> >
> > Tony
> 
> BTW, what path do framebuffer patches take to get into Linus' tree?
> Does he pull your tree directly, or do they go through someone else's
> tree?

They all go to -mm tree, unless it's a needed fix, then to Linus's.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
