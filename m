From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] VT locking
Date: Tue, 6 Jan 2004 13:16:36 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040106121636.GA888@elf.ucw.cz>
References: <1073349182.9504.175.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Adq7D-0003oP-7F
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jan 2004 04:15:19 -0800
Received: from gprs214-240.eurotel.cz ([160.218.214.240] helo=amd.ucw.cz)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Adq7A-0007ad-O6
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jan 2004 04:15:19 -0800
Content-Disposition: inline
In-Reply-To: <1073349182.9504.175.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>, James Simmons <jsimmons@infradead.org>

Hi!

> The VT code is currently, it seems, full of races, it basically doesn't
> do any locking... This patch is definitely not fixing everything,
> but at

And the races bite, BTW. For years I was seeing weird stuff like
console output on blanked console if scroll happened at approximately
same time as blank. It was hard to reproduce reliably, through.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
