From: "Buttchereit, Axel (XL)" <XL@XLsigned.net>
Subject: Re: [patch] intelfb: add (partial) support for
 915G
Date: Sat, 29 Jan 2005 16:52:12 +0100
Message-ID: <41FBB12C.4090305@XLsigned.net>
References: <41FB1AEB.4090206@XLsigned.net> <200501292003.59146.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cuutp-0000dj-29
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 29 Jan 2005 07:52:37 -0800
Received: from mail.goracer.de ([62.75.192.134])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Cuutn-0001Am-Do
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 29 Jan 2005 07:52:37 -0800
In-Reply-To: <200501292003.59146.adaplas@hotpop.com>
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


Antonino A. Daplas wrote:
> On Saturday 29 January 2005 13:11, Buttchereit, Axel (XL) wrote:
> 
>>Add (partial) support for 915G
>>  No HW cursor at the moment
>>  Screen is blanked but signal/sync is not switched off
> 
> 
> Is the driver usable?  If not, make it work with your machine at least.
>

The driver works with my machine. Both as a module and statically linked.

Support is partial/incomplete, because
  - hwcursor does not work, i. e. I haven't managed yet to
    derive the special code for hwcursor on 915G from
    the XFree86/Xorg-code. That is why I'm hard-wiring the
    value of hwcusror to "0" on 915G.
  - DPMS does nor work properly, but I do not know whether this
    is because of my incomplete patch, because of my
    hardware or because of the kernel (version).

Furthermore I think that support for the mobila variant 915GM,
should be inlcuded, but I haven't got the hardware.

I would be happy to get feedback from a user that has tried the patched
and the unpatched "intelfb" with current 2.6.10 on 830/855/865 to
see what is wrong with DPMS and from a user that has the 915GM.

The "final" patch should support "hwcusor", "DPMS" and 915GM.

Cheers
--Axel


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
