From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: open messes up the screen
Date: Wed, 16 Mar 2005 15:57:11 +1100
Message-ID: <1110949031.14171.137.camel@gaston>
References: <20050315150934.GA6687@tpapp.student.princeton.edu>
	 <20050315173827.GA10301@pants.nu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050315173827.GA10301@pants.nu>
Resent-Message-ID: <JZ4xSC.A.CkD.y07NCB@murphy>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:debian-powerpc@lists.debian.org>
List-Help: <mailto:debian-powerpc-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-powerpc-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-powerpc-request@lists.debian.org?subject=unsubscribe>
List-Archive: <http://lists.debian.org/debian-powerpc/>
Content-Type: text/plain; charset="us-ascii"
To: Brad Boyer <flar@allandria.com>
Cc: Tamas K Papp <tpapp@Princeton.EDU>, Debian PPC <debian-powerpc@lists.debian.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Well, open is really openvt. It fiddles around with the console to
> start up a program on a new virtual console. X doesn't always like
> that, but it should work better than that. The vt change should
> trigger X to properly cleanup the screen before the switch. I'd
> say file a bug.
> 

It's not a VT change issue. It's an old bug of the fbcon code that
causes opening a VT to reset the palette on the current fb even when not
in front.

Ben.
