From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Rivafb won't work with DVI connector
Date: Tue, 23 Nov 2004 23:18:00 +0800
Message-ID: <200411232318.00795.adaplas@hotpop.com>
References: <200411191137.14649.andrew@walrond.org> <200411232229.00311.adaplas@hotpop.com> <200411231509.24489.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWcRZ-0004Bt-8U
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 07:19:01 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CWcRY-0002QW-77
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 07:19:01 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 5E82AA25EF5
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 Nov 2004 15:18:04 +0000 (UTC)
In-Reply-To: <200411231509.24489.andrew@walrond.org>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Walrond <andrew@walrond.org>

On Tuesday 23 November 2004 23:09, Andrew Walrond wrote:
> On Tuesday 23 Nov 2004 14:28, Antonino A. Daplas wrote:
> > Okay, try the attached patch.
>
> Ok, booting on dsub without params now results in a good 1024x768 (128x48)
> console and boots cleanly. (Note this was a 1600x1200 (200xwhatever) before
> the patch, which is the preferred, native resolution of the screen.)
>

Can you enable debugging in drivers/video/fbmon.c?  Just change the "undef" to
define in this line:

#undef DEBUG  /* define this for verbose EDID parsing output */

Send me the dmesg output for both dvi and dsub.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
