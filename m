From: Andrea Mazzoleni <amadvance@users.sourceforge.net>
Subject: Possible Bug in radeonfb (?)
Date: Tue, 25 Feb 2003 19:21:15 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030225182115.GB2487@elitel.biz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [212.34.224.142] (helo=mail4.elitel.it)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18niks-0005Ms-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 25 Feb 2003 09:20:34 -0800
Received: (from am@localhost)
	by darkstar.example.net (8.12.4/8.12.4) id h1PILFK6002549
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 25 Feb 2003 19:21:15 +0100
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

In radeonfb (2.4.20) I have found a possible inconsistency.

In the PLL clock computation the initial range check compares the
requested clock with the value pll_min/12. But immeditially later
I see that the higher PLL post divider is 16 and not 12.

Is it correct ? Or the check should use 16 instead of 12 ?

This is the code :

	if (freq > rinfo->pll.ppll_max)
		freq = rinfo->pll.ppll_max;
	if (freq*12 < rinfo->pll.ppll_min)
		freq = rinfo->pll.ppll_min / 12;

	{
		struct {
			int divider;
			int bitvalue;
		} *post_div,
		  post_divs[] = {
			{ 1,  0 },
			{ 2,  1 },
			{ 4,  2 },
			{ 8,  3 },
			{ 3,  4 },
			{ 16, 5 },
			{ 6,  6 },
			{ 12, 7 },
			{ 0,  0 },
		};

		for (post_div = &post_divs[0]; post_div->divider; ++post_div) {
			rinfo->pll_output_freq = post_div->divider * freq;
			if (rinfo->pll_output_freq >= rinfo->pll.ppll_min  &&
			    rinfo->pll_output_freq <= rinfo->pll.ppll_max)
				break;
		}


-- 
Andrea Mazzoleni
935A 2D3C 5C70 BCD6 CB0C  ED89 7C19 4321 6340 3F6D




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
