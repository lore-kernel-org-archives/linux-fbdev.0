From: Chris Larson <kergoth@handhelds.org>
Subject: Re: backlight/frontlight
Date: Fri, 20 Dec 2002 12:33:59 -0700
Sender: linux-arm-kernel-admin@lists.arm.linux.org.uk
Message-ID: <20021220193359.GB4550@rikers.org>
References: <20021219193645.B25149@flint.arm.linux.org.uk> <Pine.LNX.4.44.0212201813390.6471-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-arm-kernel-admin@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212201813390.6471-100000@phoenix.infradead.org>
Errors-To: linux-arm-kernel-admin@lists.arm.linux.org.uk
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>, Frank Becker <fbecker@intrinsyc.com>, Chris Larson <kergoth@handhelds.org>, linux-arm-kernel@lists.arm.linux.org.uk, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

* James Simmons (jsimmons@infradead.org) wrote:
> 
> Oh. Could someone list all the approaches people toke to solve this 
> problem. I like to find a solution that covers as many cases as possible.

James,

	As far as I know, the two that seem worth looking at, at the moment,
are Russ Dill's implementation, which was posted to the LAK list in this
thread, and Nicolas' implementation in the -pxa patches.
There are obviously others out there, but said other implementations are
individual hacks for certain machine types, and aren't generally useful.

--
Chris Larson
kergoth at handhelds dot org
OpenZaurus Project Maintainer - http://openzaurus.org/

-------------------------------------------------------------------
Subscription options: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ/Etiquette:       http://www.arm.linux.org.uk/armlinux/mailinglists.php
