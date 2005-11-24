From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/4] fbdev: Convert a few drivers
	to use the fb_find_best_display helper
Date: Thu, 24 Nov 2005 16:20:27 +1100
Message-ID: <1132809627.26560.436.camel@gaston>
References: <435F70CE.1070207@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ef9av-0006Oq-1p
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Nov 2005 21:24:29 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1Ef9at-0008R6-N1
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Nov 2005 21:24:29 -0800
In-Reply-To: <435F70CE.1070207@gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>

On Wed, 2005-10-26 at 20:04 +0800, Antonino A. Daplas wrote:
> Convert i810fb, nvidiafb and savagefb to use the fb_find_best_display
> helper when searching for the initial video mode.

From my experience, the 1st detailed timing is only good for flat
panels... A lot of CRTs put junk in there. In fact, I suspect for CRT,
the only sane thing is to default to 1024x768 if it fits the timings or
640x480 if not =P and let the user/distro deal with changing to
something else.

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
