From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Vesa fix
Date: 14 May 2003 00:01:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1052866894.1206.16.camel@dhcp22.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0305122237300.14641-100000@phoenix.infradead.org>
	 <20030513175022.GA3309@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20030513175022.GA3309@suse.de>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Dave Jones <davej@codemonkey.org.uk>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Maw, 2003-05-13 at 18:50, Dave Jones wrote:
> On Mon, May 12, 2003 at 10:44:29PM +0100, James Simmons wrote:
> 
>  >    The results of the EDID info from the BIOS has been varied. For some it 
>  > worked. Others it gave the wrong data. Then for other even the headers 
>  > where corrupted :-( 
> 
> XFree86 seems to do a pretty good job of getting it right, maybe they
> have blacklists ? Then again, this stuff is arguably better off done
> in userspace anyway IMO.

XFree handles EDID per driver and uses different methods in different
drivers.
