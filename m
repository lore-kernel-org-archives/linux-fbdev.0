From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: 2.6.7 still garbage upon start
Date: Fri, 18 Jun 2004 00:41:53 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40D21E31.5070904@winischhofer.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bb5b4-0003Fs-4h
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Jun 2004 15:43:02 -0700
Received: from [213.229.38.18] (helo=home.winischhofer.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Bb5b3-0004iB-Fc
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Jun 2004 15:43:01 -0700
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


modprobing fbcon still paints a white rectangle. Difference to 2.6.6 is 
that this rectangle now fills the entire screen instead of a smaller 
area. As before, text is shown all correctly (painted upon the 
rectangle), and the white rectangle scrolls up just like text and in the 
end vanishes.

Switching to another VT while in X still leaves you with a blank screen 
and a blinking cursor. If one presses return, the screen contents is 
restored.

Hm?

(fbdev driver: sisfb 1.7.13 as of current -mm; kernel vanilla 2.6.7. 
Don't see any relevant changes in the -mm tree either.)

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          http://www.winischhofer.net/
twini AT xfree86 DOT org


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
