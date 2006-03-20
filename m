From: "Dave Airlie" <airlied@gmail.com>
Subject: intelfb i9xx support
Date: Mon, 20 Mar 2006 21:25:41 +1100
Message-ID: <21d7e9970603200225k6df55452iacbe7ccbf6518d47@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FLHa6-0004FE-Df
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 20 Mar 2006 02:25:46 -0800
Received: from nproxy.gmail.com ([64.233.182.197])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FLHa5-0006SS-MA
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 20 Mar 2006 02:25:46 -0800
Received: by nproxy.gmail.com with SMTP id x37so717458nfc
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 20 Mar 2006 02:25:41 -0800 (PST)
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi,

This is an inquiry on whether anyone has been looking at i9xx support
for intelfb? and to announce my intention to add support for CRT
modesetting on i915 and i945 chipsets to the intelfb driver

I've put a git tree with an i915fb branch

git://git.kernel.org/pub/scm/linux/kernel/git/airlied/intelfb-2.6.git

This contains my initial code to set mode on i9xx, it doesn't seem to
regress i8xx, but I haven't be able to test it on my i9xx hardware
yet, but it should give an idea of the direction I am headed in. I'll
be trying to get this finished in the next week or so...

The i915 also has integrated LVDS but I've no hw to test that on.

The code is based on my work for adding real modesetting to the i810 X driv=
er...

Dave.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
