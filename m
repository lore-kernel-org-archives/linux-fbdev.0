From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 4/4] fbdev: Convert a few drivers
 to use the fb_find_best_display helper
Date: Thu, 24 Nov 2005 14:44:16 +0800
Message-ID: <43856140.2010706@gmail.com>
References: <435F70CE.1070207@gmail.com> <1132809627.26560.436.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EfArA-00020D-1Z
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Nov 2005 22:45:20 -0800
Received: from xproxy.gmail.com ([66.249.82.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EfAr9-0002ER-UM
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Nov 2005 22:45:20 -0800
Received: by xproxy.gmail.com with SMTP id s6so128632wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 23 Nov 2005 22:45:19 -0800 (PST)
In-Reply-To: <1132809627.26560.436.camel@gaston>
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
Cc: Andrew Morton <akpm@osdl.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Benjamin Herrenschmidt wrote:
> On Wed, 2005-10-26 at 20:04 +0800, Antonino A. Daplas wrote:
>> Convert i810fb, nvidiafb and savagefb to use the fb_find_best_display
>> helper when searching for the initial video mode.
> 
>>From my experience, the 1st detailed timing is only good for flat
> panels... A lot of CRTs put junk in there. In fact, I suspect for CRT,
> the only sane thing is to default to 1024x768 if it fits the timings or
> 640x480 if not =P and let the user/distro deal with changing to
> something else.
> 

My experience though is the contrary.  I find that if the edid has
detailed timings and the 'prefer first detailed timing' flag is set,
the detailed timings are reliable even on CRT displays.

However, there are buggy edid blocks where the flag is set, but there
are no detailed timings at all, and that's when I get garbage.  (I already
sent a patch that fixes these buggy edid blocks).

And still, there are edid blocks where they enumerate detailed timings
but does not set the flag. This should not present with problems though.

Anyway, if there are such bad edid's out there, it's good if users refer
them to the list so I can add them to the monitor blacklist database (we
already have that in fbmon.c which currently has 2 entries). Anyway,
users can always override the chosen default mode if it does not work
for them.

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
