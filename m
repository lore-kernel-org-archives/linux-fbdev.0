From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Linux 2.5.19
Date: Thu, 30 May 2002 00:52:07 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020530005207.I30585@flint.arm.linux.org.uk>
References: <20020529211702.E30585@flint.arm.linux.org.uk> <Pine.LNX.4.10.10205291331500.19493-100000@www.transvirtual.com> <20020529214739.F30585@flint.arm.linux.org.uk> <3CF554A1.4090607@evision-ventures.com> <20020530002559.G30585@flint.arm.linux.org.uk> <3CF55941.7060806@evision-ventures.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17DDEn-0008QE-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 29 May 2002 16:52:17 -0700
Content-Disposition: inline
In-Reply-To: <3CF55941.7060806@evision-ventures.com>; from dalecki@evision-ventures.com on Thu, May 30, 2002 at 12:42:09AM +0200
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: James Simmons <jsimmons@transvirtual.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, May 30, 2002 at 12:42:09AM +0200, Martin Dalecki wrote:
> Well ... they have once excuse... if the maintainer is
> himself a bit slow on submitting to Linus. Yes I know that's
> a matter primary of personal style so there is no need
> to discuss about it until down...

You still don't get the point.

1. Patches from cyber2000fb.c have been submitted and the driver in Linus'
   tree up to 2.5.18 is completely up to date and functional, with zero
   known problems.

2. Someone comes along, scans my patch and finds a change.

3. This person takes it upon themselves to solely take that change,
   and, without querying the person who put out the patch set, or
   the maintainer of the driver, decides to send it to Linus without
   testing it in any way since they don't have the hardware to test it.

4. Maintainer, naturally, gets really pissed off.

If you think this is acceptable, why the hell did I bother sending those
IDE DMA changes through you?  After all, you don't need to know about
them because I know better than you, don't I?  *That's* what you're
advocating here, and I'm sure you're going to object to that.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
