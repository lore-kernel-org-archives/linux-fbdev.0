From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Sane behavior of fbset
Date: Fri, 18 Jun 2004 09:45:12 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406180945.12444.adaplas@hotpop.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bb8Qd-0000OI-6k
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Jun 2004 18:44:27 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bb8Qc-00023Z-OO
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Jun 2004 18:44:26 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id 738A8618B28
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Jun 2004 01:05:59 +0000 (UTC)
Received: from 203.177.116.25 (unknown [203.177.116.25])
	by smtp-1.hotpop.com (Postfix) with ESMTP id 58D011A01AC
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Jun 2004 00:43:44 +0000 (UTC)
Content-Disposition: inline
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi,

Currently, using fbset either corrupts the display, or at worst, hangs the GPU.  I consider
this a critical bug.  I don't want to discuss the pros/cons of using fbset vs stty to
change the console size, but we need to make sure that using fbset (or any utility
that utilizes the fb_set_var ioctl) does not produce undefined behavior.  There are 
at least 3 possibilities:

1.  Revert to 2.4 behavior.  This is easy to add since fbdev already has a notifier 
support. (I already have working code for this). Of course, stty will still work.

2.  Make the set_var ioctl return immediately if the vc_mode of the current display is 
KD_TEXT. Basically, fbset becomes an informational utility only. I don't know the 
repercussions of this with userland fb applications though.

3.  Modify fbset (and other similar utilities, if there are any) so it also issues an 
'stty-like' call after a 'set_var' call.   

Note: As mentioned by many people before, it's almost impossible to completely 
preserve per-console mode info because of the lack of a per-display var.  So even 
if we agree to implement #1,  it cannot completely match 2.4 behavior. Also, the lack
of per-display var means that drivers must be able to handle mode changes without 
any help.  James' fb_find_mode support in fbcon_resize does partly alleviate this 
limitation.

Comments?

Tony




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
