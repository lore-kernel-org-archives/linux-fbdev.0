From: Hamie <hamish@travellingkiwi.com>
Subject: radeonfb vs IBM r50p - Blank screen (But with a cursor)
Date: Fri, 18 Jun 2004 14:42:54 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40D2F15E.5080701@travellingkiwi.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbJeJ-0005UE-AJ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 06:43:19 -0700
Received: from balance1.baplc.com ([163.166.150.21] helo=rsl53.baplc.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BbJeI-0007Gg-MY
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 06:43:19 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, akpm@osdl.org

Hi.

I've just tried kernel 2.6.7 and radeonfb on my Thinkpad r50p, and sadly 
it doesn't seem to work as advertised. The display works fine in VGA 
80x24 on initial boot, but when the radeonfb initialises, I get a blank 
screen with just the cursor flashing back & forth at the bottom in time 
to whatever is supposedly supposed to be displayed.

Thankfully X does manage to get the display back, so I can login 
afterwards... If I load it as a module, I can then switch back to the 
console (CTRL-ALT-F1) and I'm back in 80x24 VGA mode again...


dmesg output is appended...

The system itself is debian-unstable

Not sure if I'm doing anything wrong... Or if it's a butg. The dmesg 
output (WIth radeonfb debugging enabled) doesn't seem to show any 
errors. I am unsing ACPI though (As you can see from the dmesg output). 
Any advice gratefully listened to...

TIA

hamish


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
