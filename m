From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 0/6] Patch series to add	of_platform
	binding to xilinxfb
Date: Wed, 10 Oct 2007 05:06:12 +0800
Message-ID: <1191963972.5446.1.camel@daplas>
References: <20071001155024.6114.47993.stgit@trillian.cg.shawcable.net>
	<1191370502.5238.1.camel@daplas>
	<fa686aa40710082143k2092e7d2l35bc3bda55bb6237@mail.gmail.com>
	<1191906242.6083.7.camel@daplas>
	<fa686aa40710091039hd945eb4n7dfdba3df37a08f2@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IfMHh-0004W3-UD for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 09 Oct 2007 14:06:34 -0700
Received: from rv-out-0910.google.com ([209.85.198.185])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IfMHg-0003PI-CG
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 09 Oct 2007 14:06:33 -0700
Received: by rv-out-0910.google.com with SMTP id g11so4226554rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 09 Oct 2007 14:06:32 -0700 (PDT)
In-Reply-To: <fa686aa40710091039hd945eb4n7dfdba3df37a08f2@mail.gmail.com>
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
Cc: linuxppc <linuxppc-dev@ozlabs.org>, akonovalov@ru.mvista.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>

On Tue, 2007-10-09 at 11:39 -0600, Grant Likely wrote:
> On 10/8/07, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > On Mon, 2007-10-08 at 22:43 -0600, Grant Likely wrote:
> > > BTW, what path do framebuffer patches take to get into Linus' tree?
> > > Does he pull your tree directly, or do they go through someone else's
> > > tree?
> >
> > They all go to -mm tree, unless it's a needed fix, then to Linus's.
> >
> > Tony
> 
> Ah, okay.
> 
> Since the XilinxFB is a powerpc-only device, is it okay with you if I
> get Paul Mackerras to merge them into his tree instead (that way the
> changes go in with the platform code which requires these changes)

Fine with me.

Tony


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
