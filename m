From: David Eger <eger@havoc.gtf.org>
Subject: Re: accelerated radeonfb produces artifacts on scrolling in 2.6.7
Date: Wed, 16 Jun 2004 14:41:45 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040616184145.GA12673@havoc.gtf.org>
References: <20040616182415.GA8286@middle.of.nowhere>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BafM9-0004Ck-TF
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 11:41:53 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BafM9-0006Nj-Ji
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 11:41:53 -0700
Content-Disposition: inline
In-Reply-To: <20040616182415.GA8286@middle.of.nowhere>
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
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 08:24:15PM +0200, Jurriaan wrote:
> The radeonfb driver in 2.6.7 produces some interesting artifacts on
> scrolling, both scrolling horizontally and vertically.

The corruption you are talking about is, I believe, caused by a couple of things:

(1) we're not issuing enough fifo_wait()'s around our accel engine
    and pan register writes.
(2) there's some disconnect between writing to fb memory, panning, and
    copyarea()/fillrect() calls

I sent a hack of a fix for this to Ben a week ago, adding a call to radeonfb_sync()
at the end of radeonfb_copyarea() and radeonfb_fillrect().  This seems to fix the
problem for me, but you *shouldn't* have to do this.  

I haven't tracked it any further than this.  My next guess would be auditing register 
writes and making sure there are enough fifo_wait()'s...

-dte


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
