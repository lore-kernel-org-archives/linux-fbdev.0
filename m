From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/4] fbdev: Convert a few drivers
	to use the fb_find_best_display helper
Date: Thu, 24 Nov 2005 17:53:58 +1100
Message-ID: <1132815239.26560.445.camel@gaston>
References: <435F70CE.1070207@gmail.com> <1132809627.26560.436.camel@gaston>
	 <43856140.2010706@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EfB3Y-0002as-1V
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Nov 2005 22:58:08 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EfB3X-0003YJ-Tm
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Nov 2005 22:58:08 -0800
In-Reply-To: <43856140.2010706@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>


> My experience though is the contrary.  I find that if the edid has
> detailed timings and the 'prefer first detailed timing' flag is set,
> the detailed timings are reliable even on CRT displays.
> 
> However, there are buggy edid blocks where the flag is set, but there
> are no detailed timings at all, and that's when I get garbage.  (I already
> sent a patch that fixes these buggy edid blocks).

Ok, it may have been these then, I remember issues with some IBM CRTs a
while ago :)

>And still, there are edid blocks where they enumerate detailed timings
> but does not set the flag. This should not present with problems though.
> 
> Anyway, if there are such bad edid's out there, it's good if users refer
> them to the list so I can add them to the monitor blacklist database (we
> already have that in fbmon.c which currently has 2 entries). Anyway,
> users can always override the chosen default mode if it does not work
> for them.

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
