From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Possible Bug in radeonfb (?)
Date: 26 Feb 2003 16:02:55 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046246472.11751.44.camel@localhost.localdomain>
References: <20030225182115.GB2487@elitel.biz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18nwWE-0005HV-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Feb 2003 00:02:23 -0800
In-Reply-To: <20030225182115.GB2487@elitel.biz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrea Mazzoleni <amadvance@users.sourceforge.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-02-26 at 02:21, Andrea Mazzoleni wrote:
> In radeonfb (2.4.20) I have found a possible inconsistency.
> 
> In the PLL clock computation the initial range check compares the
> requested clock with the value pll_min/12. But immeditially later
> I see that the higher PLL post divider is 16 and not 12.
> 
> Is it correct ? Or the check should use 16 instead of 12 ?
> 

Probably does not matter, unless you intend to use very, very low
dotclocks (< 10MHz).

Tony



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
