From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Linux 2.5.19
Date: Thu, 30 May 2002 00:25:59 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020530002559.G30585@flint.arm.linux.org.uk>
References: <20020529211702.E30585@flint.arm.linux.org.uk> <Pine.LNX.4.10.10205291331500.19493-100000@www.transvirtual.com> <20020529214739.F30585@flint.arm.linux.org.uk> <3CF554A1.4090607@evision-ventures.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17DCpX-00070y-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 29 May 2002 16:26:11 -0700
Content-Disposition: inline
In-Reply-To: <3CF554A1.4090607@evision-ventures.com>; from dalecki@evision-ventures.com on Thu, May 30, 2002 at 12:22:25AM +0200
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

On Thu, May 30, 2002 at 12:22:25AM +0200, Martin Dalecki wrote:
> Dear Russell why don't you just abuse Linus as a spinlock for this kind
> of synchronization its his job. No need to get angry at this.
> Hey it's developement series time...

The fundamental point I'm making is people shouldn't go around taking
changes randomly from maintainers trees, and believing that they know
far better than the maintainer what they're doing, especially when they
don't have the hardware to even try it out, and go submitting these
changes to Linus without even asking about it first...  after the
maintainer has been very careful and explicitly not submitted
the change because they have very good reasons not to.

What if I were to take, say, Mochel's experimental tree and send some
random alpha code to Linus?  Let anarchy rule!

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
