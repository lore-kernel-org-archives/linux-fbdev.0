From: Alex Deucher <agd5f@yahoo.com>
Subject: S3 virge/Savage question
Date: Mon, 12 Apr 2004 16:53:22 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040412235322.99636.qmail@web11304.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDBFE-000487-4F
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Apr 2004 16:53:40 -0700
Received: from web11304.mail.yahoo.com ([216.136.131.207])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BDBFE-00012J-2f
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Apr 2004 16:53:40 -0700
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
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net

Sorry this is off topic, but I'm at a loss at the moment and I'm hoping
someone here can help me.  I'm trying to add dualhead support (duoview)
to the xfree86/XORG savage and virge drivers for savage mx/ix and virge
mx.  I don't have databooks, but I found some incomplete info on the
virge mx and I've figured out how it's supposed to work for the most
part.  I can program both dot clocks and set the mode on both crtcs,
but I can't get the second crtc to actually display anything. when I
drive an output with crtc2, the attached device just goes into
powersave mode.  I'm guessing there must be an additonal "screen off"
bit or crtc2 enable bit I'm missing.  Is sr1 bit 5 (screen off) global,
or specific to crtc1? Also both dot clocks work so that doesn't seem to
be the issue.

CRTC  DCLK  Output      Result
---------------------------------------
crtc1 dclk1 FP/CRT/Both Works
crtc1 dclk2 FP/CRT/Both Works
crtc2 dclk1 FP/CRT/Both No signal
crtc2 dclk2 FP/CRT/Both No signal 

Additional info about how duoview works (what I've been able to figure
out):
http://www.botchco.com/alex/new-savage/savage/DUOVIEW.txt
Current status of my savage duoview code:
http://www.botchco.com/alex/new-savage/html/
Any help would be much appreciated. Please cc: me directly as I'm not
on linux-kernel.

Thanks,

Alex Deucher
http://dri.sourceforge.net/cgi-bin/moin.cgi/AlexDeucher

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
