From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: fbcon or sisfb problem?
Date: Fri, 28 May 2004 02:26:54 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40B6874E.8070200@winischhofer.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTVEX-00031C-Uf
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 May 2004 17:28:25 -0700
Received: from [213.229.38.18] (helo=home.winischhofer.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BTVEV-0003y5-Sx
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 May 2004 17:28:24 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net


I see the following problems here with fbcon in 2.6.6 + my development 
version of sisfb (just committed to Andrew and Marcelo since it fixes 
important 64bit issues not relevant here):

1) Upon start (be it in kernel, be it upon modprobe), I see a big white 
rectangle. It seems that this rectangle's size matches exactly the size 
of the previous console area. I have seen reports of similar problems 
since late 2003. Any progress on this? (I have digged around in the 
fbcon code but got lost at some time.)

2) When switching from X back to the console, I only get a blank screen 
and a blinking cursor. Switching to another text console and back makes 
all text of the initial console reappear. Known issue?

3) On a pure 64bit AMD system, starting any text editor (nano, jed, etc) 
does not clear the screen. Characters that were visible on the screen 
prior to starting the editor (eg other programs' output, etc) still show 
up in the editor (of course, they are "ghost" characters and can't be 
edited). Switching to another console and back solves this, too. Known 
issue? (Sidenote: This does not happen on my ia32 systems).

None of these problems seem sisfb's fault. They all happen if sisfb's 2D 
acceleration is disabled as well. Opinions? Comments?

Thomas

PS: Please cc: me

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          http://www.winischhofer.net/
twini AT xfree86 DOT org


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
