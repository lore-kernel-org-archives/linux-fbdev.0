From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: typo errors in the modedb.c video
	mode	tables
Date: Sun, 22 Jul 2007 08:26:07 +0800
Message-ID: <1185063967.8688.9.camel@daplas>
References: <BAY137-F3235E7DB69C9967750E90DA3F50@phx.gbl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ICPxQ-0003LY-UY for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 21 Jul 2007 18:10:00 -0700
Received: from wa-out-1112.google.com ([209.85.146.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1ICPxP-00021K-8r
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 21 Jul 2007 18:10:00 -0700
Received: by wa-out-1112.google.com with SMTP id k22so1729631waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 21 Jul 2007 18:09:58 -0700 (PDT)
In-Reply-To: <BAY137-F3235E7DB69C9967750E90DA3F50@phx.gbl>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

On Sat, 2007-07-21 at 18:59 -0400, John Lumby wrote:
> I believe there are a few typos in the mode tables in modedb.c   -   in the 
> current 2.6.22 :

> I also don't know what effect these errors are having - I found them from 
> studying the code after I could not get my desired 1400x1050@60 for my 
> supersavage framebuffer console.       One of the above entries is the one I 
> want.    Is the refresh value in these tables used for matching modes? 

Yes, the refresh field is used for matching.    
 
> It seems so from my reading of fb_find_mode() in the same file.

I'll review those values again and apply the appropriate corrections.
You can also avoid the table lookup and use 1400x1050M@60 instead.  The
timings will be computed.

Tony 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
