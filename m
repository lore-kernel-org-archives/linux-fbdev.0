From: Eric Pretorious <eric@pretorious.net>
Subject: /usr/src/linux/Documentation/fb/aty128fb.txt
Date: Mon, 4 Oct 2004 15:03:05 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410041503.05154.eric@pretorious.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEb1d-0003gs-UF
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 04 Oct 2004 15:09:45 -0700
Received: from he.net ([216.218.186.2])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CEb1b-0005Gh-Oz
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 04 Oct 2004 15:09:45 -0700
Received: from localhost ([216.218.186.2]) by he.net for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 4 Oct 2004 15:09:42 -0700
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
To: Brad Douglas <brad@neruo.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Hi, Brad:

Thanks for creating aty128fb. It works nicely on my Dell Lattitude.

In reading the kernel documentation, I believe that I may have found a minor 
error regarding vesafb: In the "How to use it" secition, you wrote...

>You should compile in both vgacon (to boot if you remove your Rage128 from
>box) and aty128fb (for graphics mode). You should not compile-in vesafb
>unless you have primary display on non-Rage128 VBE2.0 device (see
>Documentation/vesafb.txt for details).

...and later, in the "Configuration" section you wrote...

>You can pass kernel command line options to vesafb with
>`video=aty128fb:option1,option2:value2,option3' (multiple options should
>be separated by comma, values are separated from options by `:').
>Accepted options:

I believe that the second passage should read...

>You can pass kernel command line options to aty128fb with...

-- 
Eric P.,
Sunnyvale, CA


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
