From: Miles Lane <miles.lane@attbi.com>
Subject: Re: 2.5.51 -- rivafb is whacky (characters flipped on vertical axis, 640x480 usable area shown inside a higher-res area, etc).
Date: Thu, 12 Dec 2002 22:55:07 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <D075B526-0E67-11D7-9B90-000393A337FC@attbi.com>
References: <1039770362.1025.18.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v548)
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sccrmhc02.attbi.com ([204.127.202.62])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Mk6K-0003Qi-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 12 Dec 2002 23:19:12 -0800
In-Reply-To: <1039770362.1025.18.camel@localhost.localdomain>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


On Friday, December 13, 2002, at 01:34  AM, Antonino Daplas wrote:
> How extensive is the color problem?  Does it just affect the logo, or
> everything? Also, is the color problem present in both hardware and
> software mode (just do fbset -accel true/false to find out)?  Is the
> vertical mirroring as reported by Miles still present?  How about bpp16
> or bpp32?

I have had mixed results with 2.5.51 (vanilla).  I have booted
once where I didn't see the mirroring.

I have not had a chance to test your patch.  Hopefully I'll have
time tomorrow.  Sorry for the delay.

	Miles



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
