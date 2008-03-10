From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/6] gxfb: move MSR bit fields into
	gxfb.h
Date: Mon, 10 Mar 2008 14:26:33 -0700
Message-ID: <20080310142633.33204659.akpm@linux-foundation.org>
References: <20080308204840.47a27236@ephemeral>
	<20080310131432.e4567537.akpm@linux-foundation.org>
	<20080310162844.6e8e9215@ephemeral>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JYpXF-0001pX-Ps for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Mar 2008 14:27:54 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JYpXE-0003kG-FN
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Mar 2008 14:27:53 -0700
In-Reply-To: <20080310162844.6e8e9215@ephemeral>
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
To: Andres Salomon <dilinger@queued.net>
Cc: jordan.crouse@amd.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com, info-linux@geode.amd.com

On Mon, 10 Mar 2008 16:28:44 -0400
Andres Salomon <dilinger@queued.net> wrote:

> > 
> > In [1/6] you refer to "the MSR cleanup patch".  I don't know what that is.
> > 
> 
> That would be this:
> 
> http://thread.gmane.org/gmane.linux.kernel/645387/focus=645636
> 

Oh, that.  OK, I found that and it still applies and it makes these new
patches apply.

> 
> > 
> > Please clean up the changelogs - remove those email headers from the
> > email-forwarding operation and remove the additional little commentary on
> > top: if there's actually anything in there which is needed then it should
> > be integrated into the changelog proper, thanks.
> > 
> 
> For future requests, or should I resend these to you?

Well I cleaned these up and was ready to go, but I think some updates are
needed, please.  So please consider, redo and resend everything, including
the already-acked-by-Jordan MSR cleanup.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
