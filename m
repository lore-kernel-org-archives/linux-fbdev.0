From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: Some questions
Date: Wed, 05 Mar 2003 15:22:24 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E660820.8080604@winischhofer.net>
References: <3E65EAFB.7020208@winischhofer.net> <1046870342.1291.86.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [213.229.38.66] (helo=mail.falke.at)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qZpb-0000RM-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 06:25:16 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Sorry, but I send mails faster than I can think sometimes:

 > - and probably is the reason for that vertical offset I see after this
 >  mode switch: The text area on the screen is shifted down by exactly 8
 > pixels - 600-592=8

Or perhaps the fbcon_resize stuff does

1) either not take the penguin into account,

or

2) does this too early, namely before the call to check_var()?

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net            http://www.winischhofer.net/





-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
